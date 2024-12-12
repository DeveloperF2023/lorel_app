part of 'widgets_imports.dart';

class SuccessRegistrationContent extends StatelessWidget {
  const SuccessRegistrationContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 45.h,
            width: 45.w,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: AppColors.yellowGreen),
            child: const Center(
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            AppLocalization.of(context)!.translate("successPayment"),
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontSize: 18),
          ),
          SizedBox(
            height: 20.h,
          ),
          PrimaryButton(
            textButton: AppLocalization.of(context)!.translate("ok"),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              final token = prefs.getString("token");
              if (token != null && context.mounted) {
                Navigator.pushReplacementNamed(context, NavigationStrings.main,
                    arguments: token);
              } else {
                debugPrint("Token it's null ");
              }
            },
          )
        ],
      ),
    );
  }
}
