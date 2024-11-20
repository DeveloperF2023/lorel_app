import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/helpers/helper_functions.dart';

class SearchBook extends StatelessWidget {
  final TextEditingController searchController;
  final void Function(String)? onChanged;
  const SearchBook({super.key, required this.searchController, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.h,
      width: HelperFunctions.screenWidth(context),
      color: AppColors.ghost,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: SizedBox(
            height: 40.h,
            child: TextFormField(
              controller: searchController,
              onChanged: onChanged,
              decoration: InputDecoration(
                  hintText: "Rechercher ici",
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 13.sp, color: AppColors.darkGrey),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.darkGrey,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: const BorderSide(color: Colors.white))),
            ),
          ),
        ),
      ),
    );
  }
}
