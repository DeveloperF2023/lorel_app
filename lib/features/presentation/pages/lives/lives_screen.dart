import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_test_online/core/utils/helpers/helper_functions.dart';
import 'package:school_test_online/core/utils/helpers/locale_service.dart';
import 'package:school_test_online/features/presentation/manager/lives/get_lives/get_lives_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/routes.dart';
import '../../../../dependencies_injection.dart';
import '../../widgets/detail_my_courses/widgets_imports.dart';
import '../../widgets/lives/widgets_imports.dart';

class LivesScreen extends StatelessWidget {
  const LivesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> openZoom(String zoomUrl) async {
      if (await canLaunchUrl(Uri.parse(zoomUrl))) {
        await launchUrl(Uri.parse(zoomUrl));
      } else {
        throw 'Could not launch Zoom';
      }
    }

    return Scaffold(
      appBar: AppBarDetailMyCourse(
        backgroundColor: AppColors.harp,
        title: AppLocalization.of(context)!.translate("lives"),
        onTap: () async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString("token");
          if (token != null) {
            Navigator.pushReplacementNamed(context, NavigationStrings.main,
                arguments: token);
          } else {
            debugPrint("Token it's null");
          }
        },
      ),
      body: SafeArea(
          child: BlocProvider(
        create: (context) => locator<GetLivesCubit>()..getLives(),
        child: BlocBuilder<GetLivesCubit, GetLivesState>(
          builder: (context, state) {
            if (state is GetLivesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetLivesLoaded) {
              final upcomingLives = state.lives.where((live) {
                final startTime = live.startTime;
                if (startTime == null) return false;
                final liveDateTime = DateTime.parse(startTime);
                final sixHoursLater =
                    DateTime.now().add(const Duration(hours: 6));
                return liveDateTime.isBefore(sixHoursLater);
              }).toList();
              return SizedBox(
                height: HelperFunctions.screenHeight(context) * .8,
                child: ListView.builder(
                  itemCount: upcomingLives.length,
                  itemBuilder: (context, index) {
                    final live = upcomingLives[index];
                    final zoomResponse = live.zoomResponse;

                    return LiveItem(
                      onFetchLives: () {
                        openZoom(zoomResponse?.data?.joinUrl ?? "");
                      },
                      lives: live,
                    );
                  },
                ),
              );
            } else if (state is GetLivesFailure) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      )),
    );
  }
}
