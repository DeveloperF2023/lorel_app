part of 'widgets_imports.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final String imageAssetPath;
  final VoidCallback onPressed;

  const MenuItem({
    super.key,
    required this.title,
    required this.imageAssetPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed, // Add InkWell for tap functionality
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.r),
            boxShadow: [
              BoxShadow(
                  color: AppColors.gainsboro,
                  blurRadius: 10.r,
                  offset: const Offset(1, 1))
            ]),
        child: Container(
          height: 125.h,
          width: 136.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.r),
            border: Border.all(color: AppColors.gainsboro),
            gradient: AppColors.menuGradient, // Apply gradient on top of shadow
          ),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.start, // Center content vertically
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Image.asset(
                  imageAssetPath,
                  height: 50.h,
                ),
              ),
              SizedBox(height: 5.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: AppColors.darkerGrey,
                    fontWeight: FontWeight.w500,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
