import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_test_online/core/constants/app_colors.dart';
import 'package:school_test_online/core/routes/routes.dart';
import 'package:school_test_online/core/utils/helpers/locale_service.dart';
import 'package:school_test_online/features/presentation/manager/chat/get_conversations/get_conversations_cubit.dart';
import 'package:school_test_online/features/presentation/widgets/chat/widgets_imports.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../dependencies_injection.dart';
import '../../widgets/global/widgets_imports.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGlobal(
        title: AppLocalization.of(context)!.translate("messages"),
        backgroundColor: AppColors.primaryColor,
        isActions: true,
        titleColor: Colors.white,
        backgroundColorBackButton: Colors.white,
        iconColor: AppColors.primaryColor,
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) =>
              locator<GetConversationsCubit>()..fetchConversations(),
          child: BlocBuilder<GetConversationsCubit, GetConversationsState>(
            builder: (context, state) {
              if (state is GetConversationsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetConversationsLoaded) {
                return Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: ListView.separated(
                    itemCount: state.conversations.length,
                    itemBuilder: (context, index) {
                      final conversations = state.conversations[index];
                      String lastMessageText = '';
                      if (conversations.lastMessage != null) {
                        lastMessageText =
                            conversations.lastMessage!.body != null
                                ? conversations.lastMessage!.body!
                                : conversations.lastMessage!.type!;
                      }
                      return ConversationsContent(
                          imageUrl: conversations.group?.formation?.image ??
                              'default_image_url.png',
                          groupName: conversations.group!.name!,
                          senderName: conversations.lastMessage != null
                              ? conversations.lastMessage!.user!.name!
                              : "",
                          lastMessage: lastMessageText,
                          timeLastMessage: conversations.lastMessage != null
                              ? conversations.lastMessage!.createdAt!
                              : "",
                          onFetchDetailConversation: () async {
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            int userId = preferences.getInt("userId")!;
                            if (context.mounted) {
                              Navigator.pushNamed(
                                context,
                                NavigationStrings.detailConversation,
                                arguments: {
                                  "conversationId": conversations.id,
                                  "groupName": conversations.group!.name!,
                                  "currentUser": userId,
                                },
                              );
                            } else {
                              debugPrint("User ID is null");
                            }
                          });
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                  ),
                );
              } else if (state is GetConversationsFailure) {
                return Center(child: Text(state.message));
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
