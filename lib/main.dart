import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:school_test_online/core/api/api_client.dart';
import 'package:school_test_online/core/utils/helpers/helper_functions.dart';
import 'package:school_test_online/core/utils/helpers/preferences_helpers.dart';
import 'package:school_test_online/features/data/data_sources/remote_data_source.dart';
import 'package:school_test_online/features/data/data_sources/remote_data_source_impl.dart';
import 'package:school_test_online/features/presentation/manager/books/get_books/get_books_cubit.dart';
import 'package:school_test_online/features/presentation/manager/books/search_book/search_book_cubit.dart';
import 'package:school_test_online/features/presentation/manager/chat/attach_file_to_conversation/attach_file_to_conversation_cubit.dart';
import 'package:school_test_online/features/presentation/manager/chat/get_conversations/get_conversations_cubit.dart';
import 'package:school_test_online/features/presentation/manager/chat/get_messages/get_messages_cubit.dart';
import 'package:school_test_online/features/presentation/manager/chat/send_message/send_message_cubit.dart';
import 'package:school_test_online/features/presentation/manager/courses/get_courses_by_domain/get_courses_by_domain_cubit.dart';
import 'package:school_test_online/features/presentation/manager/courses/get_courses_by_status/get_courses_by_status_cubit.dart';
import 'package:school_test_online/features/presentation/manager/courses/toggle_buttons/toggle_buttons_cubit.dart';
import 'package:school_test_online/features/presentation/manager/domains/get_domains/get_domains_cubit.dart';
import 'package:school_test_online/features/presentation/manager/lives/get_lives/get_lives_cubit.dart';
import 'package:school_test_online/features/presentation/manager/notifications/get_notifications/get_notifications_cubit.dart';
import 'package:school_test_online/features/presentation/manager/offers/add_to_favorite_list/add_to_favorite_list_cubit.dart';
import 'package:school_test_online/features/presentation/manager/offers/apply_to_offer/apply_to_offer_cubit.dart';
import 'package:school_test_online/features/presentation/manager/offers/get_detail_offer/get_detail_offer_cubit.dart';
import 'package:school_test_online/features/presentation/manager/offers/get_favorites/get_favorites_cubit.dart';
import 'package:school_test_online/features/presentation/manager/offers/get_offers_by_type/get_offers_by_type_cubit.dart';
import 'package:school_test_online/features/presentation/manager/offers/search_offers/search_offers_cubit.dart';
import 'package:school_test_online/features/presentation/manager/payment/get_rib/get_rib_cubit.dart';
import 'package:school_test_online/features/presentation/manager/payment/manual_payment/manual_payment_cubit.dart';
import 'package:school_test_online/features/presentation/manager/request_diploma/request_diploma_cubit.dart';
import 'package:school_test_online/features/presentation/manager/timetable/get_schedule/get_schedule_cubit.dart';
import 'package:school_test_online/features/presentation/manager/user/update_password/update_password_cubit.dart';
import 'package:school_test_online/features/presentation/manager/user/update_profile/update_profile_cubit.dart';
import 'package:school_test_online/features/presentation/manager/user/upload_avatar/upload_avatar_cubit.dart';
import 'package:school_test_online/features/presentation/manager/workshops/get_detail_workshop/get_detail_workshop_cubit.dart';
import 'package:school_test_online/features/presentation/manager/workshops/get_workshops/get_workshops_cubit.dart';
import 'package:school_test_online/features/presentation/pages/language/language_screen.dart';
import 'package:school_test_online/features/presentation/pages/main/main_screen.dart';
import 'package:school_test_online/features/presentation/pages/no_network/no_network_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/routes/on_general_routes.dart';
import 'core/utils/helpers/locale_service.dart';
import 'core/utils/helpers/pusher_service.dart';
import 'dependencies_injection.dart';
import 'features/presentation/manager/courses/get_detail_course/get_detail_course_cubit.dart';
import 'features/presentation/manager/courses/get_detail_formation/get_detail_formation_cubit.dart';
import 'features/presentation/manager/offers/remove_from_favorite_list/remove_from_favorite_list_cubit.dart';
import 'features/presentation/manager/offers/toggle_offers/toggle_offers_cubit.dart';
import 'features/presentation/manager/user/auth/auth_cubit.dart';
import 'features/presentation/manager/user/credential/credential_cubit.dart';
import 'features/presentation/manager/user/register_user/register_user_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  await initializeDateFormatting();
  Dio client = Dio();
  ApiClient apiClient = ApiClient(client);
  SharedPreferences _preferences = await SharedPreferences.getInstance();
  PreferencesHelper preferences = PreferencesHelper(_preferences);
  RemoteDataSource remoteDataSource = RemoteDataSourceImpl(
      client: client, apiClient: apiClient, preferencesHelper: preferences);
  print(remoteDataSource.finishCourse(1, 1));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  final Locale? locale;
  const MyApp({super.key, this.locale});

  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(locale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  int? userId;
  String? groupId;
  Timer? _timer;
  late PusherService pusherService;
  bool _isConnected = true;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  bool _isOnNoNetworkPage = false;

  /// Sets the locale for the app
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  Locale _locale = const Locale("en");

  /// Changes the language and updates the locale in SharedPreferences
  void _changeLanguage(Locale locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('locale', locale.languageCode); // Save language code
    setState(() {
      _locale = locale;
    });
    MyApp.setLocale(context, locale);
  }

  /// Changes the language from settings
  void _changeLanguageForSetting(String locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('locale', locale); // Save language code
    setState(() {
      _locale = Locale(locale); // Update locale
    });
    MyApp.setLocale(context, Locale(locale));
  }

  /// Checks internet connectivity by pinging Google
  Future<void> _checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _updateConnectionStatus(true);
      } else {
        _updateConnectionStatus(false);
      }
    } on SocketException catch (_) {
      _updateConnectionStatus(false);
    }
  }

  /// Updates the UI and handles navigation based on connection status
  void _updateConnectionStatus(bool isConnected) async {
    //print("Current connection status: $_isConnected, New status: $isConnected");
    if (_isConnected != isConnected) {
      setState(() {
        _isConnected = isConnected;
      });

      if (!isConnected && mounted && !_isOnNoNetworkPage) {
        print("Navigating to NoNetworkPage due to lost connection");
        navigatorKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const NoNetworkPage()),
          (route) => false,
        );
        _isOnNoNetworkPage = true;
      } else if (isConnected && _isOnNoNetworkPage) {
        //print("Network reconnected, returning to main screen");
        navigatorKey.currentState?.pop();
        _isOnNoNetworkPage = false;
      }
    }
  }

  /// Starts a periodic check for connectivity
  void _startConnectivityCheck() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      //print("Checking connectivity...");
      _checkInternetConnection();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadLocale();
    _startConnectivityCheck();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_notification');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    initializePusherAndNotifications();
    requestNotificationPermission();
  }

  /// Initializes Pusher service and subscribes to channels for notifications
  Future<void> initializePusherAndNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('userId')!;
    groupId = prefs.getString("groupIds");
    print("user id $userId");
    print("group id $groupId");
    if (userId != null) {
      pusherService = PusherService("2d18b004034647ac52b3", "eu");

      subscribeToPusherChannels();

      pusherService.subscribeToChannel('formations', {'formations.create': ''},
          (event) {
        print('Formation created: ${event!.data}');
        showNotification("Nouvelle Formation",
            "une nouvelle formation ajouté.N'hésitez pas de vérifier");
      });
      pusherService.subscribeToChannel('books', {'books.create': ''}, (event) {
        print('Book created: ${event!.data}');
        showNotification('Nouveau Livre', 'A new Books has been added.');
      });
      if (groupId != null) {
        List<int> groupIds = List<int>.from(jsonDecode(groupId.toString()));

        for (int groupId in groupIds) {
          pusherService.subscribeToChannel(
              'lives', {'lives.create.$groupId': groupId.toString()}, (event) {
            print('Live created for group ID $groupId: ${event!.data}');
            showNotification("Live created", "New live for group ID $groupId");
          });
        }
      } else {
        print("No group IDs found");
      }
    } else {
      print("User ID not found in SharedPreferences.");
    }
  }

  Future<void> requestNotificationPermission() async {
    final bool granted = await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestNotificationsPermission() ??
        false;

    if (!granted) {
      print("Notification permission denied");
    }
  }

  Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'important_notifications',
      'Important Notifications',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'item id 2',
    );
  }

  @override
  void dispose() {
    if (userId != null) {
      pusherService.unsubscribeFromAllChannels();
      pusherService.disconnect();
    }
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    super.dispose();
  }

  void subscribeToPusherChannels() {
    if (!pusherService.isSubscribedToChannel('enrollments')) {
      pusherService.subscribeToChannel('enrollments', {
        'enrollments.approve.$userId': userId.toString(),
        'enrollments.assign.$userId': userId.toString(),
        'enrollments.reject.$userId': userId.toString(),
      }, (event) {
        print('Enrollment event for user $userId: ${event!.data}');
        showNotification("Enrollment Created", "Enrollments test");
      });
    }
  }

  /// Loads saved locale from SharedPreferences
  Future<void> _loadLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('locale');

    if (languageCode != null) {
      setState(() {
        _locale = Locale(languageCode);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(
        "Height: ${HelperFunctions.screenHeight(context)}, Width: ${HelperFunctions.screenWidth(context)}");
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<AuthCubit>()..appStarted(context)),
        BlocProvider(create: (_) => locator<CredentialCubit>()),
        BlocProvider(create: (_) => locator<GetDomainsCubit>()),
        BlocProvider(create: (_) => locator<GetCoursesByDomainCubit>()),
        BlocProvider(create: (_) => locator<GetDetailFormationCubit>()),
        BlocProvider(create: (_) => locator<RegisterUserCubit>()),
        BlocProvider(create: (_) => locator<GetRibCubit>()),
        BlocProvider(create: (_) => locator<GetCoursesByStatusCubit>()),
        BlocProvider(create: (_) => locator<ToggleButtonsCubit>()),
        BlocProvider(create: (_) => locator<GetDetailCourseCubit>()),
        BlocProvider(create: (_) => locator<RequestDiplomaCubit>()),
        BlocProvider(create: (_) => locator<GetBooksCubit>()),
        BlocProvider(create: (_) => locator<SearchBookCubit>()),
        BlocProvider(create: (_) => locator<GetWorkshopsCubit>()),
        BlocProvider(create: (_) => locator<GetDetailWorkshopCubit>()),
        BlocProvider(create: (_) => locator<ToggleOffersCubit>()),
        BlocProvider(create: (_) => locator<GetOffersByTypeCubit>()),
        BlocProvider(create: (_) => locator<GetDetailOfferCubit>()),
        BlocProvider(create: (_) => locator<AddToFavoriteListCubit>()),
        BlocProvider(create: (_) => locator<RemoveFromFavoriteListCubit>()),
        BlocProvider(create: (_) => locator<GetConversationsCubit>()),
        BlocProvider(create: (_) => locator<GetMessagesCubit>()),
        BlocProvider(create: (_) => locator<SendMessageCubit>()),
        BlocProvider(create: (_) => locator<GetScheduleCubit>()),
        BlocProvider(create: (_) => locator<AttachFileToConversationCubit>()),
        BlocProvider(create: (_) => locator<ApplyToOfferCubit>()),
        BlocProvider(create: (_) => locator<ManualPaymentCubit>()),
        BlocProvider(create: (_) => locator<SearchOffersCubit>()),
        BlocProvider(create: (_) => locator<GetNotificationsCubit>()),
        BlocProvider(create: (_) => locator<GetLivesCubit>()),
        BlocProvider(create: (_) => locator<GetFavoritesCubit>()),
        BlocProvider(create: (_) => locator<UpdatePasswordCubit>()),
        BlocProvider(create: (_) => locator<UpdateProfileCubit>()),
        BlocProvider(create: (_) => locator<UploadAvatarCubit>()),
      ],
      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          navigatorKey: navigatorKey,
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          locale: _locale,
          supportedLocales: const [
            Locale('en', ''),
            Locale('fr', ''),
            Locale('ar', ''),
          ],
          localizationsDelegates: [
            AppLocalizationsDelegate(_locale),
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          onGenerateRoute: OnGenerateRoute.route,
          initialRoute: "/",
          routes: {
            "/": (context) => BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, authState) {
                    if (authState is Authenticated) {
                      return MainScreen(
                        token: authState.userToken!,
                        onLocaleChange: _changeLanguageForSetting,
                      );
                    } else {
                      return LanguageScreen(onLocaleChange: _changeLanguage);
                    }
                  },
                ),
          },
        ),
      ),
    );
  }
}
