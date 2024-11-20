import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:school_test_online/core/error/failure.dart';
import 'package:school_test_online/features/data/models/request_diploma/request_diploma_model.dart';
import 'package:school_test_online/features/data/models/user/requests_register_model.dart';
import 'package:school_test_online/features/domain/entities/book/book_entity.dart';
import 'package:school_test_online/features/domain/entities/chat/chat_entity.dart';
import 'package:school_test_online/features/domain/entities/chat/message_entity.dart';
import 'package:school_test_online/features/domain/entities/chat/send_message_response_entity.dart';
import 'package:school_test_online/features/domain/entities/courses/courses_by_status_entity.dart';
import 'package:school_test_online/features/domain/entities/courses/courses_entity.dart';
import 'package:school_test_online/features/domain/entities/courses/detail_course_entity.dart';
import 'package:school_test_online/features/domain/entities/domain/domain_entity.dart';
import 'package:school_test_online/features/domain/entities/enrollment/enrollment_entity.dart';
import 'package:school_test_online/features/domain/entities/lives/lives_entity.dart';
import 'package:school_test_online/features/domain/entities/notifications/notification_entity.dart';
import 'package:school_test_online/features/domain/entities/offers/favorite_entity.dart';
import 'package:school_test_online/features/domain/entities/offers/offers_entity.dart';
import 'package:school_test_online/features/domain/entities/payment/manual_payment_response_entity.dart';
import 'package:school_test_online/features/domain/entities/payment/rib_entity.dart';
import 'package:school_test_online/features/domain/entities/request_diploma/request_diploma_entity.dart';
import 'package:school_test_online/features/domain/entities/timetable/schedule_entity.dart';
import 'package:school_test_online/features/domain/entities/user/request_register_user_entity.dart';
import 'package:school_test_online/features/domain/entities/user/response_upload_avatar_entity.dart';
import 'package:school_test_online/features/domain/entities/user/update_user_entity.dart';
import 'package:school_test_online/features/domain/entities/user/user_entity.dart';
import 'package:school_test_online/features/domain/entities/workshop/workshop_entity.dart';
import 'package:school_test_online/features/domain/repositories/repository.dart';

