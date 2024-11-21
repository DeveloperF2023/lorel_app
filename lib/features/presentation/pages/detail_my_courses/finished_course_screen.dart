import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_test_online/core/routes/routes.dart';
import 'package:school_test_online/features/presentation/manager/courses/get_courses_of_formation/get_courses_of_formation_cubit.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/helpers/locale_service.dart';
import '../../../../dependencies_injection.dart';
import '../../widgets/detail_my_courses/widgets_imports.dart';

class FinishedCourseScreen extends StatefulWidget {
  final int formationId;

  const FinishedCourseScreen({super.key, required this.formationId});

  @override
  State<FinishedCourseScreen> createState() => _FinishedCourseScreenState();
}

class _FinishedCourseScreenState extends State<FinishedCourseScreen> {
  int currentIndex = 0;
  void _nextCourse(List courses) {
    if (currentIndex < courses.length - 1) {
      setState(() {
        currentIndex++;
      });
    }
  }

  void _previousCourse(List courses) {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lavendarBlush,
      appBar: const AppBarDetailMyCourse(
        backgroundColor: AppColors.harp,
        title: "My courses",
      ),
      body: SafeArea(
          child: BlocProvider(
        create: (context) => locator<GetCoursesOfFormationCubit>()
          ..fetchCoursesOfFormation(formationId: widget.formationId),
        child:
            BlocBuilder<GetCoursesOfFormationCubit, GetCoursesOfFormationState>(
          builder: (context, state) {
            if (state is GetCoursesOfFormationLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetCoursesOfFormationLoaded) {
              final courses = state.courses;
              if (courses.isEmpty) {
                return const Center(child: Text('No courses available.'));
              }
              final currentCourse = courses[currentIndex];
              print("Courses $currentCourse");
              return DetailMyCourseContent(
                detailCourse: currentCourse,
                onNext: currentIndex < courses.length - 1
                    ? () {
                        _nextCourse(courses);
                        print("Courses id:${currentCourse.id}");
                      }
                    : () {
                        Navigator.pushNamed(
                            context, NavigationStrings.requestDiploma,
                            arguments: widget.formationId);
                      },
                onPrevious:
                    currentIndex > 0 ? () => _previousCourse(courses) : null,
                nextText: currentIndex < courses.length - 1
                    ? AppLocalization.of(context)!.translate("next")
                    : AppLocalization.of(context)!.translate("finished"),
              );
            } else if (state is GetCoursesOfFormationFailure) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      )),
    );
  }
}
