import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:school_test_online/core/constants/app_colors.dart';
import 'package:school_test_online/features/data/models/chat/message_model.dart';
import 'package:school_test_online/features/presentation/manager/chat/attach_file_to_conversation/attach_file_to_conversation_cubit.dart';
import 'package:school_test_online/features/presentation/manager/chat/get_messages/get_messages_cubit.dart';
import 'package:school_test_online/features/presentation/widgets/global/widgets_imports.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/helpers/locale_service.dart';
import '../../../../core/utils/helpers/pusher_service.dart';
import '../../../../dependencies_injection.dart';
import '../../../data/models/user/user_data_model.dart';
import '../../manager/chat/send_message/send_message_cubit.dart';
import '../../widgets/chat/add_options_model.dart';
import '../../widgets/chat/widgets_imports.dart';

class DetailConversationScreen extends StatefulWidget {
  final int conversationId;
  final String groupName;
  final int currentUser;
  const DetailConversationScreen(
      {super.key,
      required this.conversationId,
      required this.groupName,
      required this.currentUser});

  @override
  State<DetailConversationScreen> createState() =>
      _DetailConversationScreenState();
}

class _DetailConversationScreenState extends State<DetailConversationScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  bool _isTyping = false;
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  PusherService? pusherService;
  bool _isRecording = false;
  bool _isDragging = false;
  bool _cancelledRecording = false;
  double _dragOffset = 0.0;
  double _initialButtonSize = 40.0;
  double _expandedButtonSize = 50.0;
  String _recordingTime = "00:00";

  Timer? _timer;
  int _elapsedSeconds = 0;
  List<MessagesModel> messagesList = [];

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      setState(() {
        _isTyping = _textController.text.isNotEmpty;
      });
    });
    _initializeRecorder();
    initializePusher();
    _fetchMessages();
  }

  void _startTimer() {
    _elapsedSeconds = 0;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedSeconds += 1;
        _recordingTime = _formatTime(_elapsedSeconds);
      });
    });
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  @override
  void dispose() {
    _textController.dispose();
    _recorder.closeRecorder();
    _timer?.cancel();
    super.dispose();
  }

  Future<void> pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'txt'],
    );

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? name = preferences.getString("name");
    if (name == null) {
      print("Name not found in preferences");
      return;
    }

    if (result != null && result.files.single.path != null) {
      File documentFile = File(result.files.single.path!);

      final newMessage = MessagesModel(
        body: 'Document: ${result.files.single.name}',
        file: documentFile.path,
        type: 'file',
        user: UserDataModel(id: widget.currentUser, name: name),
      );

      setState(() {
        messagesList.add(newMessage);
      });

      if (result.files.single.extension?.toLowerCase() == 'pdf') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowDocumentPicked(
              pickedFile: documentFile,
              onSend: () async {
                await context.read<AttachFileToConversationCubit>().attachFile(
                      conversationId: widget.conversationId,
                      file: documentFile,
                      type: "file",
                    );
                Navigator.pop(context);

                // Refresh messages only after attaching the document
                _fetchMessages();
              },
            ),
          ),
        );
      } else {
        print("Non-PDF documents cannot be previewed.");
      }

      initializePusher(); // Initialize Pusher once if not already initialized
    } else {
      print("Document picking cancelled or file path is null");
    }
  }

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String name = preferences.getString("name")!;
    if (image != null) {
      File imageFile = File(image.path);
      print('image file ${imageFile}');
      final newMessage = MessagesModel(
        body: 'Image: ${image.name}',
        file: imageFile.path,
        type: 'image',
        user: UserDataModel(id: widget.currentUser, name: name),
      );

      setState(() {
        messagesList.add(newMessage);
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShowImagePicked(
            file: imageFile,
            onSend: () async {
              await context.read<AttachFileToConversationCubit>().attachFile(
                    conversationId: widget.conversationId,
                    file: imageFile,
                    type: "image",
                  );
              Navigator.pop(context);

              // Refresh messages only after attaching the image
              _fetchMessages();
            },
          ),
        ),
      );

      initializePusher(); // Ensure Pusher is initialized only once
    } else {
      print("Image picking cancelled");
    }
  }

  void _fetchMessages() {
    context
        .read<GetMessagesCubit>()
        .fetchMessages(conversationId: widget.conversationId);
  }

  void _showAddOptionsModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return AddOptionsModal(
          onAddDocument: () async {
            await pickDocument(); // Pick document when this option is tapped
          },
          onAddImage: () async {
            await pickImage(); // Pick image when this option is tapped
          },
          onAddText: () {},
        );
      },
    );
  }

  Future<void> _initializeRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }

    if (!_recorder.isRecording) {
      await _recorder.openRecorder();
    }
  }

  Future<void> _startRecording() async {
    if (!_isRecording) {
      try {
        setState(() {
          _isRecording = true;
          _cancelledRecording = false;
        });
        await _recorder.startRecorder(
          toFile: 'audio_message.aac', // Save file locally
          codec: Codec.aacADTS,
        );
        _startTimer();
      } catch (e) {
        print('Failed to start recording: $e');
      }
    }
  }

  Future<void> _stopRecording() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String name = preferences.getString("name")!;
    if (_isRecording) {
      try {
        final path = await _recorder.stopRecorder();
        _timer?.cancel();
        setState(() {
          _isRecording = false;
        });
        _recordingTime = "00:00";

        if (!_cancelledRecording) {
          if (path != null) {
            // Create a file from the path
            File audioFile = File(path);
            final newMessage = MessagesModel(
              body: 'Audio: ${audioFile.path}',
              file: audioFile.path,
              type: 'audio', // Define type accordingly
              user: UserDataModel(
                  id: widget.currentUser, name: name), // Change as necessary
            );

            setState(() {
              messagesList.add(newMessage);
            });
            // Send the audio file to the conversation
            context
                .read<AttachFileToConversationCubit>()
                .attachFile(
                    conversationId: widget.conversationId,
                    file: audioFile,
                    type: "audio")
                .whenComplete(() {
              print('Audio message sent successfully');
              _fetchMessages();
            });
          } else {
            print('Recording path is null');
          }
        }
      } catch (e) {
        print('Failed to stop recording: $e');
      }
    }
  }

  Future<void> _cancelRecording() async {
    if (_isRecording) {
      setState(() {
        _isRecording = false;
        _cancelledRecording = true;
      });
      _timer?.cancel();
      await _recorder.stopRecorder();
      _recordingTime = "00:00";
    }
  }

  Future<void> initializePusher() async {
    pusherService = PusherService("2d18b004034647ac52b3", "eu");
    pusherService!.subscribeToChannel('messages', {
      'conversations.messages.student.${widget.conversationId}': ''
    }, (event) {
      if (event != null) {
        print('Event name: ${event.eventName}');
        print('Event data: ${event.data}');
        final Map<String, dynamic> jsonData = jsonDecode(event.data!);
        final newMessage = MessagesModel.fromJson(jsonData);
        setState(() {
          messagesList.add(newMessage);
        });
        showNotification(
            "Message from ${newMessage.user!.name}", "${newMessage.body}");
      } else {
        print('Received null event');
      }
    });
  }

  Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'important_notifications',
      'Important Notifications',
      //icon: 'ic_notification',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'item id 2',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGlobal(
        title: widget.groupName.toUpperCase(),
        backgroundColor: AppColors.primaryColor,
        backgroundColorBackButton: Colors.white,
        iconColor: AppColors.primaryColor,
        titleColor: Colors.white,
        isActions: true,
      ),
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => locator<GetMessagesCubit>()
                ..fetchMessages(conversationId: widget.conversationId),
            ),
            BlocProvider(
              create: (context) => locator<SendMessageCubit>(),
            ),
            BlocProvider(
              create: (context) => locator<AttachFileToConversationCubit>(),
            ),
          ],
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<GetMessagesCubit, GetMessagesState>(
                  builder: (context, state) {
                    if (state is GetMessagesLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is GetMessagesLoaded) {
                      messagesList = state.messages as List<MessagesModel>;
                      return Stack(
                        children: [
                          Container(
                            color: AppColors.harp,
                            child: ListView.builder(
                              controller:
                                  _scrollController, // Attach ScrollController
                              padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                              itemCount: messagesList.length,
                              itemBuilder: (context, index) {
                                final message = messagesList[index];
                                final isCurrentUser =
                                    message.user!.id == widget.currentUser;
                                final isUserImage = message.user!.image == null;

                                return DetailMessageContent(
                                  userImage: !isUserImage
                                      ? message.user!.image!
                                      : "https://img.freepik.com/free-vector/illustration-user-avatar-icon_53876-5907.jpg?t=st=1726771228~exp=1726774828~hmac=757c7a1cc23720be1aa5f8bd0c019034cafa566dcbba246861e9c46d88fe5ca0&w=740",
                                  body: message.body ?? "",
                                  file: message.file ?? "",
                                  type: message.type ?? "",
                                  sender: message.user!.name!,
                                  createdAt: message.lastRead ?? "now",
                                  isCurrentUser: isCurrentUser,
                                  isUserImage: isUserImage,
                                );
                              },
                            ),
                          ),
                          Positioned(
                            right: 16,
                            bottom: 16,
                            child: SizedBox(
                              height: 40.h,
                              width: 40.w,
                              child: FloatingActionButton(
                                onPressed: () {
                                  _scrollController.animateTo(
                                    _scrollController.position.maxScrollExtent,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeOut,
                                  );
                                },
                                backgroundColor: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.r)),
                                child: Icon(
                                  Icons.keyboard_double_arrow_down,
                                  color: Colors.white,
                                  size: 18.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else if (state is GetMessagesFailure) {
                      return Center(child: Text(state.message));
                    }
                    return Container();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0.w),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: _showAddOptionsModal,
                      child: Container(
                        height: 35.h,
                        width: 35.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: _isRecording
                          ? Row(
                              children: [
                                const Icon(Icons.mic, color: Colors.red),
                                SizedBox(width: 10.w),
                                Text(
                                  _recordingTime,
                                  style: const TextStyle(color: Colors.red),
                                ),
                                _isDragging
                                    ? const Text(
                                        'Slide to cancel',
                                        style: TextStyle(color: Colors.red),
                                      )
                                    : Container(),
                              ],
                            )
                          : TextField(
                              controller: _textController,
                              decoration: InputDecoration(
                                hintText: AppLocalization.of(context)!
                                    .translate('writeSomething'),
                                hintStyle: GoogleFonts.poppins(
                                    fontSize: 14.sp, color: AppColors.dawn),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16.0.w),
                              ),
                            ),
                    ),
                    BlocBuilder<SendMessageCubit, SendMessageState>(
                      builder: (context, state) {
                        return GestureDetector(
                          onHorizontalDragUpdate: (details) {
                            setState(() {
                              _dragOffset += details.delta.dx;
                              if (_dragOffset < -100) {
                                _isDragging = true;
                              }
                            });
                          },
                          onHorizontalDragEnd: (details) {
                            if (_dragOffset < -100) {
                              _cancelRecording();
                            } else {
                              _stopRecording();
                            }
                            setState(() {
                              _dragOffset = 0.0;
                              _isDragging = false;
                            });
                          },
                          onLongPressStart: (_) async {
                            await _startRecording();
                          },
                          onLongPressEnd: (_) async {
                            if (_isDragging) {
                              await _cancelRecording();
                            } else {
                              await _stopRecording();
                            }
                          },
                          onTap: _isTyping
                              ? () async {
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  final name = preferences.getString("name");
                                  context
                                      .read<SendMessageCubit>()
                                      .sendMessage(
                                        conversationId: widget.conversationId,
                                        content: _textController.text,
                                      )
                                      .then((_) {
                                    // Append the newly sent message to the local list
                                    setState(() {
                                      messagesList.add(MessagesModel(
                                        body: _textController.text,
                                        user: UserDataModel(
                                            id: widget.currentUser, name: name),
                                      ));
                                      _textController.clear();
                                    });

                                    initializePusher(); // Reinitialize Pusher to listen for updates
                                  });
                                }
                              : null,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            height: _isRecording
                                ? _expandedButtonSize
                                : _initialButtonSize,
                            width: _isRecording
                                ? _expandedButtonSize
                                : _initialButtonSize,
                            decoration: BoxDecoration(
                              color: _isRecording ? Colors.red : Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              _isTyping
                                  ? Icons.send
                                  : (_isRecording
                                      ? Icons.mic
                                      : Icons
                                          .mic), // Change the icon based on the state
                              color: Colors.white,
                              size: 20.sp,
                            ),
                          ),
                        );
                      },
                    ),
                    StreamBuilder<void>(
                      stream:
                          context.read<SendMessageCubit>().messageSentStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          _fetchMessages();
                        }
                        return Container(); // Empty container
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
