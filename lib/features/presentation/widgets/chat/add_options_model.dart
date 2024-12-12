import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/helpers/helper_functions.dart';

class AddOptionsModal extends StatelessWidget {
  final void Function() onAddDocument;
  final void Function() onAddImage;

  const AddOptionsModal({
    super.key,
    required this.onAddDocument,
    required this.onAddImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      height: HelperFunctions.screenHeight(context) * .1.h,
      child: Row(
        children: [
          SizedBox(
            width: 10.w,
          ),
          GestureDetector(
            onTap: onAddDocument,
            child: Column(
              children: [
                Container(
                  height: 35.h,
                  width: 35.w,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.macaroni),
                  child: Icon(
                    Icons.description,
                    size: 25.sp,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 5.w,
                ),
                Text(
                  'Documents',
                  style: GoogleFonts.poppins(
                      fontSize: 12.sp, color: AppColors.gullGrey),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 15.w,
          ),
          GestureDetector(
            onTap: onAddImage,
            child: Column(
              children: [
                Container(
                  height: 35.h,
                  width: 35.w,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.lovelyPurple),
                  child: Icon(
                    Icons.image,
                    size: 25.sp,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 5.w,
                ),
                Text(
                  'Images',
                  style: GoogleFonts.poppins(
                      fontSize: 12.sp, color: AppColors.gullGrey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
