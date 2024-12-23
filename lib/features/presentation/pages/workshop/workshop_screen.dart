import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:school_test_online/core/constants/app_colors.dart';
import 'package:school_test_online/core/routes/routes.dart';
import 'package:school_test_online/features/presentation/widgets/global/widgets_imports.dart';
import 'package:school_test_online/features/presentation/widgets/workshops/widgets_imports.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/helpers/locale_service.dart';
import '../../manager/workshops/get_workshops/get_workshops_cubit.dart';

class WorkshopScreen extends StatefulWidget {
  const WorkshopScreen({super.key});

  @override
  State<WorkshopScreen> createState() => _WorkshopScreenState();
}

class _WorkshopScreenState extends State<WorkshopScreen> {
  DateTime now = DateTime.now();
  late DateTime startOfWeek;
  late DateTime endOfWeek;
  Locale? currentLocale;

  @override
  void initState() {
    super.initState();
    fetchInitialWorkshops();
  }

  @override
  Widget build(BuildContext context) {
    int currentDayOfWeek = now.weekday;
    startOfWeek = now.subtract(Duration(days: currentDayOfWeek - 1));
    endOfWeek = now.add(Duration(days: 6 - currentDayOfWeek));
    currentLocale = Localizations.localeOf(context);

    return Scaffold(
      backgroundColor: AppColors.paleCornFlowerBlue,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: BackButtonWidget(onTap: () async {
            final prefs = await SharedPreferences.getInstance();
            final token = prefs.getString("token");
            if (token != null && context.mounted) {
              Navigator.pushReplacementNamed(context, NavigationStrings.main,
                  arguments: token);
            } else {
              debugPrint("Token it's null ");
            }
          }),
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
                  debugPrint("Workshop State : $state");
                  if (state is GetWorkshopsLoading) {
                    return const Center(
                        child: CircularProgressIndicator(
                            color: AppColors.primaryColor));
                  } else if (state is GetWorkshopsLoaded) {
                    if (state.workshops.isEmpty) {
                      return Center(
                        child: Text(
                          AppLocalization.of(context)!
                              .translate("emptyWorkshops"),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    if (state.workshops.isNotEmpty) {
                      return ListView.builder(
                        itemCount: state.workshops.length,
                        itemBuilder: (context, index) {
                          final workshop = state.workshops[index];
                          final formattedDate = formatDateToLocale(
                              workshop.dateFrom!, currentLocale!);

                          return WorkshopContent(
                            dateFrom: formattedDate,
                            title: workshop.title!,
                            participantsCount: workshop.participantsCount!,
                            price: workshop.free == false
                                ? workshop.price!
                                : AppLocalization.of(context)!
                                    .translate("free"),
                            onFetchWorkshopDetail: () => Navigator.pushNamed(
                                context, NavigationStrings.detailWorkshop,
                                arguments: workshop.id),
                          );
                        },
                      );
                    } else {
                      return const Center(
                          child: CircularProgressIndicator(
                              color: AppColors.primaryColor));
                    }
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

  void fetchInitialWorkshops() {
    context.read<GetWorkshopsCubit>().getWorkshops(now);
  }

  /// Helper function to format date to the user's locale
  String formatDateToLocale(String dateString, Locale locale) {
    DateTime dateTime = DateFormat('yyyy-MM-dd').parse(dateString);
    DateFormat dateFormat = DateFormat.yMMMMd(locale.toString());
    return dateFormat.format(dateTime);
  }
}
