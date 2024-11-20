part of 'widgets_imports.dart';

class PaymentContent extends StatelessWidget {
  final String selectedDiploma;
  final String formationId;
  const PaymentContent(
      {super.key, required this.selectedDiploma, required this.formationId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalization.of(context)!.translate("manualPayment"),
            style: GoogleFonts.poppins(
                fontSize: 16.sp, color: AppColors.secondaryNobel),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            AppLocalization.of(context)!.translate("descManualPayment"),
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 12.sp, color: AppColors.secondaryNobel),
          ),
          SizedBox(
            height: 20.h,
          ),
          BlocProvider(
            create: (context) => locator<GetRibCubit>()..getRib(),
            child: BlocBuilder<GetRibCubit, GetRibState>(
              builder: (context, state) {
                print("State Rib: $state");
                if (state is GetRibLoading) {
                  return const CircularProgressIndicator();
                } else if (state is GetRibLoaded) {
                  final rib = state.rib;
                  return GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(text: rib.rib!));
                    },
                    child: Container(
                      height: 34.h,
                      decoration: BoxDecoration(
                          color: AppColors.desertStorm,
                          border: Border.all(color: AppColors.mercury)),
                      child: Center(
                        child: Text(
                          rib.rib!,
                          style: GoogleFonts.poppins(
                              color: AppColors.nobel, fontSize: 16.sp),
                        ),
                      ),
                    ),
                  );
                } else if (state is GetRibFailure) {
                  return Text("error ${state.message}");
                }
                return Container();
              },
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          BlocConsumer<ManualPaymentCubit, ManualPaymentState>(
            listener: (context, state) {
              if (state is ManualPaymentLoaded) {
                Navigator.pushNamed(
                    context, NavigationStrings.successRegistration);
              } else if (state is ManualPaymentFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(AppLocalization.of(context)!
                          .translate("alreadyEnrolled"))),
                );
              }
            },
            builder: (context, state) {
              if (state is ManualPaymentLoading) {
                return const CircularProgressIndicator();
              }
              return PrimaryButton(
                  textButton:
                      AppLocalization.of(context)!.translate("register"),
                  onTap: () {
                    manualPayment(context);
                  });
            },
          ),
        ],
      ),
    );
  }

  void manualPayment(BuildContext context) async {
    print("Formation ID: ${formationId.runtimeType}");
    print("Selected Diploma: ${selectedDiploma.runtimeType}");
    selectedDiploma == ""
        ? BlocProvider.of<ManualPaymentCubit>(context)
            .manualPayment(formationId: formationId, additionalDiploma: "maroc")
        : BlocProvider.of<ManualPaymentCubit>(context).manualPayment(
            formationId: formationId, additionalDiploma: selectedDiploma);
  }
}
