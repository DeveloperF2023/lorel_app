import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_test_online/core/routes/routes.dart';
import 'package:school_test_online/core/utils/helpers/helper_functions.dart';
import 'package:school_test_online/features/presentation/manager/notifications/get_notifications/get_notifications_cubit.dart';
import 'package:school_test_online/features/presentation/widgets/chat/custom_shimmer_loading.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../dependencies_injection.dart';
import '../../widgets/detail_my_courses/widgets_imports.dart';
import '../../widgets/notifications/widgets_imports.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarDetailMyCourse(
        backgroundColor: AppColors.harp,
        title: "Notifications",
      ),
      body: BlocProvider(
        create: (context) =>
            locator<GetNotificationsCubit>()..getNotifications(),
        child: BlocBuilder<GetNotificationsCubit, GetNotificationsState>(
          builder: (context, state) {
            if (state is GetNotificationsLoading) {
              return ListView.builder(
                  itemCount: 8,
                  padding: EdgeInsets.only(top: 10.h),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: 10.h, left: 10.w, right: 10.w),
                      child: CustomShimmer(
                          height: 80,
                          width: HelperFunctions.screenWidth(context).w),
                    );
                  });
            } else if (state is GetNotificationsLoaded) {
              final sortedNotifications = List.of(state.notifications)
                ..sort((a, b) => b.date!.compareTo(a.date!));
              return SizedBox(
                height: HelperFunctions.screenHeight(context) * .8.h,
                child: ListView.builder(
                    itemCount: sortedNotifications.length,
                    padding: const EdgeInsets.only(top: 10),
                    itemBuilder: (context, index) {
                      final notification = sortedNotifications[index];
                      return NotificationItem(
                        title: notification.title!,
                        description: notification.message!,
                        onTap: () {
                          notification.type == "lives"
                              ? Navigator.pushNamed(
                                  context, NavigationStrings.zoom)
                              : null;
                        },
                        dateTimeNotification: notification.date!,
                      );
                    }),
              );
            } else if (state is GetNotificationsFailure) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
