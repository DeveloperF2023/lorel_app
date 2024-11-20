import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../chat/custom_shimmer_loading.dart';

class AllCoursesLoading extends StatelessWidget {
  final Axis scrollDirection;
  final double height;
  final EdgeInsetsGeometry padding;
  final double shimmerHeight;
  final double shimmerWidth;
  const AllCoursesLoading(
      {super.key,
      required this.scrollDirection,
      required this.height,
      required this.padding,
      required this.shimmerHeight,
      required this.shimmerWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(gradient: AppColors.gradient3),
      child: ListView(
        scrollDirection: scrollDirection,
        children: List.generate(3, (index) {
          return Padding(
            padding: padding,
            child: CustomShimmer(height: shimmerHeight, width: shimmerWidth),
          );
        }),
      ),
    );
  }
}
