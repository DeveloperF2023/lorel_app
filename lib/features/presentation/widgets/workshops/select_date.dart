part of 'widgets_imports.dart';

class DateSelectionWidget extends StatefulWidget {
  final DateTime startOfWeek;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const DateSelectionWidget({
    super.key,
    required this.startOfWeek,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  State<DateSelectionWidget> createState() => _DateSelectionWidgetState();
}

class _DateSelectionWidgetState extends State<DateSelectionWidget> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    // Get the current locale from context
    Locale currentLocale = Localizations.localeOf(context);

    // Create a list of localized day names
    List<String> daysOfWeek = List.generate(7, (index) {
      DateTime date = widget.startOfWeek.add(Duration(days: index));
      return DateFormat.E(currentLocale.toString()).format(date).toUpperCase();
    });

    return Container(
      height: 75.h,
      width: HelperFunctions.screenWidth(context),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat('yyyy').format(now),
                  style: GoogleFonts.robotoCondensed(
                    fontSize: 18.0,
                    color: AppColors.metallicBlue,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  DateFormat.MMM(currentLocale.toString())
                      .format(now)
                      .toUpperCase(),
                  style: GoogleFonts.robotoCondensed(
                    fontSize: 18.0,
                    color: AppColors.metallicBlue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                  width: 35.w,
                  child: const Divider(
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
              width: AppLocalization.of(context)!.isArabicSelected(context)
                  ? 0.0
                  : 10.0),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                  right: AppLocalization.of(context)!.isArabicSelected(context)
                      ? 0.w
                      : 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(7, (index) {
                  DateTime date = widget.startOfWeek.add(Duration(days: index));
                  bool isSelected = date == widget.selectedDate;

                  return GestureDetector(
                    onTap: () {
                      widget.onDateSelected(date);
                      context.read<GetWorkshopsCubit>().getWorkshops(date);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          daysOfWeek[index],
                          style: GoogleFonts.robotoCondensed(
                            fontSize: 18.0,
                            color: AppColors.metallicBlue,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        Text(
                          "${date.day}",
                          style: GoogleFonts.robotoCondensed(
                            fontSize: 18.0,
                            color: AppColors.metallicBlue,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                          width: 35.0,
                          child: Divider(
                            color: isSelected
                                ? AppColors.crystalBlue
                                : Colors.black,
                          ),
                        )
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
