import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_test_online/features/presentation/manager/user/update_profile/update_profile_cubit.dart';
import 'package:school_test_online/features/presentation/pages/settings/settings_screen.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/helpers/locale_service.dart';
import '../../../../core/utils/helpers/validators.dart';
import '../../widgets/all_courses/widgets_imports.dart';
import '../../widgets/global/widgets_imports.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarAllCourses(
        title: AppLocalization.of(context)!.translate('updateProfile'),
        onTap: () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SettingsScreen())),
      ),
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: TextFormField(
                controller: nameController,
                validator: (value) => Validators.nameValidator(value, context),
                decoration: InputDecoration(
                  hintText: AppLocalization.of(context)!.translate('lastName'),
                  contentPadding: EdgeInsets.only(top: 20.h),
                  hintStyle: GoogleFonts.poppins(
                      color: AppColors.nobel, fontSize: 14.sp),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: Icon(
                      Icons.person,
                      color: AppColors.nobel,
                      size: 12.sp,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.w, right: 30.w),
              child: TextFormField(
                controller: addressController,
                validator: (value) =>
                    Validators.addressValidator(value, context),
                decoration: InputDecoration(
                  hintText: AppLocalization.of(context)!.translate('address'),
                  contentPadding: EdgeInsets.only(top: 20.h),
                  hintStyle: GoogleFonts.poppins(
                      color: AppColors.nobel, fontSize: 14.sp),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: Icon(
                      Icons.location_city,
                      color: AppColors.nobel,
                      size: 12.sp,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.w, right: 30.w),
              child: TextFormField(
                controller: phoneController,
                validator: (value) => Validators.phoneValidator(value, context),
                decoration: InputDecoration(
                  hintText: AppLocalization.of(context)!.translate('phone'),
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
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.w, right: 30.w),
              child: TextFormField(
                controller: countryController,
                validator: (value) =>
                    Validators.countryValidator(value, context),
                decoration: InputDecoration(
                  hintText: AppLocalization.of(context)!.translate('country'),
                  contentPadding: EdgeInsets.only(top: 20.h),
                  hintStyle: GoogleFonts.poppins(
                      color: AppColors.nobel, fontSize: 14.sp),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: Icon(
                      Icons.location_on_rounded,
                      color: AppColors.nobel,
                      size: 12.sp,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
              listener: (context, state) {
                if (state is UpdateProfileFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text("Some errors occurred please try later")),
                  );
                } else if (state is UpdateProfileLoaded) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(AppLocalization.of(context)!
                            .translate('successUpdateProfile'))),
                  );
                }
              },
              builder: (context, state) {
                return PrimaryButton(
                  textButton:
                      AppLocalization.of(context)!.translate('updateProfile'),
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<UpdateProfileCubit>(context)
                          .updateProfileUser(
                              name: nameController.text,
                              address: addressController.text,
                              phone: phoneController.text,
                              country: countryController.text);
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
          ],
        ),
      )),
    );
  }
}
