part of 'widgets_imports.dart';

class NavigationMyCourses extends StatelessWidget {
  final void Function()? onNavigate;
  final bool? isBack;
  const NavigationMyCourses({super.key, this.onNavigate, this.isBack = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onNavigate,
      child: Container(
        height: 40.h,
        decoration: BoxDecoration(
            color: AppColors.tuna, borderRadius: BorderRadius.circular(15.r)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: isBack == true
              ? Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.geyser,
                      size: 19.sp,
                    ),
                    Text(
                      AppLocalization.of(context)!.translate("back"),
                      style: GoogleFonts.poppins(
                          fontSize: 16.sp, color: AppColors.geyser),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Text(
                      AppLocalization.of(context)!.translate("next"),
                      style: GoogleFonts.poppins(
                          fontSize: 16.sp, color: AppColors.geyser),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.geyser,
                      size: 19.sp,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
