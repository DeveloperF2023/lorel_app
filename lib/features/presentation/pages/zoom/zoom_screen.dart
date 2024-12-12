import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_test_online/core/constants/app_assets.dart';
import 'package:school_test_online/core/utils/helpers/helper_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/routes.dart';
import '../../widgets/detail_my_courses/widgets_imports.dart';
import '../../widgets/my_courses/widgets_imports.dart';

class ZoomScreen extends StatefulWidget {
  final String joinUrl1;
  final String joinUrl2;
  final int formationId;

  const ZoomScreen(
      {super.key,
      required this.joinUrl1,
      required this.joinUrl2,
      required this.formationId});

  @override
  State<ZoomScreen> createState() => _ZoomScreenState();
}

class _ZoomScreenState extends State<ZoomScreen> {
  Future<void> openZoom1() async {
    if (await canLaunchUrl(Uri.parse(widget.joinUrl1))) {
      await launchUrl(Uri.parse(widget.joinUrl1));
    } else if (await canLaunchUrl(Uri.parse(widget.joinUrl1))) {
      await launchUrl(Uri.parse(widget.joinUrl1));
    } else {
      throw 'Could not launch Zoom';
    }
  }

  Future<void> openZoom2() async {
    if (await canLaunchUrl(Uri.parse(widget.joinUrl2))) {
      await launchUrl(Uri.parse(widget.joinUrl2));
    } else if (await canLaunchUrl(Uri.parse(widget.joinUrl2))) {
      await launchUrl(Uri.parse(widget.joinUrl2));
    } else {
      throw 'Could not launch Zoom';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lavendarBlush,
      appBar: AppBarDetailMyCourse(
        backgroundColor: AppColors.harp,
        title: "Zoom lives",
        onTap: () async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString("token");
          if (token != null && context.mounted) {
            Navigator.pushReplacementNamed(context, NavigationStrings.main,
                arguments: token);
          } else {
            debugPrint("Token it's null ");
          }
        },
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: HelperFunctions.screenHeight(context) * .3.h),
            child: Column(
              children: [
                Image.asset(AppAssets.zoom),
                SizedBox(
                  height: 15.h,
                ),
                widget.joinUrl1.isNotEmpty
                    ? GestureDetector(
                        onTap: openZoom1,
                        child: Container(
                          height: 50.h,
                          margin: EdgeInsets.symmetric(horizontal: 55.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.r),
                              color: AppColors.blueDeFrance),
                          child: Center(
                            child: Text(
                              "Lancement de live 1",
                              style: GoogleFonts.poppins(
                                  fontSize: 20.sp, color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 10.h,
                ),
                widget.joinUrl2.isNotEmpty
                    ? GestureDetector(
                        onTap: openZoom2,
                        child: Container(
                          height: 50.h,
                          margin: EdgeInsets.symmetric(horizontal: 55.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.r),
                              color: AppColors.blueDeFrance),
                          child: Center(
                            child: Text(
                              "Lancement de live 2",
                              style: GoogleFonts.poppins(
                                  fontSize: 20.sp, color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 65.h,
              color: AppColors.linkWater,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NavigationMyCourses(
                      onNavigate: () {
                        Navigator.pushNamed(
                            context, NavigationStrings.myCourses);
                      },
                      isBack: true,
                    ),
                    NavigationMyCourses(
                      onNavigate: () {
                        Navigator.pushNamed(
                            context, NavigationStrings.requestDiploma,
                            arguments: widget.formationId);
                      },
                      isBack: false,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
