part of 'widgets_imports.dart';

class TextFieldRequest extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  const TextFieldRequest(
      {super.key,
      required this.label,
      required this.controller,
      this.validator,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15.w),
            child: Text(
              label,
              style: GoogleFonts.robotoCondensed(
                  fontSize: 14.sp,
                  color: AppColors.blackCow,
                  fontWeight: FontWeight.w400),
            ),
          ),
          TextFormField(
            controller: controller,
            validator: validator,
            keyboardType: keyboardType,
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(30.r)),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(30.r))),
          )
        ],
      ),
    );
  }
}
