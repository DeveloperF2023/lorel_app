import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_test_online/core/routes/routes.dart';
import 'package:school_test_online/features/presentation/pages/auth/login_screen.dart';
import 'package:school_test_online/features/presentation/widgets/settings/widgets_imports.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/helpers/locale_service.dart';
import '../../../../main.dart';
import '../../manager/user/credential/credential_cubit.dart';
import '../../manager/user/update_profile/update_profile_cubit.dart';
import '../../manager/user/upload_avatar/upload_avatar_cubit.dart';

class SettingsScreen extends StatefulWidget {
  final Function(String)? onLocaleChange;
  const SettingsScreen({super.key, this.onLocaleChange});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String nameUser = "";
  String profilePicture = "";
  Locale _locale = const Locale("en");
  bool isSelected = false;
  final List<Map<String, dynamic>> _languages = [
    {'code': 'en', 'name': 'English', 'image': AppAssets.english},
    {'code': 'ar', 'name': 'العربية', 'image': AppAssets.arabic},
    {'code': 'fr', 'name': 'français', 'image': AppAssets.french}, // Arabic
  ];

  @override
  void initState() {
    fetchUserName();
    super.initState();
  }

  void _changeLanguage(String languageCode) {
    Locale newLocale = Locale(languageCode);

    // Update locale
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('locale', languageCode);
      MyApp.setLocale(context, newLocale);
    });

    setState(() {
      _locale = newLocale;
      isSelected = false; // Close the language selection
    });

    // Notify parent about locale change
    if (widget.onLocaleChange != null) {
      widget.onLocaleChange!(languageCode);
    }
  }

  void restartApp() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  fetchUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nameUser = preferences.getString("name") ?? "User";
      profilePicture = preferences.getString("profilePicture")!;
    });

    debugPrint(profilePicture);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Row(
                  children: [
                    Directionality(
                      textDirection:
                          AppLocalization.of(context)!.isArabicSelected(context)
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                      child: BlocBuilder<UploadAvatarCubit, UploadAvatarState>(
                        builder: (context, avatarState) {
                          // Determine the appropriate ImageProvider based on the avatar URL
                          ImageProvider backgroundImage;
                          if (avatarState is UploadAvatarLoaded) {
                            if (avatarState.uploadAvatar.isNotEmpty) {
                              backgroundImage =
                                  NetworkImage(avatarState.uploadAvatar);
                            } else {
                              backgroundImage =
                                  const AssetImage(AppAssets.logo);
                            }
                          } else {
                            backgroundImage = NetworkImage(profilePicture);
                          }

                          return GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, NavigationStrings.uploadAvatar),
                            child: CircleAvatar(
                              radius: 38,
                              backgroundImage: backgroundImage,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 15.w),
                    BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
                      builder: (context, state) {
                        String name;
                        if (state is UpdateProfileLoaded) {
                          if (state.updateUserProfile.user!.name!.isNotEmpty) {
                            name = state.updateUserProfile.user!.name!;
                          } else {
                            name = "";
                          }
                        } else {
                          name = nameUser;
                        }
                        return Text.rich(
                          TextSpan(
                            text: name,
                            style: GoogleFonts.roboto(
                                fontSize: 23.sp,
                                color: AppColors.carbonGrey,
                                fontWeight: FontWeight.w600),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              SizedBox(height: 25.h),
              Text(
                AppLocalization.of(context)!.translate("account"),
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                  color: AppColors.carbonGrey,
                ),
              ),
              SizedBox(height: 25.h),
              SettingsTile(
                leading: Icons.language,
                onPressed: () {
                  setState(() {
                    isSelected = !isSelected; // Toggle the language list
                  });
                },
                icon: isSelected
                    ? FontAwesomeIcons.chevronDown
                    : (AppLocalization.of(context)!.isArabicSelected(context)
                        ? FontAwesomeIcons.chevronLeft
                        : FontAwesomeIcons.chevronRight),
                title: AppLocalization.of(context)!.translate('changeLanguage'),
              ),
              if (isSelected) // Only show the list when isSelected is true
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListView.builder(
                      itemCount: _languages.length,
                      shrinkWrap: true,
                      physics:
                          const NeverScrollableScrollPhysics(), // Prevent scrolling in nested ListView
                      itemBuilder: (context, index) {
                        final language = _languages[index];
                        return ListTile(
                          title: Text(language['name']!),
                          leading: Image.asset(
                            language['image'],
                            height: 40.h,
                            width: 40.w,
                          ),
                          onTap: () => _changeLanguage(language['code']),
                        );
                      },
                    ),
                  ],
                ),
              SettingsTile(
                  leading: Icons.person,
                  onPressed: () {
                    Navigator.pushNamed(
                        context, NavigationStrings.updatePassword);
                  },
                  icon: AppLocalization.of(context)!.isArabicSelected(context)
                      ? FontAwesomeIcons.chevronLeft
                      : FontAwesomeIcons.chevronRight,
                  title:
                      AppLocalization.of(context)!.translate('updatePassword')),
              SettingsTile(
                  leading: Icons.person,
                  onPressed: () {
                    Navigator.pushNamed(
                        context, NavigationStrings.uploadAvatar);
                  },
                  icon: AppLocalization.of(context)!.isArabicSelected(context)
                      ? FontAwesomeIcons.chevronLeft
                      : FontAwesomeIcons.chevronRight,
                  title:
                      AppLocalization.of(context)!.translate('uploadAvatar')),
              SettingsTile(
                  leading: Icons.person,
                  onPressed: () {
                    Navigator.pushNamed(
                        context, NavigationStrings.updateProfile);
                  },
                  icon: AppLocalization.of(context)!.isArabicSelected(context)
                      ? FontAwesomeIcons.chevronLeft
                      : FontAwesomeIcons.chevronRight,
                  title:
                      AppLocalization.of(context)!.translate('updateProfile')),
              SettingsTile(
                  leading: Icons.school,
                  onPressed: () {
                    Navigator.pushNamed(context, NavigationStrings.myCourses);
                  },
                  icon: AppLocalization.of(context)!.isArabicSelected(context)
                      ? FontAwesomeIcons.chevronLeft
                      : FontAwesomeIcons.chevronRight,
                  title:
                      AppLocalization.of(context)!.translate('myFormations')),
              SettingsTile(
                  leading: Icons.schedule,
                  onPressed: () {
                    Navigator.pushNamed(context, NavigationStrings.timetable);
                  },
                  icon: AppLocalization.of(context)!.isArabicSelected(context)
                      ? FontAwesomeIcons.chevronLeft
                      : FontAwesomeIcons.chevronRight,
                  title: AppLocalization.of(context)!.translate('timetable')),
              SettingsTile(
                  leading: Icons.book,
                  onPressed: () {
                    Navigator.pushNamed(context, NavigationStrings.books);
                  },
                  icon: AppLocalization.of(context)!.isArabicSelected(context)
                      ? FontAwesomeIcons.chevronLeft
                      : FontAwesomeIcons.chevronRight,
                  title: AppLocalization.of(context)!.translate('books')),
              SettingsTile(
                  leading: Icons.local_offer_outlined,
                  onPressed: () {
                    Navigator.pushNamed(context, NavigationStrings.offers);
                  },
                  icon: AppLocalization.of(context)!.isArabicSelected(context)
                      ? FontAwesomeIcons.chevronLeft
                      : FontAwesomeIcons.chevronRight,
                  title: AppLocalization.of(context)!.translate('offers')),
              SettingsTile(
                  leading: Icons.meeting_room,
                  onPressed: () {
                    Navigator.pushNamed(context, NavigationStrings.workshop);
                  },
                  icon: AppLocalization.of(context)!.isArabicSelected(context)
                      ? FontAwesomeIcons.chevronLeft
                      : FontAwesomeIcons.chevronRight,
                  title: AppLocalization.of(context)!.translate('conference')),
              SettingsTile(
                leading: Icons.logout,
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  final token = prefs.getString("token");
                  await prefs.remove("token");
                  await prefs.clear();
                  context.read<CredentialCubit>().resetState();

                  if (mounted) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  }

                  print("Token : $token");
                  //restartApp();
                },
                icon: AppLocalization.of(context)!.isArabicSelected(context)
                    ? FontAwesomeIcons.chevronLeft
                    : FontAwesomeIcons.chevronRight,
                title: AppLocalization.of(context)!.translate('logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
