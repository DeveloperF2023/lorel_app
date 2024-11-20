import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_test_online/core/utils/helpers/locale_service.dart';
import 'package:school_test_online/features/presentation/widgets/all_courses/all_courses_loading.dart';
import 'package:school_test_online/features/presentation/widgets/all_courses/widgets_imports.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/helpers/helper_functions.dart';
import '../../../../dependencies_injection.dart';
import '../../manager/courses/get_courses_by_domain/get_courses_by_domain_cubit.dart';
import '../../manager/domains/get_domains/get_domains_cubit.dart';
import '../../widgets/all_courses/no_courses_found.dart';

class AllCoursesScreen extends StatefulWidget {
  const AllCoursesScreen({super.key});

  @override
  State<AllCoursesScreen> createState() => _AllCoursesScreenState();
}

class _AllCoursesScreenState extends State<AllCoursesScreen> {
  int? selectedDomainIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarAllCourses(
        title: AppLocalization.of(context)!.translate("allFormations"),
      ),
      body: SafeArea(
          child: Column(
        children: [
          BlocProvider(
            create: (context) => locator<GetDomainsCubit>()..getDomains(),
            child: BlocBuilder<GetDomainsCubit, GetDomainsState>(
              builder: (context, state) {
                if (state is GetDomainsLoading) {
                  return AllCoursesLoading(
                      scrollDirection: Axis.horizontal,
                      height: 70.h,
                      shimmerHeight: 60.h,
                      shimmerWidth: 120.w,
                      padding: EdgeInsets.only(right: 10.w));
                } else if (state is GetDomainsLoaded) {
                  if (selectedDomainIndex == null && state.domains.isNotEmpty) {
                    selectedDomainIndex = 0;
                    context
                        .read<GetCoursesByDomainCubit>()
                        .fetchCourses(domainId: state.domains[0].id!);
                  }
                  return Container(
                    height: 87.h,
                    decoration: BoxDecoration(
                      gradient: AppColors.gradient3,
                      border:
                          const Border(bottom: BorderSide(color: Colors.grey)),
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.domains.length,
                      itemBuilder: (context, index) {
                        final domain = state.domains[index];
                        return DomainContent(
                          domainName: domain.title!,
                          isSelected: selectedDomainIndex == index,
                          onTap: () {
                            setState(() {
                              selectedDomainIndex = index;
                            });
                            context
                                .read<GetCoursesByDomainCubit>()
                                .fetchCourses(domainId: domain.id!);
                          },
                        );
                      },
                    ),
                  );
                } else if (state is GetDomainsFailure) {
                  return Center(child: Text(state.message));
                }
                return Container();
              },
            ),
          ),
          BlocBuilder<GetCoursesByDomainCubit, GetCoursesByDomainState>(
            builder: (context, state) {
              if (state is GetCoursesByDomainLoading) {
                return AllCoursesLoading(
                    scrollDirection: Axis.vertical,
                    height: HelperFunctions.screenHeight(context) > 840
                        ? HelperFunctions.screenHeight(context) * .6.h
                        : HelperFunctions.screenHeight(context) * .655.h,
                    shimmerHeight: HelperFunctions.screenHeight(context) * .2.h,
                    shimmerWidth: HelperFunctions.screenWidth(context) * .9.w,
                    padding: EdgeInsets.only(bottom: 10.w));
              } else if (state is GetCoursesByDomainLoaded) {
                if (state.courses.isEmpty) {
                  return const NoCoursesFound();
                }
                return Container(
                  height: HelperFunctions.screenHeight(context) > 840
                      ? HelperFunctions.screenHeight(context) * .63.h
                      : HelperFunctions.screenHeight(context) * .655.h,
                  decoration: BoxDecoration(gradient: AppColors.gradient3),
                  child: ListView.builder(
                    itemCount: state.courses.length,
                    padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                    itemBuilder: (context, index) {
                      final course = state.courses[index];
                      return CoursesContent(
                        onTap: () => Navigator.pushNamed(
                            context, NavigationStrings.detailCourse,
                            arguments: {
                              "domainId": course.domainId,
                              "formationId": course.id
                            }),
                        courses: course,
                        additionalDiploma: course.additionalDiplomas == null ||
                                course.additionalDiplomas!.isEmpty
                            ? ""
                            : course.additionalDiplomas!.length == 1
                                ? course.additionalDiplomas![0].diploma ?? ""
                                : "${course.additionalDiplomas![0].diploma} - ${course.additionalDiplomas![1].diploma}",
                      );
                    },
                  ),
                );
              } else if (state is GetCoursesByDomainFailure) {
                return Center(child: Text(state.message));
              }
              return AllCoursesLoading(
                  scrollDirection: Axis.vertical,
                  height: HelperFunctions.screenHeight(context) * .655.h,
                  shimmerHeight: HelperFunctions.screenHeight(context) * .2.h,
                  shimmerWidth: HelperFunctions.screenWidth(context) * .9.w,
                  padding: EdgeInsets.only(bottom: 10.w));
            },
          )
        ],
      )),
    );
  }
}
