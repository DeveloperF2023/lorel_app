import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_test_online/core/constants/app_assets.dart';
import 'package:school_test_online/core/constants/app_colors.dart';
import 'package:school_test_online/features/presentation/manager/user/upload_avatar/upload_avatar_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/helpers/locale_service.dart';
import '../../widgets/all_courses/widgets_imports.dart';
import '../../widgets/global/widgets_imports.dart';

class UploadAvatarScreen extends StatefulWidget {
  const UploadAvatarScreen({super.key});

  @override
  State<UploadAvatarScreen> createState() => _UploadAvatarScreenState();
}

class _UploadAvatarScreenState extends State<UploadAvatarScreen> {
  String profilePictureSaved = "";
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  void restartApp() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  fetchUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      profilePictureSaved = preferences.getString("profilePicture") ?? "";
    });
    print("profile picture $profilePictureSaved");
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveProfilePicture(String newPictureUrl) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("profilePicture", newPictureUrl);
    setState(() {
      profilePictureSaved = newPictureUrl;
    });
  }

  @override
  void initState() {
    fetchUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarAllCourses(
        title: AppLocalization.of(context)!.translate('uploadAvatar'),
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 90,
                    backgroundImage: (_profileImage != null &&
                            _profileImage!.path.isNotEmpty)
                        ? FileImage(_profileImage!)
                        : (profilePictureSaved.isNotEmpty
                            ? NetworkImage(profilePictureSaved)
                            : AssetImage(AppAssets.logo)),
                  ),
                  Positioned(
                      right: 5.w,
                      bottom: 10.h,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          height: 40.h,
                          width: 40.w,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryColor),
                          child: Center(
                            child: Icon(
                              Icons.upload,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ))
                ],
              )
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          BlocConsumer<UploadAvatarCubit, UploadAvatarState>(
            listener: (context, state) async {
              if (state is UploadAvatarFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(state.message),
                  ),
                );
              } else if (state is UploadAvatarLoaded) {
                await _saveProfilePicture(state.uploadAvatar);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    content: Text(AppLocalization.of(context)!
                        .translate("avatarUploaded")),
                  ),
                );
              } else if (state is UploadAvatarLoading) {
                const CircularProgressIndicator();
              }
            },
            builder: (context, state) {
              return PrimaryButton(
                textButton:
                    AppLocalization.of(context)!.translate('uploadAvatar'),
                onTap: () {
                  if (_profileImage != null) {
                    BlocProvider.of<UploadAvatarCubit>(context)
                        .uploadAvatarUser(avatar: _profileImage!.path);
                    context.read<UploadAvatarCubit>().loadAvatar();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(AppLocalization.of(context)!
                              .translate("selectImage"))),
                    );
                  }
                },
              );
            },
          )
        ],
      )),
    );
  }
}
