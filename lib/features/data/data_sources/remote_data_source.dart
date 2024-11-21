import 'dart:io';

import 'package:school_test_online/features/data/models/books/book_model.dart';
import 'package:school_test_online/features/data/models/chat/chat_model.dart';
import 'package:school_test_online/features/data/models/chat/message_model.dart';
import 'package:school_test_online/features/data/models/chat/send_message_response_model.dart';
import 'package:school_test_online/features/data/models/courses/courses_by_status_model.dart';
import 'package:school_test_online/features/data/models/courses/courses_model.dart';
import 'package:school_test_online/features/data/models/courses/detail_course_model.dart';
import 'package:school_test_online/features/data/models/domain/domain_model.dart';
import 'package:school_test_online/features/data/models/enrollment/enrollment_model.dart';
import 'package:school_test_online/features/data/models/lives/lives_model.dart';
import 'package:school_test_online/features/data/models/notfications/notification_model.dart';
import 'package:school_test_online/features/data/models/offers/detail_offer_model.dart';
import 'package:school_test_online/features/data/models/offers/favorites_model.dart';
import 'package:school_test_online/features/data/models/offers/offers_model.dart';
import 'package:school_test_online/features/data/models/payment/manual_payment_response_model.dart';
import 'package:school_test_online/features/data/models/request_diploma/request_diploma_model.dart';
import 'package:school_test_online/features/data/models/timetable/schedule_model.dart';
import 'package:school_test_online/features/data/models/user/requests_register_model.dart';
import 'package:school_test_online/features/data/models/user/response_upload_avatar_model.dart';
import 'package:school_test_online/features/data/models/user/update_profile_model.dart';
import 'package:school_test_online/features/data/models/workshops/workshops_model.dart';

import '../models/payment/rib_model.dart';
import '../models/user/user_model.dart';

abstract class RemoteDataSource {
  ///User
  Future<UserModel> loginUser(String email, String password);
  Future<UpdateProfileModel> updateProfile(
      String lastName, String address, String phone, String country);
  Future<UserModel> registerUser(RequestRegisterUserModel requests);
  Future<ResponseUploadAvatarModel> uploadAvatar(String avatar);
  Future<String> updatePassword(
      String oldPassword, String password, String confirmationPassword);
  Future<String> getCurrentCustomerUser();
  Future<bool> isSignInUser();

  ///Domain
  Future<List<DomainModel>> getDomains();
  Future<List<CoursesModel>> getCoursesByDomain(int domainId);

  ///Courses
  Future<CoursesModel> getDetailFormation(int domainId, int formationId);
  Future<List<CoursesByStatusModel>> getCoursesByStatus(String status);
  Future<String> startCourse(int courseId, int formationId);
  Future<List<DetailCourseModel>> getCoursesOfFormation(int formationId);
  Future<String> finishCourse(int courseId, int formationId);
  Future<String> requestDiploma(RequestDiplomaModel requests, int formationId);
  Future<RibModel> getRib();
  Future<DetailCourseModel> getDetailCourse(int courseId, int formationId);
  Future<ManualPaymentResponseModel> manualPayment(
      String formationId, String? additionalDiploma);

  ///Books
  Future<List<BookModel>> getBooks();
  Future<List<BookModel>> searchBooks(String query);

  ///Workshops
  Future<List<WorkshopModel>> getWorkshops();
  Future<WorkshopModel> getWorkshopsById(int workshopId);

  ///Offers
  Future<List<OffersModel>> getOffersByType(String type);
  Future<DetailOfferModel> getDetailOffer(int offerId);
  Future<String> addToFavoriteList(int offerId);
  Future<String> deleteFromFavoriteList(int offerId);
  Future<String> applyToOffer(int offerId, File resume);
  Future<List<OffersModel>> searchOffers(String query);
  Future<List<FavoriteModel>> getFavorites();

  ///Chat
  Future<List<ChatModel>> getChat();
  Future<List<MessagesModel>> getMessages(int conversationId);
  Future<SendMessageResponseModel> sendMessage(
      int conversationId, String content);
  Future<SendMessageResponseModel> attachFile(
      int conversationId, File file, String type);

  ///Schedules
  Future<Map<String, List<ScheduleModel>>> getSchedule(String weekKey);

  ///Notifications
  Future<List<NotificationModel>> getAllNotification();

  ///Enrollments
  Future<List<EnrollmentModel>> getEnrollment();

  ///Lives
  Future<List<LivesModel>> getAllLives();
}
