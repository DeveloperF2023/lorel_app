import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_test_online/core/constants/app_colors.dart';
import 'package:school_test_online/core/utils/helpers/helper_functions.dart';
import 'package:school_test_online/core/utils/helpers/locale_service.dart';
import 'package:school_test_online/core/utils/helpers/validators.dart';
import 'package:school_test_online/features/presentation/widgets/global/widgets_imports.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/routes/routes.dart';
import '../../../data/models/request_diploma/request_diploma_model.dart';
import '../../manager/request_diploma/request_diploma_cubit.dart';
import '../../widgets/request_diploma/widgets_imports.dart';

class RequestDiplomaScreen extends StatefulWidget {
  final int formationId;
  const RequestDiplomaScreen({super.key, required this.formationId});

  @override
  State<RequestDiplomaScreen> createState() => _RequestDiplomaScreenState();
}

class _RequestDiplomaScreenState extends State<RequestDiplomaScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController cinController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      // Format date as yyyy-MM-dd
      final formattedDate =
          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      setState(() {
        birthdayController.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RequestDiplomaCubit, RequestDiplomaState>(
        listener: (context, state) {
          if (state is RequestDiplomaFailure) {
            _showErrorDialog(state.message);
          } else if (state is RequestDiplomaLoaded) {
            Navigator.pushNamed(
                context, NavigationStrings.successRequestDiploma);
          }
        },
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                height: HelperFunctions.screenHeight(context).h,
                width: HelperFunctions.screenWidth(context),
                color: AppColors.secondaryGeyser,
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: HelperFunctions.screenHeight(context) * .2.h,
                  width: HelperFunctions.screenWidth(context),
                  decoration: BoxDecoration(
                    color: AppColors.titanWhite,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10.r,
                          offset: const Offset(0, 1))
                    ],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.r),
                      bottomRight: Radius.circular(30.r),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10.w, top: 5.h),
                        child: BackButtonWidget(
                          onTap: () => Navigator.pushReplacementNamed(
                              context, NavigationStrings.myCourses),
                        ),
                      ),
                      SizedBox(
                        width: HelperFunctions.screenWidth(context) * .2.w,
                      ),
                      Column(
                        children: [
                          Image.asset(AppAssets.logo),
                          Text(
                            "LOREL",
                            style: GoogleFonts.jacquesFrancois(
                              fontSize:
                                  HelperFunctions.screenWidth(context) == 384.0
                                      ? 32.sp
                                      : 26.sp,
                              color: AppColors.astronautBlue,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                top: HelperFunctions.screenHeight(context) * .2.h,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 30.h),
                          Text(
                            AppLocalization.of(context)!
                                .translate("certificateRequest"),
                            style: GoogleFonts.robotoCondensed(
                              fontSize: 26.sp,
                              color: AppColors.darkerGrey,
                            ),
                          ),
                          SizedBox(height: 15.h),
                          TextFieldRequest(
                            label:
                                "${AppLocalization.of(context)!.translate("lastName")} : ",
                            controller: firstNameController,
                            validator: (value) =>
                                Validators.nameValidator(value, context),
                          ),
                          SizedBox(height: 15.h),
                          TextFieldRequest(
                            label:
                                "${AppLocalization.of(context)!.translate("firstName")} :",
                            controller: lastNameController,
                            validator: (value) =>
                                Validators.lastNameValidator(value, context),
                          ),
                          SizedBox(height: 15.h),
                          TextFieldRequest(
                            label:
                                "${AppLocalization.of(context)!.translate("phone")} :",
                            controller: phoneController,
                            validator: (value) =>
                                Validators.phoneValidator(value, context),
                            keyboardType: TextInputType.phone,
                          ),
                          SizedBox(height: 15.h),
                          TextFieldRequest(
                            label:
                                "${AppLocalization.of(context)!.translate("address")} : ",
                            controller: addressController,
                            validator: (value) =>
                                Validators.addressValidator(value, context),
                          ),
                          SizedBox(height: 15.h),
                          GestureDetector(
                            onTap: () => _selectDate(context),
                            child: AbsorbPointer(
                              child: TextFieldRequest(
                                label:
                                    "${AppLocalization.of(context)!.translate("birthday")} : ",
                                controller: birthdayController,
                                validator: (value) =>
                                    Validators.birthdayValidator(
                                        value, context),
                              ),
                            ),
                          ),
                          SizedBox(height: 15.h),
                          TextFieldRequest(
                            label:
                                "${AppLocalization.of(context)!.translate("id")} : ",
                            controller: cinController,
                            validator: (value) =>
                                Validators.cinValidator(value, context),
                          ),
                          SizedBox(height: 15.h),
                          GestureDetector(
                            onTap: _requestDiploma,
                            child: Container(
                              height: 35.h,
                              width:
                                  HelperFunctions.screenWidth(context) * .4.w,
                              decoration: BoxDecoration(
                                color: AppColors.midBlue,
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              child: Center(
                                child: Text(
                                  AppLocalization.of(context)!
                                      .translate("request"),
                                  style: GoogleFonts.robotoCondensed(
                                    fontSize: 18.sp,
                                    color: AppColors.lightGrey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _requestDiploma() {
    final requests = RequestDiplomaModel(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      phone: phoneController.text,
      address: addressController.text,
      birth: birthdayController.text,
      identity: cinController.text,
    );
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<RequestDiplomaCubit>(context)
          .requestDiploma(requests: requests, formationId: widget.formationId);
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
