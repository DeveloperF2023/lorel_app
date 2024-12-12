part of 'widgets_imports.dart';

class DetailCourseContent extends StatefulWidget {
  final CoursesEntity detailCourse;
  const DetailCourseContent({super.key, required this.detailCourse});

  @override
  State<DetailCourseContent> createState() => _DetailCourseContentState();
}

class _DetailCourseContentState extends State<DetailCourseContent> {
  List<String> selectedDiplomas = [];

  void onCheckboxChanged(bool? isChecked, String diploma) {
    setState(() {
      if (isChecked == true) {
        selectedDiplomas.add(diploma);
      } else {
        selectedDiplomas.remove(diploma);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: HelperFunctions.screenHeight(context) * .25.h,
          width: HelperFunctions.screenWidth(context),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.detailCourse.image!))),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleSection(
                title: widget.detailCourse.title!,
                price: widget.detailCourse.price!,
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatisticItem(
                      title:
                          "${AppLocalization.of(context)!.translate("duration")} : ",
                      value:
                          "${widget.detailCourse.periode} ${widget.detailCourse.units == "months" ? AppLocalization.of(context)!.translate("months") : widget.detailCourse.units == "years" ? AppLocalization.of(context)!.translate("years") : AppLocalization.of(context)!.translate("days")}"),
                  const StatisticItem(title: "Etudiants: ", value: "73"),
                  const StatisticItem(title: "Avis: ", value: "42"),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              (widget.detailCourse.additionalDiplomas != null &&
                      widget.detailCourse.additionalDiplomas![0].diploma!
                          .isNotEmpty)
                  ? Text(
                      AppLocalization.of(context)!.translate("certificateType"),
                      style: GoogleFonts.poppins(
                        fontSize: 15.sp,
                      ),
                    )
                  : Container(),
              (widget.detailCourse.additionalDiplomas != null &&
                      widget.detailCourse.additionalDiplomas![0].diploma!
                          .isNotEmpty)
                  ? Text(
                      AppLocalization.of(context)!.translate("checkedCase"),
                      style: GoogleFonts.poppins(fontSize: 8.sp),
                    )
                  : Container(),
              (widget.detailCourse.additionalDiplomas != null &&
                      widget.detailCourse.additionalDiplomas![0].diploma!
                          .isNotEmpty)
                  ? CheckboxItem(
                      diploma:
                          widget.detailCourse.additionalDiplomas![0].diploma!,
                      onChanged: (value) {
                        onCheckboxChanged(
                            value,
                            widget
                                .detailCourse.additionalDiplomas![0].diploma!);
                        debugPrint(
                            widget.detailCourse.additionalDiplomas![0].diploma);
                      },
                      price: widget.detailCourse.additionalDiplomas![0].price!,
                      isChecked: false, // Pass initial state if needed
                    )
                  : Container(),
              (widget.detailCourse.additionalDiplomas != null &&
                      widget.detailCourse.additionalDiplomas![1].diploma!
                          .isNotEmpty)
                  ? CheckboxItem(
                      diploma:
                          widget.detailCourse.additionalDiplomas![1].diploma!,
                      onChanged: (value) {
                        onCheckboxChanged(
                            value,
                            widget
                                .detailCourse.additionalDiplomas![1].diploma!);
                        debugPrint(
                            widget.detailCourse.additionalDiplomas![1].diploma);
                      },
                      price: widget.detailCourse.additionalDiplomas![1].price!,
                      isChecked: false,
                    )
                  : Container(),
              SizedBox(
                height: 15.h,
              ),
              RegistrationButton(
                onTap: () async {
                  final diploma = selectedDiplomas.join(', ');
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  final token = preferences.getString("token");
                  debugPrint("Token: $token");

                  if (token == null && context.mounted) {
                    Navigator.pushNamed(
                      context,
                      NavigationStrings.registrationCourse,
                      arguments: {
                        "selectedDiplomas": diploma,
                        "formationId": widget.detailCourse.id.toString()
                      },
                    );
                  } else if (token != null && context.mounted) {
                    Navigator.pushNamed(
                      context,
                      NavigationStrings.payment,
                      arguments: {
                        "selectedDiplomas": diploma,
                        "formationId": widget.detailCourse.id.toString()
                      },
                    );
                  }
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "${AppLocalization.of(context)!.translate("description")} :",
                style: GoogleFonts.poppins(
                    fontSize: 16.sp, fontWeight: FontWeight.w400),
              ),
              Text(
                widget.detailCourse.description!,
                style: GoogleFonts.poppins(
                    fontSize: 13.sp, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        )
      ],
    );
  }
}
