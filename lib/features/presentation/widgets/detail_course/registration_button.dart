part of 'widgets_imports.dart';

class RegistrationButton extends StatelessWidget {
  final void Function()? onTap;
  const RegistrationButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 41.h,
            width: HelperFunctions.screenWidth(context) * .5.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: AppColors.deepBlush),
            child: Center(
              child: Text(
                AppLocalization.of(context)!.translate("register"),
                style:
                    GoogleFonts.poppins(fontSize: 18.sp, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
