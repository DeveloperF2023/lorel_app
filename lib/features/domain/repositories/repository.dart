import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:school_test_online/features/domain/entities/enrollment/enrollment_entity.dart';
import 'package:school_test_online/features/domain/entities/lives/lives_entity.dart';
import 'package:school_test_online/features/domain/entities/notifications/notification_entity.dart';
import 'package:school_test_online/features/domain/entities/offers/favorite_entity.dart';
import 'package:school_test_online/features/domain/entities/payment/manual_payment_response_entity.dart';
import 'package:school_test_online/features/domain/entities/timetable/schedule_entity.dart';
import 'package:school_test_online/features/domain/entities/user/response_upload_avatar_entity.dart';

import '../../../core/error/failure.dart';
import '../entities/book/book_entity.dart';
import '../entities/chat/chat_entity.dart';
import '../entities/chat/message_entity.dart';
import '../entities/chat/send_message_response_entity.dart';
import '../entities/courses/courses_by_status_entity.dart';
import '../entities/courses/courses_entity.dart';
import '../entities/courses/detail_course_entity.dart';
import '../entities/domain/domain_entity.dart';
import '../entities/offers/detail_offer_entity.dart';
import '../entities/offers/offers_entity.dart';
import '../entities/payment/rib_entity.dart';
import '../entities/request_diploma/request_diploma_entity.dart';
import '../entities/user/request_register_user_entity.dart';
import '../entities/user/update_user_entity.dart';
import '../entities/user/user_entity.dart';
import '../entities/workshop/workshop_entity.dart';

abstract class Repository {
  ///User
  Future<Either<Failure, UserEntity>> loginUser(String email, String password);
  Future<Either<Failure, UserEntity>> registerUser(
      RequestRegisterUserEntity requests);
  Future<Either<Failure, UpdateUserEntity>> updateProfile(
      String lastName, String address, String phone, String country);
  Future<Either<Failure, ResponseUploadAvatarEntity>> uploadAvatar(
      String avatar);
  //Future<String> logout();
  Future<String> updatePassword(
      String oldPassword, String password, String confirmationPassword);
  Future<bool> isSignInUser();
  Future<String> getCurrentCustomerUser();

  ///Domain
  Future<Either<Failure, List<DomainEntity>>> getDomains();
  Future<Either<Failure, List<CoursesEntity>>> getCoursesByDomain(int domainId);

  ///Courses
  Future<Either<Failure, CoursesEntity>> getDetailOfFormation(
      int domainId, int formationId);
  Future<Either<Failure, List<CoursesByStatusEntity>>> getCoursesByStatus(
      String status);
  Future<Either<Failure, String>> startCourse(int courseId, int formationId);
  Future<Either<Failure, String>> finishCourse(int courseId, int formationId);
  Future<String> requestDiploma(RequestDiplomaEntity requests, int formationId);

  Future<Either<Failure, RibEntity>> getRib();
  Future<Either<Failure, DetailCourseEntity>> getDetailCourse(
      int courseId, int formationId);
  Future<Either<Failure, ManualPaymentResponseEntity>> manualPayment(
      String formationId, String additionalDiploma);

  ///Books (Bibliotheque)
  Future<Either<Failure, List<BookEntity>>> getBooks();
  Future<Either<Failure, List<BookEntity>>> searchBooks(String query);

  ///Workshops
  Future<Either<Failure, List<WorkshopEntity>>> getWorkshops();
  Future<Either<Failure, WorkshopEntity>> getWorkshopsById(int workshopId);

  ///Offers
  Future<Either<Failure, List<OffersEntity>>> getOffersByType(String type);
  Future<Either<Failure, DetailOfferEntity>> getDetailOffer(int offerId);
  Future<String> addToFavoriteList(int offerId);
  Future<String> deleteFromFavoriteList(int offerId);
  Future<Either<Failure, String>> applyOffer(int offerId, File resume);
  Future<Either<Failure, List<OffersEntity>>> searchOffers(String query);
  Future<Either<Failure, List<FavoriteEntity>>> getAllFavorite();

  ///Chat
  Future<Either<Failure, List<ChatEntity>>> getChat();
  Future<Either<Failure, List<MessageEntity>>> getMessages(int conversationId);
  Future<Either<Failure, SendMessageResponseEntity>> sendMessage(
      int conversationId, String content);
  Future<Either<Failure, SendMessageResponseEntity>> attachFile(
      int conversationId, File file, String type);

  ///Schedules
  Future<Either<Failure, Map<String, List<ScheduleEntity>>>> getSchedule(
      String weekKey);

  ///Notifications
  Future<Either<Failure, List<NotificationEntity>>> getAllNotification();

  ///Enrollment
  Future<Either<Failure, List<EnrollmentEntity>>> getEnrollments();

  ///Lives
  Future<Either<Failure, List<LivesEntity>>> getAllLives();
}
