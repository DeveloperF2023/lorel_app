import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/helpers/helper_functions.dart';
import '../../../../core/utils/helpers/locale_service.dart';
import '../../../../dependencies_injection.dart';
import '../../manager/courses/get_courses_by_status/get_courses_by_status_cubit.dart';
import '../../manager/courses/toggle_buttons/toggle_buttons_cubit.dart';
import '../../manager/user/update_profile/update_profile_cubit.dart';
import '../../widgets/global/widgets_imports.dart';
import '../../widgets/my_courses/widgets_imports.dart';

class MyCoursesScreen extends StatefulWidget {
  const MyCoursesScreen({super.key});

  @override
  State<MyCoursesScreen> createState() => _MyCoursesScreenState();
}

class _MyCoursesScreenState extends State<MyCoursesScreen> {
  String nameUser = "";
  List<bool> isSelected = [true, false];
  String status = 'in_progress';

  Future<void> initializeScreen() async {
    await fetchUserName();
    context
        .read<GetCoursesByStatusCubit>()
        .fetchCoursesByStatus(status: status);
  }

  ///Function to fetch user name
  Future<void> fetchUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nameUser = preferences.getString("name") ?? "User";
    });
  }

  @override
  void initState() {
    initializeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => locator<GetCoursesByStatusCubit>()
              ..fetchCoursesByStatus(status: "in_progress"),
          ),
          BlocProvider(
            create: (context) => ToggleButtonsCubit()..toggleButton(0),
          ),
        ],
        child: Container(
          height: HelperFunctions.screenHeight(context),
          width: HelperFunctions.screenWidth(context),
          decoration: BoxDecoration(
            gradient: AppColors.gradient2,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BackButtonWidget(onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      final token = prefs.getString("token");
                      if (token != null) {
                        Navigator.pushReplacementNamed(
                            context, NavigationStrings.main,
                            arguments: token);
                      } else {
                        debugPrint("Token it's null ");
                      }
                    }),
                    Text(
                      AppLocalization.of(context)!.translate('myFormations'),
                      style: GoogleFonts.poppins(
                        fontSize: 22.sp,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, NavigationStrings.notification);
                      },
                      child: const Icon(
                        Icons.notifications,
                        color: AppColors.davyGrey,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: AppLocalization.of(context)!.isArabicSelected(context)
                      ? 0.w
                      : 10.w,
                  right: AppLocalization.of(context)!.isArabicSelected(context)
                      ? 10.w
                      : 0.w,
                ),
                child: Row(
                  children: [
                    Text(
                      "${AppLocalization.of(context)!.translate('welcome')} ",
                      style: GoogleFonts.robotoCondensed(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
                      builder: (context, state) {
                        String name;
                        if (state is UpdateProfileLoaded) {
                          if (state.updateUserProfile.user!.name!.isNotEmpty) {
                            name = state.updateUserProfile.user!.name!;
                          } else {
                            name = "";
                          }
                        } else {
                          name = nameUser;
                        }
                        return Text(
                          name,
                          style: GoogleFonts.roboto(
                              fontSize: 23.sp, fontWeight: FontWeight.w300),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              const ToggleButtonsWidget(),
              SizedBox(
                height: 15.h,
              ),
              Expanded(
                child: BlocBuilder<GetCoursesByStatusCubit,
                    GetCoursesByStatusState>(
                  builder: (context, state) {
                    if (state is GetCoursesByStatusLoading) {
                      return const Center(
                          child: CircularProgressIndicator(
                              color: AppColors.primaryColor));
                    } else if (state is GetCoursesByStatusFailure) {
                      return Center(child: Text('Error: ${state.message}'));
                    } else if (state is GetCoursesByStatusLoaded) {
                      if (state.coursesByStatus.isNotEmpty) {
                        return Container(
                          width: HelperFunctions.screenWidth(context).w,
                          margin: EdgeInsets.only(
                              left: 20.w, bottom: 10.h, right: 20.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(color: Colors.white),
                            color: AppColors.jungleMist.withValues(alpha: 0.5),
                          ),
                          child: ListView.builder(
                            itemCount: state.coursesByStatus.length,
                            itemBuilder: (context, index) {
                              final course = state.coursesByStatus[index];
                              return MyCoursesContent(
                                onTap: () {
                                  if (course.currentCourse != null ||
                                      course.currentCourse == null) {
                                    Navigator.pushNamed(
                                      context,
                                      NavigationStrings.coursesList,
                                      arguments: {
                                        "formationId": course.id,
                                        "status": course.status
                                      },
                                    );
                                  } else {
                                    if (course.status == "finished") {
                                      Navigator.pushNamed(
                                        context,
                                        NavigationStrings.finishedCourse,
                                        arguments: {
                                          "formationId": course.id,
                                        },
                                      );
                                    }
                                  }
                                },
                                myCourses: course,
                              );
                            },
                          ),
                        );
                      } else {
                        return const MyCoursesNotFound();
                      }
                    } else {
                      return Center(
                        child: Text(
                          AppLocalization.of(context)!
                              .translate('noCoursesFound'),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  void _showMyDialog(BuildContext context, String formation) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title:
              "${AppLocalization.of(context)!.translate("courseNotFoundYet")} $formation",
          content: AppLocalization.of(context)!
              .translate("messageErrorCourseNotFound"),
          confirmText: AppLocalization.of(context)!.translate("cancel"),
          onConfirm: () {
            Navigator.of(context).pop(); // Dismiss the dialog
            // Perform any action after confirmation
          },
        );
      },
    );
  }
}
