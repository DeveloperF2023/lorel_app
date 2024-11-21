import 'package:flutter/material.dart';
import 'package:school_test_online/core/routes/routes.dart';
import 'package:school_test_online/features/domain/entities/user/user_entity.dart';
import 'package:school_test_online/features/presentation/pages/auth/login_screen.dart';
import 'package:school_test_online/features/presentation/pages/detail_my_courses/courses_list_screen.dart';
import 'package:school_test_online/features/presentation/pages/lives/lives_screen.dart';
import 'package:school_test_online/features/presentation/pages/main/main_screen.dart';
import 'package:school_test_online/features/presentation/pages/my_courses/my_courses_screen.dart';
import 'package:school_test_online/features/presentation/pages/no_network/no_network_screen.dart';
import 'package:school_test_online/features/presentation/pages/notifications/notification_screen.dart';
import 'package:school_test_online/features/presentation/pages/offers/favorites_screen.dart';
import 'package:school_test_online/features/presentation/pages/settings/update_password_screen.dart';
import 'package:school_test_online/features/presentation/pages/settings/update_profile_screen.dart';
import 'package:school_test_online/features/presentation/pages/settings/upload_avatar_screen.dart';
import 'package:school_test_online/features/presentation/pages/timetable/timetable_screen.dart';