import '../../domain/entities/offers/detail_offer_entity.dart';
import '../data_sources/remote_data_source_impl.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSourceImpl remoteDataSourceImpl;

  RepositoryImpl({required this.remoteDataSourceImpl});
  @override
  Future<Either<Failure, UserEntity>> loginUser(
      String email, String password) async {
    try {
      final result = await remoteDataSourceImpl.loginUser(email, password);
      return Right(result);
    } on Exception {
      return const Left(ServerFailure(message: 'An error has occurred'));
    }
  }

  @override
  Future<String> getCurrentCustomerUser() async =>
      remoteDataSourceImpl.getCurrentCustomerUser();

  @override
  Future<bool> isSignInUser() async => remoteDataSourceImpl.isSignInUser();

  @override
  Future<Either<Failure, List<DomainEntity>>> getDomains() async {
    try {
      final result = await remoteDataSourceImpl.getDomains();
      return Right(result);
    } on Exception {
      return const Left(ServerFailure(message: 'An error has occurred'));
    }
  }

  @override
  Future<Either<Failure, List<CoursesEntity>>> getCoursesByDomain(
      int domainId) async {
    try {
      final result = await remoteDataSourceImpl.getCoursesByDomain(domainId);
      return Right(result);
    } on Exception {
      return const Left(ServerFailure(message: 'An error has occurred'));
    }
  }

  @override
  Future<Either<Failure, CoursesEntity>> getDetailOfFormation(
      int domainId, int formationId) async {
    try {
      final result =
          await remoteDataSourceImpl.getDetailFormation(domainId, formationId);
      return Right(result);
    } on Exception {
      return const Left(ServerFailure(message: 'An error has occurred'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> registerUser(
      RequestRegisterUserEntity requests) async {
    try {
      final result = await remoteDataSourceImpl
          .registerUser(requests as RequestRegisterUserModel);
      return Right(result);
    } on Exception {
      return const Left(ServerFailure(message: 'An error has occurred'));
    }
  }

  @override
  Future<Either<Failure, RibEntity>> getRib() async {
    try {
      final result = await remoteDataSourceImpl.getRib();
      return Right(result);
    } on Exception {
      return const Left(ServerFailure(message: 'An error has occurred'));
    }
  }

  @override
  Future<Either<Failure, List<CoursesByStatusEntity>>> getCoursesByStatus(
      String status) async {
    try {
      final result = await remoteDataSourceImpl.getCoursesByStatus(status);
      return Right(result);
    } on Exception {
      return const Left(ServerFailure(message: 'An error has occurred'));
    }
  }

  @override
  Future<String> requestDiploma(
          RequestDiplomaEntity requests, int formationId) async =>
      remoteDataSourceImpl.requestDiploma(
          requests as RequestDiplomaModel, formationId);

  @override
  Future<Either<Failure, DetailCourseEntity>> getDetailCourse(
      int courseId, int formationId) async {
    try {
      final result =
          await remoteDataSourceImpl.getDetailCourse(courseId, formationId);
      return Right(result);
    } on Exception {
      return const Left(ServerFailure(message: 'An error has occurred'));
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> getBooks() async {
    try {
      final result = await remoteDataSourceImpl.getBooks();
      return Right(result);
    } on Exception {
      return const Left(ServerFailure(message: 'An error has occurred'));
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> searchBooks(String query) async {
    try {
      final result = await remoteDataSourceImpl.searchBooks(query);
      return Right(result);
    } on Exception {
      return const Left(ServerFailure(message: 'An error has occurred'));
    }
  }

  @override
  Future<Either<Failure, WorkshopEntity>> getWorkshopsById(
      int workshopId) async {
    try {
      final result = await remoteDataSourceImpl.getWorkshopsById(workshopId);
      return Right(result);
    } on Exception {
      return const Left(ServerFailure(message: 'An error has occurred'));
    }
  }

  @override
  Future<Either<Failure, List<OffersEntity>>> getOffersByType(
      String type) async {
    try {
      final result = await remoteDataSourceImpl.getOffersByType(type);
      return Right(result);
    } on Exception {
      return const Left(ServerFailure(message: 'An error has occurred'));
    }
  }

  @override
  Future<Either<Failure, DetailOfferEntity>> getDetailOffer(int offerId) async {
    try {
      final result = await remoteDataSourceImpl.getDetailOffer(offerId);
      return Right(result);
    } on Exception {
      return const Left(ServerFailure(message: 'An error has occurred'));
    }
  }

  @override
  Future<String> addToFavoriteList(int offerId) async =>
      remoteDataSourceImpl.addToFavoriteList(offerId);

  @override
  Future<String> deleteFromFavoriteList(int offerId) async =>
      remoteDataSourceImpl.deleteFromFavoriteList(offerId);

  @override
  Future<Either<Failure, List<ChatEntity>>> getChat() async {
    try {
      final result = await remoteDataSourceImpl.getChat();
      return Right(result);
    } on Exception {
      return const Left(ServerFailure(message: 'An error has occurred'));
    }
  }

  @override
  Future<Either<Failure, List<MessageEntity>>> getMessages(
      int conversationId) async {
    try {
      final result = await remoteDataSourceImpl.getMessages(conversationId);
      return Right(result);
    } on Exception {
      return const Left(ServerFailure(message: 'An error has occurred'));
    }
  }

  @override
  Future<Either<Failure, SendMessageResponseEntity>> sendMessage(
      conversationId, String content) async {
    try {
      final result =
          await remoteDataSourceImpl.sendMessage(conversationId, content);
      return Right(result);
    } on Exception {
      return const Left(ServerFailure(message: 'An error has occurred'));
    }
  }

  @override
  Future<Either<Failure, Map<String, List<ScheduleEntity>>>> getSchedule(
      String weekKey) async {
    try {
      final result = await remoteDataSourceImpl.getSchedule(weekKey);
      return Right(result);
    } on Exception {
      return const Left(ServerFailure(message: 'An error has occurred'));
    }
  }

  @override
  Future<Either<Failure, SendMessageResponseEntity>> attachFile(
      int conversationId, File file, String type) async {
    try {
      final result =
          await remoteDataSourceImpl.attachFile(conversationId, file, type);
      return Right(result);
    } on Exception {
      return const Left(ServerFailure(message: 'An error has occurred'));
    }
  }

  @override
  Future<Either<Failure, String>> applyOffer(int offerId, File resume) async {
    try {
      final result = await remoteDataSourceImpl.applyToOffer(offerId, resume);
      return Right(result);
    } on Exception {
      return const Left(ServerFailure(message: 'An error has occurred'));
    }
  }

  @override
  Future<Either<Failure, ManualPaymentResponseEntity>> manualPayment(
      String formationId, String? additionalDiploma) async {
    try {
      final result = await remoteDataSourceImpl.manualPayment(
          formationId, additionalDiploma!);
      return Right(result);
    } on DioException catch (e) {
      // Extract the error message from the response if available
      final errorMessage = e.response?.data['message'];
      return Left(ServerFailure(message: errorMessage));
    } catch (e) {
      return const Left(ServerFailure(message: 'An error has occurred'));
    }
  }

  @override
  Future<Either<Failure, List<OffersEntity>>> searchOffers(String query) async {
    try {
      final result = await remoteDataSourceImpl.searchOffers(query);
      return Right(result);
    } on Exception {
      return const Left(ServerFailure(message: 'An error has occurred'));
    }
  }

  @override
  Future<Either<Failure, List<WorkshopEntity>>> getWorkshops() async {
    try {
      final workshops = await remoteDataSourceImpl.getWorkshops();
      return Right(workshops);
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }

  @override
  Future<String> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<NotificationEntity>>> getAllNotification() async {
    try {
      final workshops = await remoteDataSourceImpl.getAllNotification();
      return Right(workshops);
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<EnrollmentEntity>>> getEnrollments() async {
    try {
      final workshops = await remoteDataSourceImpl.getEnrollment();
      return Right(workshops);
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<LivesEntity>>> getAllLives() async {
    try {
      final lives = await remoteDataSourceImpl.getAllLives();
      return Right(lives);
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FavoriteEntity>>> getAllFavorite() async {
    try {
      final lives = await remoteDataSourceImpl.getFavorites();
      return Right(lives);
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }

  @override
  Future<String> updatePassword(String oldPassword, String password,
          String confirmationPassword) async =>
      remoteDataSourceImpl.updatePassword(
          oldPassword, password, confirmationPassword);

  @override
  Future<Either<Failure, UpdateUserEntity>> updateProfile(
      String lastName, String address, String phone, String country) async {
    try {
      final updateProfile = await remoteDataSourceImpl.updateProfile(
          lastName, address, phone, country);
      return Right(updateProfile);
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ResponseUploadAvatarEntity>> uploadAvatar(
      String avatar) async {
    try {
      final updateProfile = await remoteDataSourceImpl.uploadAvatar(avatar);
      return Right(updateProfile);
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> startCourse(
      int courseId, int formationId) async {
    try {
      final startCourse =
          await remoteDataSourceImpl.startCourse(courseId, formationId);
      return Right(startCourse);
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> finishCourse(
      int courseId, int formationId) async {
    try {
      final finishCourse =
          await remoteDataSourceImpl.finishCourse(courseId, formationId);
      return Right(finishCourse);
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }
}
