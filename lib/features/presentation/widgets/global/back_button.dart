part of 'widgets_imports.dart';

class BackButtonWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color iconColor;
  final void Function() onTap;
  const BackButtonWidget(
      {super.key,
      this.backgroundColor = AppColors.davyGrey,
      this.iconColor = Colors.white,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.h,
        width: 40.w,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: backgroundColor),
        child: Center(
          child: Icon(
            Icons.arrow_back,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
