part of 'widgets_imports.dart';

class CheckboxItem extends StatefulWidget {
  final String diploma;
  final void Function(bool?)? onChanged;
  final String price;
  final bool isChecked; // Add this line to hold the checked state

  const CheckboxItem({
    super.key,
    required this.diploma,
    this.onChanged,
    required this.price,
    this.isChecked = false, // Default value for checked state
  });

  @override
  _CheckboxItemState createState() => _CheckboxItemState();
}

class _CheckboxItemState extends State<CheckboxItem> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.isChecked; // Initialize the checked state
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: HelperFunctions.screenWidth(context) * .45.w,
          child: Text.rich(TextSpan(
            text: "${AppLocalization.of(context)!.translate("certificate")} ",
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
            children: [
              TextSpan(
                text: widget.diploma,
                style: GoogleFonts.poppins(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: " (+${widget.price})",
                style: GoogleFonts.poppins(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.paleSlate,
                ),
              ),
            ],
          )),
        ),
        SizedBox(
          height: 20.h,
          child: Checkbox(
            side: const BorderSide(color: AppColors.paleSlate),
            activeColor: AppColors.primaryColor,
            value: _isChecked, // Use the local state
            onChanged: (value) {
              setState(() {
                _isChecked = value ?? false; // Update local state
                if (widget.onChanged != null) {
                  widget.onChanged!(_isChecked); // Call the provided callback
                }
              });
            },
          ),
        )
      ],
    );
  }
}
