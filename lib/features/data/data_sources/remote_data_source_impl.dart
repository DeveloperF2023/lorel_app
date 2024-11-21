import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:school_test_online/core/api/api_client.dart';
import 'package:school_test_online/core/api/constants_api.dart';
import 'package:school_test_online/core/utils/helpers/preferences_helpers.dart';
import 'package:school_test_online/features/data/data_sources/remote_data_source.dart';
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
import 'package:school_test_online/features/data/models/payment/rib_model.dart';
import 'package:school_test_online/features/data/models/timetable/schedule_model.dart';
import 'package:school_test_online/features/data/models/user/requests_register_model.dart';
import 'package:school_test_online/features/data/models/user/response_upload_avatar_model.dart';
import 'package:school_test_online/features/data/models/user/update_profile_model.dart';
import 'package:school_test_online/features/data/models/workshops/workshops_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/request_diploma/request_diploma_model.dart';
import '../models/user/user_model.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  final Dio client;
  final ApiClient apiClient;
  final PreferencesHelper preferencesHelper;
  RemoteDataSourceImpl(
      {required this.client,
      required this.apiClient,
      required this.preferencesHelper});

  /// --------------------Start Users-----------------------------
  /// ************************************************************
  @override
  Future<UserModel> loginUser(String email, String password) async {
    final response = await apiClient.postRequest(
        "${EndpointsConstants.baseUrl}${EndpointsConstants.login}",
        {"email": email, "password": password},
        null,
        false);

    if (response.statusCode == 200) {
      await preferencesHelper.saveUserDetails(response.data);
      return UserModel.fromJson(response.data);
    } else {
      throw Exception('Failed to login user');
    }
  }

  @override
  Future<String> getCurrentCustomerUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token")!;
    print("token $token");
    return token;
  }

  @override
  Future<bool> isSignInUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token")!;
    print("token $token");
    if (token != "") {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<UserModel> registerUser(RequestRegisterUserModel requests) async {
    final response = await apiClient.postRequest(
        "${EndpointsConstants.baseUrl}${EndpointsConstants.register}",
        requests.toJson(),
        null,
        false);
    print(response.data);
    if (response.statusCode == 201) {
      await preferencesHelper.saveUserDetailsRegister(response.data);
      print("OK");
      return UserModel.fromJson(response.data);
    } else {
      throw Exception('Failed to register user');
    }
  }

  @override
  Future<String> updatePassword(
      String oldPassword, String password, String confirmationPassword) async {
    final token = await preferencesHelper.getToken();
    print("Token: $token");
    final response = await apiClient.postRequest(
        "${EndpointsConstants.baseUrl}${EndpointsConstants.updatePassword}",
        {
          "old_password": oldPassword,
          "password": password,
          "password_confirmation": confirmationPassword
        },
        token,
        false);

    if (response.statusCode == 200) {
      return response.data['message'];
    } else {
      throw Exception('Failed to update Password');
    }
  }

  @override
  Future<UpdateProfileModel> updateProfile(
      String lastName, String address, String phone, String country) async {
    final token = await preferencesHelper.getToken();
    final response = await apiClient.patchRequest(
        "${EndpointsConstants.baseUrl}${EndpointsConstants.updateUser}",
        {
          "name": lastName,
          "address": address,
          "phone": phone,
          "country": country
        },
        token);

    if (response.statusCode == 200) {
      return UpdateProfileModel.fromJson(response.data);
    } else {
      throw Exception('Failed to update profile');
    }
  }

  @override
  Future<ResponseUploadAvatarModel> uploadAvatar(String avatar) async {
    final token = await preferencesHelper.getToken();
    final formData = FormData.fromMap({
      'avatar': await MultipartFile.fromFile(avatar, filename: 'avatar.png'),
    });
    final response = await apiClient.postRequest(
        "${EndpointsConstants.baseUrl}${EndpointsConstants.uploadAvatar}",
        formData,
        token,
        true);

    if (response.statusCode == 200) {
      return ResponseUploadAvatarModel.fromJson(response.data);
    } else {
      throw Exception('Failed to upload avatar');
    }
  }

  /// --------------------End Users-----------------------------
  /// ************************************************************

  /// --------------------Start Domain-----------------------------
  /// ************************************************************
  @override
  Future<List<DomainModel>> getDomains() async {
    final response = await apiClient.getRequest(
        "${EndpointsConstants.baseUrl}${EndpointsConstants.domains}", null);
    if (response.statusCode == 200) {
      return DomainModel.fromJsonList(response.data);
    } else {
      throw Exception('Failed to get domains');
    }
  }

  @override
  Future<List<CoursesModel>> getCoursesByDomain(int domainId) async {
    final response = await apiClient.getRequest(
        "${EndpointsConstants.baseUrl}domains/$domainId/formations", null);
    if (response.statusCode == 200) {
      return CoursesModel.fromJsonList(response.data);
    } else {
      throw Exception('Failed to get courses domain');
    }
  }

  /// ************************************************************
  /// --------------------End Domains-----------------------------

  /// --------------------Start Courses-----------------------------
  /// ************************************************************
  @override
  Future<CoursesModel> getDetailFormation(int domainId, int formationId) async {
    final response = await apiClient.getRequest(
        "${EndpointsConstants.baseUrl}domains/$domainId/formations/$formationId",
        null);
    if (response.statusCode == 200) {
      return CoursesModel.fromJson(response.data);
    } else {
      throw Exception('Failed to get Detail formation');
    }
  }

  @override
  Future<RibModel> getRib() async {
    final response = await apiClient.getRequest(
        "${EndpointsConstants.baseUrl}${EndpointsConstants.settings}", null);

    print("this is status code rib :${response.statusCode}");
    if (response.statusCode == 200) {
      print("success status code");
      print(response.data);
      if (response.data is Map<String, dynamic>) {
        return RibModel.fromJson(response.data);
      } else if (response.data is String) {
        return RibModel(rib: response.data);
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('Failed to get Rib');
    }
  }

  @override
  Future<List<CoursesByStatusModel>> getCoursesByStatus(String status) async {
    final token = await preferencesHelper.getToken();
    final response = await apiClient.getRequest(
        "${EndpointsConstants.baseUrl}${EndpointsConstants.formationByStatus}/$status",
        token);
    if (response.statusCode == 200) {
      return CoursesByStatusModel.fromJsonList(response.data);
    } else {
      throw Exception('Failed to get courses by status');
    }
  }

  @override
  Future<String> requestDiploma(
      RequestDiplomaModel requests, int formationId) async {
    final token = await preferencesHelper.getToken();
    final response = await apiClient.postRequest(
        "${EndpointsConstants.baseUrl}formations/$formationId/request_diploma",
        jsonEncode(requests.toJson()),
        token,
        false);
    if (response.statusCode == 200) {
      return response.data['message'];
    } else {
      throw Exception('Failed to request diploma');
    }
  }

  @override
  Future<DetailCourseModel> getDetailCourse(
      int courseId, int formationId) async {
    final token = await preferencesHelper.getToken();
    final response = await apiClient.getRequest(
        "${EndpointsConstants.baseUrl}formations/$formationId/courses/$courseId",
        token);
    if (response.statusCode == 200) {
      return DetailCourseModel.fromJson(response.data);
    } else {
      throw Exception('Failed to get detail course');
    }
  }

  @override
  Future<ManualPaymentResponseModel> manualPayment(
      String formationId, String? additionalDiploma) async {
    final token = await preferencesHelper.getToken();
    final requestData = {
      "formation_id": formationId,
      if (additionalDiploma != null && additionalDiploma.isNotEmpty)
        "additional_diplomas": additionalDiploma
      else
        "additional_diplomas": "maroc"
    };
    final response = await apiClient.postRequest(
        "${EndpointsConstants.baseUrl}${EndpointsConstants.manualPayment}",
        requestData,
        token,
        false);
    if (response.statusCode == 200) {
      return ManualPaymentResponseModel.fromJson(response.data);
    } else {
      throw Exception(
          'Server error with status code ${response.statusCode}: ${response.data}');
    }
  }

  @override
  Future<String> startCourse(int courseId, int formationId) async {
    final token = await preferencesHelper.getToken();
    final response = await apiClient.patchRequest(
        "${EndpointsConstants.baseUrl}formations/$formationId/courses/$courseId/start",
        null,
        token);
    print("Response start course: ${response.data}");
    print("Response status code: ${response.statusCode}");
    print("Token: $token");
    if (response.statusCode == 200) {
      return response.data["message"];
    } else {
      throw Exception('Failed to update profile');
    }
  }

  @override
  Future<String> finishCourse(int courseId, int formationId) async {
    final token = await preferencesHelper.getToken();
    final response = await apiClient.patchRequest(
        "${EndpointsConstants.baseUrl}formations/$formationId/courses/$courseId/finish",
        null,
        token);
    print("Response start course: ${response.data}");
    print("Response status code: ${response.statusCode}");
    print("Token: $token");
    if (response.statusCode == 200) {
      return response.data["message"];
    } else {
      throw Exception('Failed to update profile');
    }
  }

  @override
  Future<List<DetailCourseModel>> getCoursesOfFormation(int formationId) async {
    final token = await preferencesHelper.getToken();
    final response = await apiClient.getRequest(
        "${EndpointsConstants.baseUrl}formations/$formationId/courses", token);
    print(response.data);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return DetailCourseModel.fromJsonList(response.data);
    } else {
      throw Exception('Failed to update profile');
    }
  }

  /// ************************************************************
  /// --------------------End Courses-----------------------------

  /// --------------------Start Books (Library)-----------------------------
  /// ************************************************************
  @override
  Future<List<BookModel>> getBooks() async {
    final token = await preferencesHelper.getToken();
    final response = await apiClient.getRequest(
        "${EndpointsConstants.baseUrl}${EndpointsConstants.books}", token);
    if (response.statusCode == 200) {
      return BookModel.fromJsonList(response.data);
    } else {
      throw Exception('Failed to get books');
    }
  }

  @override
  Future<List<BookModel>> searchBooks(String query) async {
    final token = await preferencesHelper.getToken();
    final response = await apiClient.getRequest(
        "${EndpointsConstants.baseUrl}${EndpointsConstants.searchBook}/$query",
        token);
    if (response.statusCode == 200) {
      return BookModel.fromJsonList(response.data);
    } else {
      throw Exception('Failed to search books');
    }
  }

  /// ************************************************************
  /// --------------------End Books (Library)-----------------------------

  /// --------------------Start Workshops and Conferences-----------------------------
  /// ************************************************************

  @override
  Future<List<WorkshopModel>> getWorkshops() async {
    final token = await preferencesHelper.getToken();
    final response = await apiClient.getRequest(
        "${EndpointsConstants.baseUrl}${EndpointsConstants.workshops}", token);
    if (response.statusCode == 200) {
      return WorkshopModel.fromJsonList(response.data);
    } else {
      throw Exception('Failed to get workshops');
    }
  }

  @override
  Future<WorkshopModel> getWorkshopsById(int workshopId) async {
    final token = await preferencesHelper.getToken();
    final response = await apiClient.getRequest(
        "${EndpointsConstants.baseUrl}${EndpointsConstants.workshops}$workshopId",
        token);
    if (response.statusCode == 200) {
      return WorkshopModel.fromJson(response.data);
    } else {
      throw Exception('Failed to get workshops');
    }
  }

  /// ************************************************************
  /// --------------------End Workshops and Conferences-----------------------------

  /// --------------------Start Offers and Internships-----------------------------
  /// ************************************************************

  @override
  Future<List<OffersModel>> getOffersByType(String type) async {
    final token = await preferencesHelper.getToken();
    final response = await apiClient.getRequest(
        "${EndpointsConstants.baseUrl}offers?type=$type", token);
    if (response.statusCode == 200) {
      return OffersModel.fromJsonList(response.data);
    } else {
      throw Exception('Failed to get offers by type');
    }
  }

  @override
  Future<DetailOfferModel> getDetailOffer(int offerId) async {
    final token = await preferencesHelper.getToken();
    final response = await apiClient.getRequest(
        "${EndpointsConstants.baseUrl}offers/$offerId", token);
    if (response.statusCode == 200) {
      return DetailOfferModel.fromJson(response.data);
    } else {
      throw Exception('Failed to get offers by type');
    }
  }

  @override
  Future<String> addToFavoriteList(int offerId) async {
    final token = await preferencesHelper.getToken();
    final response = await apiClient.postRequest(
        "${EndpointsConstants.baseUrl}offers/$offerId", null, token, false);
    if (response.statusCode == 200) {
      return response.data['message'];
    } else if (response.statusCode == 403) {
      return "The offer is already in the favorites list";
    } else {
      throw Exception('Failed to fetch user');
    }
  }

  @override
  Future<String> deleteFromFavoriteList(int offerId) async {
    final token = await preferencesHelper.getToken();
    final response = await apiClient.deleteRequest(
        "${EndpointsConstants.baseUrl}offers/$offerId/favorites", token);
    if (response.statusCode == 200) {
      return response.data['message'];
    } else {
      throw Exception('Failed to fetch user');
    }
  }

  @override
  Future<String> applyToOffer(int offerId, File resume) async {
    final token = await preferencesHelper.getToken();
    FormData formData = FormData.fromMap({
      "resume": await MultipartFile.fromFile(resume.path,
          filename: resume.path.split('/').last),
    });
    final response = await apiClient.postRequest(
        "${EndpointsConstants.baseUrl}offers/$offerId/applications",
        formData,
        token,
        true);
    if (response.statusCode == 200) {
      return "Application submitted successfully!";
    } else if (response.statusCode == 403) {
      return response.data['message'] ?? "You already applied to this offer.";
    } else {
      throw Exception('Failed to apply offer');
    }
  }

  @override
  Future<List<OffersModel>> searchOffers(String query) async {
    final token = await preferencesHelper.getToken();
    final response = await apiClient.getRequest(
        "${EndpointsConstants.baseUrl}${EndpointsConstants.searchOffer}$query",
        token);
    if (response.statusCode == 200) {
      return OffersModel.fromJsonList(response.data);
    } else {
      throw Exception('Failed to search offers');
    }
  }

  @override
  Future<List<FavoriteModel>> getFavorites() async {
    final token = await preferencesHelper.getToken();
    final response = await apiClient.getRequest(
        "${EndpointsConstants.baseUrl}${EndpointsConstants.favorites}", token);
    if (response.statusCode == 200) {
      return FavoriteModel.fromJsonList(response.data);
    } else {
      throw Exception('Failed to get favorites');
    }
  }

  /// ************************************************************
  /// --------------------End Offers and Internships-----------------------------

  /// --------------------Start Chat and Messages-----------------------------
  /// ************************************************************

  @override
  Future<List<ChatModel>> getChat() async {
    final token = await preferencesHelper.getToken();
    final response = await apiClient.getRequest(
        "${EndpointsConstants.baseUrl}${EndpointsConstants.conversations}",
        token);
    if (response.statusCode == 200) {
      return ChatModel.fromJsonList(response.data);
    } else {
      throw Exception('Failed to get chat');
    }
  }

  @override
  Future<List<MessagesModel>> getMessages(int conversationId) async {
    final token = await preferencesHelper.getToken();
    final response = await apiClient.getRequest(
        "${EndpointsConstants.baseUrl}conversations/$conversationId/messages",
        token);
    if (response.statusCode == 200) {
      return MessagesModel.fromJsonList(response.data);
    } else {
      throw Exception('Failed to get chat');
    }
  }

  @override
  Future<SendMessageResponseModel> sendMessage(
      int conversationId, String content) async {
    final token = await preferencesHelper.getToken();
    final response = await apiClient.postRequest(
        "${EndpointsConstants.baseUrl}conversations/$conversationId/messages",
        {"content": content},
        token,
        false);
    if (response.statusCode == 200) {
      return SendMessageResponseModel.fromJson(response.data);
    } else {
      throw Exception('Failed to send message');
    }
  }

  @override
  Future<Map<String, List<ScheduleModel>>> getSchedule(String weekKey) async {
    final token = await preferencesHelper.getToken();
    final response = await apiClient.getRequest(
        "${EndpointsConstants.baseUrl}${EndpointsConstants.schedule}", token);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          response.data is String ? jsonDecode(response.data) : response.data;
      final Map<String, List<ScheduleModel>> schedules = {};
      data.forEach((weekKey, weekData) {
        schedules[weekKey] = (weekData as List)
            .map((item) => ScheduleModel.fromJson(item))
            .toList();
      });
      return schedules;
    } else {
      throw Exception('Failed to fetch schedule');
    }
  }

  @override
  Future<SendMessageResponseModel> attachFile(
      int conversationId, File file, String type) async {
    final token = await preferencesHelper.getToken();
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path,
          filename: file.path.split('/').last),
      "type": type,
    });
    final response = await apiClient.postRequest(
        "${EndpointsConstants.baseUrl}conversations/$conversationId/messages/attach",
        formData,
        token,
        true);
    if (response.statusCode == 200) {
      return SendMessageResponseModel.fromJson(response.data);
    } else {
      throw Exception('Failed to send message');
    }
  }

  /// ************************************************************
  /// --------------------End Chat and Messages-----------------------------

  /// --------------------Start Notification-----------------------------
  /// ************************************************************

  @override
  Future<List<NotificationModel>> getAllNotification() async {
    final token = await preferencesHelper.getToken();
    final response = await apiClient.getRequest(
        "${EndpointsConstants.baseUrl}${EndpointsConstants.notifications}",
        token);
    if (response.statusCode == 200) {
      return NotificationModel.fromJsonList(response.data);
    } else {
      throw Exception('Failed to get notification');
    }
  }

  /// ************************************************************
  /// --------------------End Notification-----------------------------

  /// --------------------Start Enrollments-----------------------------
  /// ************************************************************

  @override
  Future<List<EnrollmentModel>> getEnrollment() async {
    final token = await preferencesHelper.getToken();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await apiClient.getRequest(
        "${EndpointsConstants.baseUrl}${EndpointsConstants.enrollments}",
        token);
    if (response.statusCode == 200) {
      List<dynamic> enrollments = response.data;
      List<int> groupIds = [];
      for (var enrollment in enrollments) {
        int? groupId = enrollment['group_id'];
        if (groupId != null) {
          groupIds.add(groupId);
          print("Stored group ID: $groupId");
        }
      }
      await preferences.setString("groupIds", jsonEncode(groupIds));
      return EnrollmentModel.fromJsonList(enrollments);
    } else {
      throw Exception('Failed to get enrollments');
    }
  }

  /// ************************************************************
  /// --------------------End Enrollments-----------------------------

  /// --------------------Start Lives-----------------------------
  /// ************************************************************
  @override
  Future<List<LivesModel>> getAllLives() async {
    final token = await preferencesHelper.getToken();
    final response = await apiClient.getRequest(
        "${EndpointsConstants.baseUrl}${EndpointsConstants.lives}", token);
    if (response.statusCode == 200) {
      return LivesModel.fromJsonList(response.data);
    } else {
      throw Exception('Failed to get notification');
    }
  }

  /// ************************************************************
  /// --------------------End Lives-----------------------------
}
