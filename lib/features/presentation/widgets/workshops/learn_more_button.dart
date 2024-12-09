part of 'widgets_imports.dart';

class LearnMoreButton extends StatelessWidget {
  final void Function() onTap;
  const LearnMoreButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 66.h,
        decoration: const BoxDecoration(color: AppColors.secondaryMercury),
        child: Center(
          child: Container(
            height: 42.h,
            margin: EdgeInsets.symmetric(horizontal: 55.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: AppColors.butterFlyBlue),
            child: Center(
              child: Text(
                AppLocalization.of(context)!.translate("learnMore"),
                style:
                    GoogleFonts.poppins(fontSize: 18.sp, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
