import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:school_test_online/core/api/api_client.dart';
import 'package:school_test_online/core/utils/helpers/preferences_helpers.dart';
import 'package:school_test_online/features/domain/use_cases/chat/attach_file_to_conversation_use_case.dart';
import 'package:school_test_online/features/domain/use_cases/lives/fetch_lives_use_case.dart';
import 'package:school_test_online/features/domain/use_cases/notifications/fetch_notifications_use_case.dart';
import 'package:school_test_online/features/domain/use_cases/offers/apply_to_offer_use_case.dart';
import 'package:school_test_online/features/domain/use_cases/offers/fetch_favorites_use_case.dart';
import 'package:school_test_online/features/domain/use_cases/offers/search_offers_use_case.dart';
import 'package:school_test_online/features/domain/use_cases/payment/manual_payment_use_case.dart';
import 'package:school_test_online/features/domain/use_cases/timetable/fetch_schedules_use_case.dart';
import 'package:school_test_online/features/domain/use_cases/user/update_password_use_case.dart';
import 'package:school_test_online/features/domain/use_cases/user/update_profile_use_case.dart';
import 'package:school_test_online/features/domain/use_cases/user/upload_avatar_use_case.dart';
import 'package:school_test_online/features/presentation/manager/chat/attach_file_to_conversation/attach_file_to_conversation_cubit.dart';
import 'package:school_test_online/features/presentation/manager/lives/get_lives/get_lives_cubit.dart';
import 'package:school_test_online/features/presentation/manager/notifications/get_notifications/get_notifications_cubit.dart';
import 'package:school_test_online/features/presentation/manager/offers/apply_to_offer/apply_to_offer_cubit.dart';
import 'package:school_test_online/features/presentation/manager/offers/get_favorites/get_favorites_cubit.dart';
import 'package:school_test_online/features/presentation/manager/offers/search_offers/search_offers_cubit.dart';
import 'package:school_test_online/features/presentation/manager/payment/manual_payment/manual_payment_cubit.dart';
import 'package:school_test_online/features/presentation/manager/timetable/get_schedule/get_schedule_cubit.dart';
import 'package:school_test_online/features/presentation/manager/user/update_password/update_password_cubit.dart';
import 'package:school_test_online/features/presentation/manager/user/update_profile/update_profile_cubit.dart';
import 'package:school_test_online/features/presentation/manager/user/upload_avatar/upload_avatar_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/data/data_sources/remote_data_source.dart';
import 'features/data/data_sources/remote_data_source_impl.dart';
import 'features/data/repositories/repository_impl.dart';
import 'features/domain/repositories/repository.dart';
import 'features/domain/use_cases/books/fetch_books_use_case.dart';
import 'features/domain/use_cases/books/search_book_use_case.dart';
import 'features/domain/use_cases/chat/get_conversations_use_case.dart';
import 'features/domain/use_cases/chat/get_messages_use_case.dart';
import 'features/domain/use_cases/chat/send_message_use_case.dart';
import 'features/domain/use_cases/courses/fetch_courses_by_status_use_case.dart';
import 'features/domain/use_cases/courses/fetch_detail_course_use_case.dart';
import 'features/domain/use_cases/courses/fetch_detail_formation_use_case.dart';
import 'features/domain/use_cases/domain/fetch_courses_by_domains_use_case.dart';
import 'features/domain/use_cases/domain/fetch_domains_use_case.dart';
import 'features/domain/use_cases/offers/add_to_favorite_list_use_case.dart';
import 'features/domain/use_cases/offers/delete_from_favorite_list_use_case.dart';
import 'features/domain/use_cases/offers/fetch_detail_offer_use_case.dart';
import 'features/domain/use_cases/offers/fetch_offers_by_type_use_case.dart';
import 'features/domain/use_cases/payment/get_rib_use_case.dart';
import 'features/domain/use_cases/request_diploma/request_diploma_use_case.dart';
import 'features/domain/use_cases/user/get_current_customer_token_use_case.dart';
import 'features/domain/use_cases/user/is_sign_in_usecase.dart';
import 'features/domain/use_cases/user/login_user_use_case.dart';
import 'features/domain/use_cases/user/register_user_use_case.dart';
import 'features/domain/use_cases/workshops/fetch_workshop_by_id_use_case.dart';
import 'features/domain/use_cases/workshops/fetch_workshops_use_case.dart';
import 'features/presentation/manager/books/get_books/get_books_cubit.dart';
import 'features/presentation/manager/books/search_book/search_book_cubit.dart';
import 'features/presentation/manager/chat/get_conversations/get_conversations_cubit.dart';
import 'features/presentation/manager/chat/get_messages/get_messages_cubit.dart';
import 'features/presentation/manager/chat/send_message/send_message_cubit.dart';
import 'features/presentation/manager/courses/get_courses_by_domain/get_courses_by_domain_cubit.dart';
import 'features/presentation/manager/courses/get_courses_by_status/get_courses_by_status_cubit.dart';
import 'features/presentation/manager/courses/get_detail_course/get_detail_course_cubit.dart';
import 'features/presentation/manager/courses/get_detail_formation/get_detail_formation_cubit.dart';
import 'features/presentation/manager/courses/toggle_buttons/toggle_buttons_cubit.dart';
import 'features/presentation/manager/domains/get_domains/get_domains_cubit.dart';
import 'features/presentation/manager/offers/add_to_favorite_list/add_to_favorite_list_cubit.dart';
import 'features/presentation/manager/offers/get_detail_offer/get_detail_offer_cubit.dart';
import 'features/presentation/manager/offers/get_offers_by_type/get_offers_by_type_cubit.dart';
import 'features/presentation/manager/offers/remove_from_favorite_list/remove_from_favorite_list_cubit.dart';
import 'features/presentation/manager/offers/toggle_offers/toggle_offers_cubit.dart';
import 'features/presentation/manager/payment/get_rib/get_rib_cubit.dart';
import 'features/presentation/manager/request_diploma/request_diploma_cubit.dart';
import 'features/presentation/manager/user/auth/auth_cubit.dart';
import 'features/presentation/manager/user/credential/credential_cubit.dart';
import 'features/presentation/manager/user/register_user/register_user_cubit.dart';
import 'features/presentation/manager/workshops/get_detail_workshop/get_detail_workshop_cubit.dart';
import 'features/presentation/manager/workshops/get_workshops/get_workshops_cubit.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  ///Bloc
  locator.registerFactory(() => AuthCubit(
        getCurrentTokenUserUseCase: locator.call(),
        isSignInUserUseCase: locator.call(),
      ));

  locator.registerFactory(() => CredentialCubit(
        loginUserUseCase: locator.call(),
      ));
  locator.registerFactory(() => GetDomainsCubit(
        fetchDomainsUseCase: locator.call(),
      ));
  locator.registerFactory(() => GetCoursesByDomainCubit(
        fetchCoursesByDomainUseCase: locator.call(),
      ));
  locator.registerFactory(() => GetDetailFormationCubit(
        fetchDetailFormationUseCase: locator.call(),
      ));
  locator.registerFactory(() => RegisterUserCubit(
        registerUserUseCase: locator.call(),
      ));
  locator.registerFactory(() => GetRibCubit(
        fetchRibUseCase: locator.call(),
      ));
  locator.registerFactory(() => GetCoursesByStatusCubit(
        fetchCoursesByStatusUseCase: locator.call(),
      ));
  locator.registerFactory(() => ToggleButtonsCubit());
  locator.registerFactory(() => GetDetailCourseCubit(
        fetchDetailCourseUseCase: locator.call(),
      ));
  locator.registerFactory(() => RequestDiplomaCubit(
        requestDiplomaUseCase: locator.call(),
      ));
  locator.registerFactory(() => GetBooksCubit(
        fetchBooksUseCase: locator.call(),
      ));
  locator.registerFactory(() => SearchBookCubit(
        searchBooksUseCase: locator.call(),
      ));
  locator.registerFactory(() => GetWorkshopsCubit(
        fetchWorkshopsUseCase: locator.call(),
      ));
  locator.registerFactory(() => GetDetailWorkshopCubit(
        fetchWorkshopsByIdUseCase: locator.call(),
      ));
  locator.registerFactory(() => ToggleOffersCubit());
  locator.registerFactory(() => GetOffersByTypeCubit(
        fetchOffersByTypeUseCase: locator.call(),
      ));
  locator.registerFactory(() => GetDetailOfferCubit(
        fetchDetailOffersUseCase: locator.call(),
      ));
  locator.registerFactory(() => AddToFavoriteListCubit(
        addToFavoriteListUseCase: locator.call(),
      ));
  locator.registerFactory(() => RemoveFromFavoriteListCubit(
        deleteFromFavoriteListUseCase: locator.call(),
      ));
  locator.registerFactory(() => GetConversationsCubit(
        fetchConversationsUseCase: locator.call(),
      ));
  locator.registerFactory(() => GetMessagesCubit(
        fetchMessagesUseCase: locator.call(),
      ));
  locator.registerFactory(() => SendMessageCubit(
        sendMessagesUseCase: locator<SendMessagesUseCase>(),
      ));
  locator
      .registerLazySingleton(() => '2024-08-27'); // Use your default week key
  locator.registerFactory(() => GetScheduleCubit(
        fetchScheduleUseCase: locator.call(),
        currentWeekKey: locator(),
      ));
  locator.registerFactory(() => AttachFileToConversationCubit(
        attachFileToConversationsUseCase: locator.call(),
      ));
  locator.registerFactory(() => ApplyToOfferCubit(
        applyToOfferUseCase: locator.call(),
      ));
  locator.registerFactory(() => ManualPaymentCubit(
        manualPaymentUseCase: locator.call(),
      ));
  locator.registerFactory(() => SearchOffersCubit(
        searchOffersUseCase: locator.call(),
      ));

  locator.registerFactory(() => GetNotificationsCubit(
        fetchNotificationUseCase: locator.call(),
      ));

  locator.registerFactory(() => GetLivesCubit(
        fetchLivesUseCase: locator.call(),
      ));
  locator.registerFactory(() => GetFavoritesCubit(
        favoritesByTypeUseCase: locator.call(),
      ));
  locator.registerFactory(() => UpdatePasswordCubit(
        updatePasswordUserUseCase: locator.call(),
      ));
  locator.registerFactory(() => UpdateProfileCubit(
        updateProfileUserUseCase: locator.call(),
      ));
  locator.registerFactory(() => UploadAvatarCubit(
        uploadAvatarUseCase: locator.call(),
      ));
  // Use Case
  locator.registerLazySingleton(
      () => LoginUserUseCase(repository: locator.call()));
  locator.registerLazySingleton(
      () => IsSignInUserUseCase(repository: locator.call()));
  locator.registerLazySingleton(
      () => GetCurrentTokenUserUseCase(repository: locator.call()));
  locator.registerLazySingleton(
      () => FetchDomainsUseCase(repository: locator.call()));
  locator.registerLazySingleton(
      () => FetchCoursesByDomainUseCase(repository: locator.call()));
  locator.registerLazySingleton(
      () => FetchDetailFormationUseCase(repository: locator.call()));
  locator.registerLazySingleton(
      () => RegisterUserUseCase(repository: locator.call()));
  locator
      .registerLazySingleton(() => FetchRibUseCase(repository: locator.call()));
  locator.registerLazySingleton(
      () => FetchCoursesByStatusUseCase(repository: locator.call()));
  locator.registerLazySingleton(
      () => FetchDetailCourseUseCase(repository: locator.call()));
  locator.registerLazySingleton(
      () => RequestDiplomaUseCase(repository: locator.call()));
  locator.registerLazySingleton(
      () => FetchBooksUseCase(repository: locator.call()));
  locator.registerLazySingleton(
      () => SearchBooksUseCase(repository: locator.call()));
  locator.registerLazySingleton(
      () => FetchWorkshopsUseCase(repository: locator.call()));
  locator.registerLazySingleton(
      () => FetchWorkshopsByIdUseCase(repository: locator.call()));
  locator.registerLazySingleton(
      () => FetchOffersByTypeUseCase(repository: locator.call()));
  locator.registerLazySingleton(
      () => FetchDetailOffersUseCase(repository: locator.call()));
  locator.registerLazySingleton(
      () => AddToFavoriteListUseCase(repository: locator.call()));
  locator.registerLazySingleton(
      () => DeleteFromFavoriteListUseCase(repository: locator.call()));
  locator.registerLazySingleton(
      () => FetchConversationsUseCase(repository: locator.call()));
  locator.registerLazySingleton(
      () => FetchMessagesUseCase(repository: locator.call()));
  locator.registerLazySingleton(
      () => SendMessagesUseCase(repository: locator.call()));
  locator.registerLazySingleton(
      () => FetchScheduleUseCase(repository: locator.call()));
  locator.registerLazySingleton(
      () => AttachFileToConversationsUseCase(repository: locator.call()));
  locator.registerLazySingleton(
      () => ApplyToOfferUseCase(repository: locator.call()));
  locator.registerLazySingleton(
      () => ManualPaymentUseCase(repository: locator.call()));
  locator.registerLazySingleton(
      () => SearchOffersUseCase(repository: locator.call()));
  locator.registerLazySingleton(
      () => FetchNotificationUseCase(repository: locator.call()));
  locator.registerLazySingleton(
      () => FetchLivesUseCase(repository: locator.call()));
  locator.registerLazySingleton(
      () => FetchFavoritesByTypeUseCase(repository: locator.call()));
  locator.registerLazySingleton(
      () => UpdatePasswordUserUseCase(repository: locator.call()));
  locator.registerLazySingleton(
      () => UpdateProfileUserUseCase(repository: locator.call()));
  locator.registerLazySingleton(
      () => UploadAvatarUseCase(repository: locator.call()));

  ///Repository
  locator.registerLazySingleton<Repository>(
    () => RepositoryImpl(remoteDataSourceImpl: locator.call()),
  );

  ///Data Source
  locator.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(
        client: locator.call(),
        apiClient: locator<ApiClient>(),
        preferencesHelper: locator<PreferencesHelper>(),
      ));

  locator.registerLazySingleton<RemoteDataSourceImpl>(
    () => RemoteDataSourceImpl(
        client: locator.call(),
        apiClient: locator<ApiClient>(),
        preferencesHelper: locator<PreferencesHelper>()),
  );

  ///External
  locator.registerLazySingleton(() => Dio());
  locator.registerLazySingleton(() => ApiClient(locator<Dio>()));
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => PreferencesHelper(sharedPreferences));
}
