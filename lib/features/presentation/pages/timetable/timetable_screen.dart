import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_test_online/core/constants/app_colors.dart';
import 'package:school_test_online/features/presentation/manager/timetable/get_schedule/get_schedule_cubit.dart';
import 'package:school_test_online/features/presentation/widgets/global/widgets_imports.dart';
import 'package:school_test_online/features/presentation/widgets/timetable/widgets_imports.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/utils/helpers/locale_service.dart';

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key});

  @override
  _TimetableScreenState createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  int currentSemIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.aliceBlue,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(
              left: !AppLocalization.of(context)!.isArabicSelected(context)
                  ? 10.w
                  : 0.w,
              right: AppLocalization.of(context)!.isArabicSelected(context)
                  ? 10.w
                  : 0.w),
          child: BackButtonWidget(
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
        ),
        title: Text(
          AppLocalization.of(context)!.translate('timetable'),
          style: GoogleFonts.robotoCondensed(
              fontSize: 22.sp, color: AppColors.sapphireBlue),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, NavigationStrings.notification);
              },
              icon: const Icon(
                Icons.notifications,
                color: AppColors.davyGrey,
              ))
        ],
      ),
      body: BlocBuilder<GetScheduleCubit, GetScheduleState>(
        builder: (context, state) {
          if (state is GetScheduleInitial) {
            context.read<GetScheduleCubit>().fetchSchedule("1");
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetScheduleLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetScheduleLoaded) {
            final schedules = state.schedules;
            final semKeys = schedules.keys.toList();

            if (semKeys.isEmpty) {
              return Center(
                  child: Text(
                AppLocalization.of(context)!.translate('noSchedule'),
              ));
            }

            final currentSemKey = semKeys[currentSemIndex];
            final weekNumberMatch =
                RegExp(r'week_(\d+)').firstMatch(currentSemKey);
            final weekNumber =
                weekNumberMatch != null ? weekNumberMatch.group(1) : '';
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.sapphireBlue.withOpacity(0.6),
                        size: 20.sp,
                      ),
                      onPressed: currentSemIndex > 0
                          ? () => setState(() => currentSemIndex--)
                          : null,
                    ),
                    Text(
                      '${AppLocalization.of(context)!.translate(weekNumber!.isNotEmpty ? 'week' : 'sem')} $weekNumber',
                      style: GoogleFonts.robotoCondensed(
                          color: AppColors.sapphireBlue.withOpacity(0.6),
                          fontSize: 20.sp),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: AppColors.sapphireBlue.withOpacity(0.6),
                        size: 20.sp,
                      ),
                      onPressed: currentSemIndex < semKeys.length - 1
                          ? () => setState(() => currentSemIndex++)
                          : null,
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: schedules[currentSemKey]!.length,
                    itemBuilder: (context, index) {
                      final weekSchedules = schedules[currentSemKey]![index];
                      debugPrint("Week Schedule: ${weekSchedules.group}");
                      debugPrint("Teacher: ${weekSchedules.group?.teacher}");
                      debugPrint(
                          "Teacher Name: ${weekSchedules.group?.teacher?.name}");

                      final group = weekSchedules.group;
                      final teacher = group?.teacher;
                      final teacherName =
                          teacher?.name ?? 'No teacher assigned';
                      return ScheduleItem(
                        day: weekSchedules.day ?? 'Unknown day',
                        courseName:
                            weekSchedules.formation?.title ?? 'Unknown course',
                        startTime: weekSchedules.start ?? 'Start time missing',
                        endTime: weekSchedules.end ?? 'End time missing',
                        domainName: weekSchedules.formation?.domain?.title ??
                            'Unknown domain',
                        teacher: teacherName, // Safely handle null teacher name
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is GetScheduleFailure) {
            return Center(child: Text(state.message));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
