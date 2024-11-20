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
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: AppColors.yellowGreen),
            child: Center(
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
            "Félicitations, votre demande a été dûment enregistrée. Votre certificat vous sera délivré dans un délai de 15 jours",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontSize: 18),
          ),
          SizedBox(
            height: 20.h,
          ),
          PrimaryButton(
            textButton: "D’accord",
          )
        ],
      ),
    );
  }
}
