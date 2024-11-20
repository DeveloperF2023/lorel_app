part of 'widgets_imports.dart';

class PrimaryButton extends StatelessWidget {
  final void Function()? onTap;
  final String textButton;
  const PrimaryButton({super.key, this.onTap, this.textButton = "Connecter"});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52.h,
        width: HelperFunctions.screenWidth(context) * .6.w,
        decoration: BoxDecoration(
            gradient: AppColors.buttonGradient,
            borderRadius: BorderRadius.circular(25.r)),
        child: Center(
          child: Text(
            textButton,
            style: GoogleFonts.poppins(
                fontSize: 20.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
