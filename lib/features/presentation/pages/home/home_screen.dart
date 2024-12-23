import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_test_online/core/routes/routes.dart';
import 'package:school_test_online/dependencies_injection.dart';
import 'package:school_test_online/features/presentation/manager/lives/get_lives/get_lives_cubit.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/helpers/helper_functions.dart';
import '../../../../core/utils/helpers/locale_service.dart';
import '../../widgets/home/widgets_imports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isClosed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: HelperFunctions.screenHeight(context) * .86.h,
            width: HelperFunctions.screenWidth(context).w,
            color: AppColors.primaryColor,
          ),
          if (!isClosed) _buildLivesNotification(context),
          _buildHomeHeader(context),
          _buildMainContent(context),
        ],
      ),
    );
  }

  // Simplify and optimize the lives notification widget
  Widget _buildLivesNotification(BuildContext context) {
    return Positioned(
      top: 10,
      left: 10,
      right: 10,
      child: BlocProvider(
        create: (context) => locator<GetLivesCubit>()..getLives(),
        child: BlocBuilder<GetLivesCubit, GetLivesState>(
          builder: (context, state) {
            if (state is GetLivesLoaded && state.lives.isNotEmpty) {
              final upcomingLives = state.lives.where((live) {
                final startTime = live.startTime;
                if (startTime == null) return false;
                final liveDateTime = DateTime.parse(startTime);
                final sixHoursLater =
                    DateTime.now().add(const Duration(hours: 6));
                return liveDateTime.isBefore(sixHoursLater);
              }).toList();
              if (upcomingLives.isNotEmpty) {
                return GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, NavigationStrings.lives),
                  child: _buildNotificationBox(upcomingLives.length),
                );
              }
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  // Reusable widget for notification box
  Widget _buildNotificationBox(int upcomingLivesCount) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.notifications,
                    color: AppColors.primaryColor, size: 15.sp),
                SizedBox(width: 10.w),
                Text(
                  "${AppLocalization.of(context)!.translate("livesExist")}: $upcomingLivesCount",
                  style: GoogleFonts.robotoCondensed(
                    fontSize: HelperFunctions.screenWidth(context) == 384.0
                        ? 15.sp
                        : 13.sp,
                    color: AppColors.blackCow,
                  ),
                ),
              ],
            ),
            SizedBox(width: 10.w),
            GestureDetector(
              onTap: () {
                setState(() {
                  isClosed = !isClosed;
                });
              },
              child: Icon(Icons.close, color: Colors.black, size: 15.sp),
            ),
          ],
        ),
      ),
    );
  }

  // Header widget for Home Screen
  Widget _buildHomeHeader(BuildContext context) {
    return Positioned(
      top: 35.h,
      left: AppLocalization.of(context)!.isArabicSelected(context) ? 10.w : 0.w,
      right:
          AppLocalization.of(context)!.isArabicSelected(context) ? 0.w : 10.w,
      child: Padding(
        padding: EdgeInsets.only(right: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              AppLocalization.of(context)!.translate('home'),
              style: GoogleFonts.robotoCondensed(
                  fontSize: 24.sp, color: Colors.white),
            ),
            SizedBox(width: 95.w),
            GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, NavigationStrings.notification),
              child: const Icon(Icons.notifications, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  // Main content area of the Home Screen
  Widget _buildMainContent(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: HelperFunctions.screenHeight(context) >= 840.17
            ? HelperFunctions.screenHeight(context) * .62.h
            : HelperFunctions.screenHeight(context) * .65.h,
        width: HelperFunctions.screenWidth(context).w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30.r),
            topLeft: Radius.circular(30.r),
          ),
        ),
        child: const HomeContent(),
      ),
    );
  }
}