import '../../features/presentation/pages/all_courses/all_courses_screen.dart';
import '../../features/presentation/pages/book/books_screen.dart';
import '../../features/presentation/pages/book/read_pdf_screen.dart';
import '../../features/presentation/pages/chat/detail_conversation_screen.dart';
import '../../features/presentation/pages/detail_course/detail_course_screen.dart';
import '../../features/presentation/pages/offers/detail_offer_screen.dart';
import '../../features/presentation/pages/offers/offers_screen.dart';
import '../../features/presentation/pages/payment/payment_screen.dart';
import '../../features/presentation/pages/registration/registration_course_screen.dart';
import '../../features/presentation/pages/request_diploma/request_diploma_screen.dart';
import '../../features/presentation/pages/success/success_registration_screen.dart';
import '../../features/presentation/pages/success/success_request_diploma_screen.dart';
import '../../features/presentation/pages/workshop/detail_workshop_screen.dart';
import '../../features/presentation/pages/workshop/workshop_screen.dart';
import '../../features/presentation/pages/zoom/zoom_screen.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    final args = settings.arguments;
    final String? token = UserEntity().token;

    switch (settings.name) {
      case NavigationStrings.login:
        {
          return routeBuilder(const LoginScreen());
        }
      case NavigationStrings.main:
        {
          if (args is String) {
            return routeBuilder(MainScreen(
              token: token!,
            ));
          }
        }
      case NavigationStrings.allCourses:
        {
          return routeBuilder(const AllCoursesScreen());
        }
      case NavigationStrings.detailCourse:
        {
          if (args is Map<String, dynamic>) {
            final int domainId = args['domainId'];
            final int formationId = args['formationId'];
            return routeBuilder(DetailCourseScreen(
                domainId: domainId, formationId: formationId));
          }
        }
      case NavigationStrings.registrationCourse:
        {
          if (args is Map<String, dynamic>) {
            return routeBuilder(RegistrationCourseScreen(
              selectedDiplomas: args['selectedDiplomas'],
              formationId: args['formationId'],
            ));
          }
        }
      case NavigationStrings.payment:
        {
          if (args is Map<String, dynamic>) {
            return routeBuilder(PaymentScreen(
              selectedDiploma: args['selectedDiplomas'],
              formationId: args['formationId'],
            ));
          }
        }
      case NavigationStrings.successRegistration:
        {
          return routeBuilder(const SuccessRegistrationScreen());
        }
      //case NavigationStrings.detailMyCourse:
      //         {
      //           if (args is Map<String, dynamic>) {
      //             final int courseId = args['courseId'];
      //             final int formationId = args['formationId'];
      //             final String title = args['title'];
      //             final List<CurrentCoursesEntity> courseList = args['courses'];
      //             return routeBuilder(DetailMyCoursesScreen(
      //               courseId: courseId,
      //               formationId: formationId,
      //               title: title,
      //               courses: courseList,
      //             ));
      //           }
      //         }
      case NavigationStrings.zoom:
        if (args is Map<String, dynamic>) {
          final String joinUrl1 = args['joinUrl1'];
          final String joinUrl2 = args['joinUrl2'];
          final int formationId = args['formationId'];
          return routeBuilder(ZoomScreen(
            joinUrl1: joinUrl1,
            joinUrl2: joinUrl2,
            formationId: formationId,
          ));
        }
      case NavigationStrings.requestDiploma:
        {
          if (args is int) {
            return routeBuilder(RequestDiplomaScreen(
              formationId: args,
            ));
          }
        }
      case NavigationStrings.successRequestDiploma:
        {
          return routeBuilder(const SuccessRequestDiplomaScreen());
        }
      case NavigationStrings.books:
        {
          return routeBuilder(const BooksScreen());
        }
      case NavigationStrings.readPdf:
        {
          if (args is Map<String, dynamic>) {
            final String title = args['title'];
            final String pdfUrl = args['pdfUrl'];
            return routeBuilder(ReadPdfScreen(
              title: title,
              pdfUrl: pdfUrl,
            ));
          }
        }
      case NavigationStrings.workshop:
        {
          return routeBuilder(const WorkshopScreen());
        }
      case NavigationStrings.detailWorkshop:
        {
          if (args is int) {
            return routeBuilder(DetailWorkshopScreen(
              workshopId: args,
            ));
          }
        }
      case NavigationStrings.offers:
        {
          return routeBuilder(const OffersScreen());
        }
      case NavigationStrings.myCourses:
        {
          return routeBuilder(const MyCoursesScreen());
        }
      case NavigationStrings.detailOffer:
        {
          if (args is Map<String, dynamic>) {
            final int offerId = args['offerId'];
            final bool initialFavoriteStatus = args['isFavorite'];
            return routeBuilder(DetailOfferScreen(
              offerId: offerId,
              initialFavoriteStatus: initialFavoriteStatus,
            ));
          }
        }
      case NavigationStrings.detailConversation:
        {
          if (args is Map<String, dynamic>) {
            final int conversationId = args['conversationId'];
            final String groupName = args['groupName'];
            final int currentUser = args['currentUser'];
            return routeBuilder(DetailConversationScreen(
              conversationId: conversationId,
              groupName: groupName,
              currentUser: currentUser,
            ));
          }
        }
      case NavigationStrings.timetable:
        {
          return routeBuilder(const TimetableScreen());
        }
      case NavigationStrings.notification:
        {
          return routeBuilder(const NotificationScreen());
        }
      case NavigationStrings.lives:
        {
          return routeBuilder(const LivesScreen());
        }
      case NavigationStrings.favorites:
        {
          return routeBuilder(const FavoritesScreen());
        }
      case NavigationStrings.updatePassword:
        {
          return routeBuilder(const UpdatePasswordScreen());
        }
      case NavigationStrings.updateProfile:
        {
          return routeBuilder(const UpdateProfileScreen());
        }
      case NavigationStrings.uploadAvatar:
        {
          return routeBuilder(const UploadAvatarScreen());
        }
      case NavigationStrings.noNetwork:
        {
          return routeBuilder(NoNetworkPage());
        }
      case NavigationStrings.coursesList:
        {
          if (args is Map<String, dynamic>) {
            final int formationId = args['formationId'];
            return routeBuilder(CoursesListScreen(
              formationId: formationId,
            ));
          }
        }
    }
  }
}

dynamic routeBuilder(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}

class NoPageFound extends StatelessWidget {
  const NoPageFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page not found"),
      ),
      body: const Center(
        child: Text("Page not found"),
      ),
    );
  }
}
