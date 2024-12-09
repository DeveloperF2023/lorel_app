part of 'widgets_imports.dart';

class DetailOfferContent extends StatefulWidget {
  final DetailOfferEntity detailOffer;

  const DetailOfferContent({super.key, required this.detailOffer});

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
    return Container(
      height: HelperFunctions.screenHeight(context).h,
      width: HelperFunctions.screenWidth(context),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 25.r,
                          backgroundImage:
                              NetworkImage(widget.detailOffer.image!),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.detailOffer.title!,
                              style: GoogleFonts.robotoCondensed(
                                  color: Colors.black, fontSize: 22.sp),
                            ),
                            Text(
                              widget.detailOffer.company!,
                              style: GoogleFonts.robotoCondensed(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              widget.detailOffer.city!,
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
                                  AppLocalization.of(context)!
                                          .isArabicSelected(context)
                                      ? "${widget.detailOffer.salary?.min} درهم - ${widget.detailOffer.salary?.max} درهم"
                                      : "${widget.detailOffer.salary?.min} DH - ${widget.detailOffer.salary?.max} DH",
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
                              widget.detailOffer.contract == "part-time"
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
                          widget.detailOffer.missions!,
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
                          widget.detailOffer.skills!,
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
                          widget.detailOffer.experience!,
                          style: GoogleFonts.lexend(
                              color: Colors.black, fontSize: 12.sp),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
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
                        offerId: widget.detailOffer.id!,
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
                              .deleteFromFavoriteList(
                                  offerId: widget.detailOffer.id!)
                              .then((_) {
                            context
                                .read<FavoriteStatusCubit>()
                                .updateStatus(false);
                          });
                        } else {
                          context
                              .read<AddToFavoriteListCubit>()
                              .addToFavoriteList(
                                  offerId: widget.detailOffer.id!)
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
