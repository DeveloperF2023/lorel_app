import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_test_online/features/presentation/manager/user/update_password/update_password_cubit.dart';
import 'package:school_test_online/features/presentation/pages/settings/settings_screen.dart';
import 'package:school_test_online/features/presentation/widgets/all_courses/widgets_imports.dart';
import 'package:school_test_online/features/presentation/widgets/global/widgets_imports.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/helpers/locale_service.dart';
import '../../../../core/utils/helpers/validators.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  TextEditingController oldPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmationPasswordController =
      TextEditingController();
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarAllCourses(
        title: AppLocalization.of(context)!.translate('updatePassword'),
        onTap: () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const SettingsScreen())),
      ),
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: Column(children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: TextFormField(
              controller: oldPassword,
              validator: (value) =>
                  Validators.passwordValidator(value, context),
              decoration: InputDecoration(
                  hintText:
                      AppLocalization.of(context)!.translate('oldPassword'),
                  contentPadding: EdgeInsets.only(top: 20.h),
                  hintStyle: GoogleFonts.poppins(
                      color: AppColors.nobel, fontSize: 14.sp),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: Icon(
                      Icons.lock,
                      color: AppColors.nobel,
                      size: 12.sp,
                    ),
                  ),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isShow = !isShow;
                        });
                      },
                      child: Icon(
                        !isShow
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash,
                        color: AppColors.nobel,
                        size: 14.sp,
                      ),
                    ),
                  )),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: TextFormField(
              controller: newPasswordController,
              validator: (value) =>
                  Validators.passwordValidator(value, context),
              obscureText: isShow ? true : false,
              decoration: InputDecoration(
                  hintText:
                      AppLocalization.of(context)!.translate('newPassword'),
                  contentPadding: EdgeInsets.only(top: 20.h),
                  hintStyle: GoogleFonts.poppins(
                      color: AppColors.nobel, fontSize: 14.sp),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: Icon(
                      Icons.lock,
                      color: AppColors.nobel,
                      size: 12.sp,
                    ),
                  ),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isShow = !isShow;
                        });
                      },
                      child: Icon(
                        !isShow
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash,
                        color: AppColors.nobel,
                        size: 14.sp,
                      ),
                    ),
                  )),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: TextFormField(
              controller: confirmationPasswordController,
              validator: (value) =>
                  Validators.passwordValidator(value, context),
              obscureText: isShow ? true : false,
              decoration: InputDecoration(
                  hintText: AppLocalization.of(context)!
                      .translate('confirmationPassword'),
                  contentPadding: EdgeInsets.only(top: 20.h),
                  hintStyle: GoogleFonts.poppins(
                      color: AppColors.nobel, fontSize: 14.sp),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: Icon(
                      Icons.lock,
                      color: AppColors.nobel,
                      size: 12.sp,
                    ),
                  ),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isShow = !isShow;
                        });
                      },
                      child: Icon(
                        !isShow
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash,
                        color: AppColors.nobel,
                        size: 14.sp,
                      ),
                    ),
                  )),
            ),
          ),
          SizedBox(
            height: 50.h,
          ),
          BlocConsumer<UpdatePasswordCubit, UpdatePasswordState>(
            listener: (context, state) {
              if (state is UpdatePasswordFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("Old Password is incorrect")),
                );
              } else if (state is UpdatePasswordLoaded) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      backgroundColor: Colors.green,
                      content: Text(AppLocalization.of(context)!
                          .translate('successUpdatePassword'))),
                );
              }
            },
            builder: (context, state) {
              return PrimaryButton(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    BlocProvider.of<UpdatePasswordCubit>(context)
                        .updatePasswordUser(
                            oldPassword: oldPassword.text,
                            password: newPasswordController.text,
                            confirmationPassword:
                                confirmationPasswordController.text);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(AppLocalization.of(context)!
                              .translate("requiredFields"))),
                    );
                  }
                },
              );
            },
          )
        ]),
      )),
    );
  }
}
