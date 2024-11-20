part of 'widgets_imports.dart';

class DetailOfferContent extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String company;
  final String city;
  final String salary;
  final String contract;
  final String missions;
  final String skills;
  final String experience;
  final int offerId;
  final bool isFavorite;

  const DetailOfferContent(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.company,
      required this.city,
      required this.salary,
      required this.contract,
      required this.missions,
      required this.skills,
      required this.experience,
      required this.offerId,
      required this.isFavorite});

  @override
  State<DetailOfferContent> createState() => _DetailOfferContentState();
}

class _DetailOfferContentState extends State<DetailOfferContent> {
  Future<File?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom, // You can restrict file types here if needed
      allowedExtensions: ['pdf', 'doc', 'docx'], // Limit to certain file types
    );

    if (result != null) {
      return File(result.files.single.path!); // Get the file
    } else {
      return null; // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> _formatSalary(String salaryJson) {
      try {
        // Decode the salary JSON
        final Map<String, dynamic> salaryMap = jsonDecode(salaryJson);

        // Extract min and max salary
        final String minSalary =
            AppLocalization.of(context)!.isArabicSelected(context)
                ? " درهم${salaryMap['min']}"
                : "${salaryMap['min']} DH" ?? 'N/A';
        final String maxSalary =
            AppLocalization.of(context)!.isArabicSelected(context)
                ? "درهم ${salaryMap['max']}"
                : "${salaryMap['max']} DH" ?? 'N/A';

        // Return minSalary and maxSalary separately in a map
        return {'minSalary': minSalary, 'maxSalary': maxSalary};
      } catch (e) {
        // Return default values if parsing fails
        return {'minSalary': 'N/A', 'maxSalary': 'N/A'};
      }
    }

    final salaryData = _formatSalary(widget.salary);

    final String minSalary = salaryData['minSalary']!;
    final String maxSalary = salaryData['maxSalary']!;

    return Container(
      height: HelperFunctions.screenHeight(context) * .8.h,
      width: HelperFunctions.screenWidth(context),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 25.r,
                      backgroundImage: NetworkImage(widget.imageUrl),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: GoogleFonts.robotoCondensed(
                              color: Colors.black, fontSize: 22.sp),
                        ),
                        Text(
                          widget.company,
                          style: GoogleFonts.robotoCondensed(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300),
                        ),
                        Text(
                          widget.city,
                          style: GoogleFonts.robotoCondensed(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Text(
                          AppLocalization.of(context)!.translate("salary"),
                          style: GoogleFonts.robotoCondensed(
                              color: Colors.black,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: [
                            Text(
                              "$minSalary - $maxSalary",
                              style: GoogleFonts.robotoCondensed(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w300),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              AppLocalization.of(context)!
                                  .translate("perMonth"),
                              style: GoogleFonts.robotoCondensed(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Text(
                          AppLocalization.of(context)!.translate("jobTime"),
                          style: GoogleFonts.robotoCondensed(
                              color: Colors.black,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          widget.contract == "part-time"
                              ? AppLocalization.of(context)!
                                  .translate("partTime")
                              : AppLocalization.of(context)!
                                  .translate("fullTime"),
                          style: GoogleFonts.robotoCondensed(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              const Divider(),
              SizedBox(
                height: 5.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalization.of(context)!.translate("jobDuties"),
                      style: GoogleFonts.lexend(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      widget.missions,
                      style: GoogleFonts.lexend(
                          color: Colors.black, fontSize: 12.sp),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      AppLocalization.of(context)!
                          .translate("profileRequested"),
                      style: GoogleFonts.lexend(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      widget.skills,
                      style: GoogleFonts.lexend(
                          color: Colors.black, fontSize: 12.sp),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      AppLocalization.of(context)!.translate("experience"),
                      style: GoogleFonts.lexend(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      widget.experience,
                      style: GoogleFonts.lexend(
                          color: Colors.black, fontSize: 12.sp),
                    ),
                  ],
                ),
              )
            ],
          ),
          Container(
            height: 70.h,
            width: HelperFunctions.screenWidth(context),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10.r,
                  offset: const Offset(0, 1))
            ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () async {
                    File? resume = await pickFile();

                    // Step 2: Call Cubit's applyToOffer method
                    if (resume != null) {
                      BlocProvider.of<ApplyToOfferCubit>(context).applyToOffer(
                        offerId: widget.offerId,
                        resume: resume,
                      );
                    } else {
                      // Show a message if no file is selected
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('No file selected')),
                      );
                    }
                  },
                  child: BlocListener<ApplyToOfferCubit, ApplyToOfferState>(
                    listener: (context, state) {
                      if (state is ApplyToOfferFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if (state is ApplyToOfferLoaded) {
                        if (state.message ==
                            "You already applied to this offer") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(AppLocalization.of(context)!
                                  .translate("alreadyApply")),
                              backgroundColor: Colors.orange,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(AppLocalization.of(context)!
                                  .translate("successfulApplication")),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      }
                    },
                    child: Container(
                      height: 40.h,
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(20.r)),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Text(
                            AppLocalization.of(context)!.translate("apply"),
                            style: GoogleFonts.poppins(
                                fontSize: 20.sp, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                BlocBuilder<FavoriteStatusCubit, bool>(
                  builder: (context, isFavorite) {
                    return IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color:
                            isFavorite ? AppColors.primaryColor : Colors.grey,
                        size: 35.sp,
                      ),
                      onPressed: () {
                        if (isFavorite) {
                          context
                              .read<RemoveFromFavoriteListCubit>()
                              .deleteFromFavoriteList(offerId: widget.offerId)
                              .then((_) {
                            context
                                .read<FavoriteStatusCubit>()
                                .updateStatus(false);
                          });
                        } else {
                          context
                              .read<AddToFavoriteListCubit>()
                              .addToFavoriteList(offerId: widget.offerId)
                              .then((_) {
                            context
                                .read<FavoriteStatusCubit>()
                                .updateStatus(true);
                          });
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
