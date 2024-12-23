part of 'widgets_imports.dart';

class TextFieldApp extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final bool? hasSuffixIcon;
  final void Function()? onTap;
  final IconData? suffixIcon;
  final TextInputType? keyboardType;
  const TextFieldApp(
      {super.key,
      required this.icon,
      required this.hintText,
      this.controller,
      this.validator,
      this.obscureText = false,
      this.hasSuffixIcon = false,
      this.onTap,
      this.suffixIcon,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        validator: validator,
        obscureText: obscureText!,
        decoration: InputDecoration(
            hintText: hintText,
            contentPadding: EdgeInsets.only(top: 20.h),
            hintStyle:
                GoogleFonts.poppins(color: AppColors.nobel, fontSize: 14.sp),
            prefixIcon: Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: Icon(
                icon,
                color: AppColors.nobel,
                size: 12.sp,
              ),
            ),
            suffixIcon: hasSuffixIcon == false
                ? null
                : Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: GestureDetector(
                      onTap: onTap,
                      child: Icon(
                        suffixIcon,
                        color: AppColors.nobel,
                        size: 12.sp,
                      ),
                    ),
                  )),
      ),
    );
  }
}
