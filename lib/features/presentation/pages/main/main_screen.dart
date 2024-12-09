import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_test_online/core/constants/app_assets.dart';
import 'package:school_test_online/core/constants/app_colors.dart';
import 'package:school_test_online/core/utils/helpers/locale_service.dart';

import '../chat/chat_screen.dart';
import '../home/home_screen.dart';
import '../my_courses/my_courses_screen.dart';
import '../settings/settings_screen.dart';
import '../timetable/timetable_screen.dart';

class MainScreen extends StatefulWidget {
  final String? token;
  final Function(String)? onLocaleChange;
  const MainScreen({super.key, required this.token, this.onLocaleChange});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  BottomNavigationBarItem buildBottomNavItem(
      String icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: _selectedIndex == index
          ? Image.asset(
              icon,
              fit: BoxFit.contain,
              height: 25.h,
            )
          : Image.asset(
              icon,
              fit: BoxFit.contain,
              height: 25.h,
            ),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: <Widget>[
            const HomeScreen(),
            const MyCoursesScreen(),
            const TimetableScreen(),
            const ChatScreen(),
            SettingsScreen(
              onLocaleChange: widget.onLocaleChange,
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          buildBottomNavItem(AppAssets.home,
              AppLocalization.of(context)!.translate("home"), 0),
          buildBottomNavItem(AppAssets.courses,
              AppLocalization.of(context)!.translate("myFormations"), 1),
          buildBottomNavItem(AppAssets.timetable,
              AppLocalization.of(context)!.translate("timetable"), 2),
          buildBottomNavItem(AppAssets.chat,
              AppLocalization.of(context)!.translate("chat"), 3),
          buildBottomNavItem(AppAssets.settings,
              AppLocalization.of(context)!.translate("settings"), 4),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
        iconSize: 25,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.harp,
      ),
    );
  }
}
