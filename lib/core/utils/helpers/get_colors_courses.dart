import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

Color getCourseColor(String courseName) {
  switch (courseName) {
    case 'Web Development':
      return AppColors.macaroni.withOpacity(0.2); // Define custom color
    case 'Mobile Development':
      return AppColors.lovelyPurple.withOpacity(0.2); // Define custom color
    case 'Machine learning':
      return AppColors.spotlightGoGreen.withOpacity(0.2); // Define custom color
    default:
      return AppColors.mediumTurquoise.withOpacity(0.2); // Fallback color
  }
}

Color getDividerColorByCourseName(String courseName) {
  switch (courseName) {
    case 'Web Development':
      return AppColors.macaroni; // Define custom color
    case 'Mobile Development':
      return AppColors.lovelyPurple; // Define custom color
    case 'Machine learning':
      return AppColors.spotlightGoGreen; // Define custom color
    default:
      return AppColors.mediumTurquoise; // Fallback color
  }
}
