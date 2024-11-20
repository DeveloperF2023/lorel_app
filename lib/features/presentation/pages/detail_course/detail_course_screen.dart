import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_test_online/core/constants/app_colors.dart';
import 'package:school_test_online/features/presentation/widgets/all_courses/widgets_imports.dart';

import '../../../../dependencies_injection.dart';
import '../../manager/courses/get_detail_formation/get_detail_formation_cubit.dart';
import '../../widgets/detail_course/widgets_imports.dart';

class DetailCourseScreen extends StatelessWidget {
  final int domainId;
  final int formationId;
  const DetailCourseScreen(
      {super.key, required this.domainId, required this.formationId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarAllCourses(
        backgroundColor: AppColors.harp,
        title: "All courses",
      ),
      body: SafeArea(
          child: BlocProvider(
        create: (context) => locator<GetDetailFormationCubit>()
          ..fetchFormations(domainId: domainId, formationId: formationId),
        child: BlocBuilder<GetDetailFormationCubit, GetDetailFormationState>(
          builder: (context, state) {
            if (state is GetDetailFormationLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetDetailFormationLoaded) {
              return DetailCourseContent(
                detailCourse: state.detailFormation,
              );
            } else if (state is GetDetailFormationFailure) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      )),
    );
  }
}
