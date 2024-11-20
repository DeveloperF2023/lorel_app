import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:school_test_online/core/constants/app_colors.dart';
import 'package:school_test_online/core/routes/routes.dart';
import 'package:school_test_online/features/presentation/widgets/global/widgets_imports.dart';
import 'package:school_test_online/features/presentation/widgets/workshops/widgets_imports.dart';

import '../../../../core/utils/helpers/locale_service.dart';
import '../../manager/workshops/get_workshops/get_workshops_cubit.dart';

class WorkshopScreen extends StatefulWidget {
  const WorkshopScreen({super.key});

  @override
  State<WorkshopScreen> createState() => _WorkshopScreenState();
}

class _WorkshopScreenState extends State<WorkshopScreen> {
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    int currentDayOfWeek = now.weekday;
    DateTime startOfWeek = now.subtract(Duration(days: currentDayOfWeek - 1));
    DateTime endOfWeek =
        now.add(Duration(days: 6 - currentDayOfWeek)); // End of the week
    Locale currentLocale = Localizations.localeOf(context);

    return Scaffold(
      backgroundColor: AppColors.paleCornFlowerBlue,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: BackButtonWidget(
            onTap: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          AppLocalization.of(context)!.translate("conference"),
          style: GoogleFonts.robotoCondensed(
              color: AppColors.riverBed, fontSize: 22.sp),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            DateSelectionWidget(
              startOfWeek: startOfWeek,
              selectedDate: now,
              onDateSelected: (DateTime date) {
                setState(() {
                  now = date;
                });
                context.read<GetWorkshopsCubit>().getWorkshops(date);
              },
            ),
            Expanded(
              child: BlocBuilder<GetWorkshopsCubit, GetWorkshopsState>(
                builder: (context, state) {
                  print("Workshop State : $state");
                  if (state is GetWorkshopsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is GetWorkshopsLoaded) {
                    return ListView.builder(
                      itemCount: state.workshops.length,
                      itemBuilder: (context, index) {
                        final workshop = state.workshops[index];
                        final formattedDate = formatDateToLocale(
                            workshop.dateFrom!, currentLocale);

                        return WorkshopContent(
                          dateFrom: formattedDate,
                          title: workshop.title!,
                          participantsCount: workshop.participantsCount!,
                          price: workshop.free == false
                              ? workshop.price!
                              : AppLocalization.of(context)!.translate("free"),
                          onFetchWorkshopDetail: () => Navigator.pushNamed(
                              context, NavigationStrings.detailWorkshop,
                              arguments: workshop.id),
                        );
                      },
                    );
                  } else if (state is GetWorkshopsFailure) {
                    return Center(child: Text(state.message));
                  }
                  return Center(
                      child: Text(AppLocalization.of(context)!
                          .translate("selectDate")));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatDateToLocale(String dateString, Locale locale) {
    // Parse the date string (e.g., '2024-09-30') to a DateTime object
    DateTime dateTime = DateFormat('yyyy-MM-dd').parse(dateString);

    // Create a DateFormat instance with the user's selected locale
    // Example locale: 'en', 'fr', 'ar', etc.
    DateFormat dateFormat = DateFormat.yMMMMd(locale.toString());

    // Format the date to a localized string
    return dateFormat.format(dateTime);
  }
}
