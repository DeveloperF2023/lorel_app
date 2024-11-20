part of 'widgets_imports.dart';

class DomainContent extends StatelessWidget {
  final String domainName;
  final bool isSelected;
  final void Function()? onTap;

  const DomainContent({
    super.key,
    required this.domainName,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 60.h,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            margin: EdgeInsets.only(top: 5.h, left: 5.w, right: 5.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: isSelected
                  ? AppColors.butterflyBush
                  : AppColors.catskillWhite,
            ),
            child: Center(
              child: Text(
                domainName,
                style: GoogleFonts.robotoCondensed(
                  fontSize: 15.sp,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
