import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_test_online/core/constants/app_colors.dart';

import '../../../../dependencies_injection.dart';
import '../../manager/courses/get_detail_course/get_detail_course_cubit.dart';
import '../../widgets/detail_my_courses/widgets_imports.dart';

class DetailMyCoursesScreen extends StatelessWidget {
  final int formationId;
  final int courseId;
  final String title;
  const DetailMyCoursesScreen(
      {super.key,
      required this.formationId,
      required this.courseId,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lavendarBlush,
      appBar: AppBarDetailMyCourse(
        backgroundColor: AppColors.harp,
        title: title,
      ),
      body: SafeArea(
          child: BlocProvider(
        create: (context) => locator<GetDetailCourseCubit>()
          ..fetchDetailCourse(courseId: courseId, formationId: formationId),
        child: BlocBuilder<GetDetailCourseCubit, GetDetailCourseState>(
          builder: (context, state) {
            if (state is GetDetailCourseLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetDetailCourseLoaded) {
              return DetailMyCourseContent(
                detailCourse: state.detailCourse,
              );
            } else if (state is GetDetailCourseFailure) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      )),
    );
  }
}
