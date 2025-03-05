import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growmind_tutuor/core/utils/cloudinary.dart';
import 'package:growmind_tutuor/features/auth/data/repository/tutor_repository_impl.dart';
import 'package:growmind_tutuor/features/auth/domain/repositories/tutor_repositories.dart';
import 'package:growmind_tutuor/features/auth/domain/usecases/kyc_usecases.dart';
import 'package:growmind_tutuor/features/auth/presentation/bloc/kyc_bloc/kyc_bloc.dart';
import 'package:growmind_tutuor/features/chat/data/datasource/chat_remote_datasource.dart';
import 'package:growmind_tutuor/features/chat/data/datasource/chat_remote_datasource_impl.dart';
import 'package:growmind_tutuor/features/chat/data/repositories/chat_repo_impl.dart';
import 'package:growmind_tutuor/features/chat/domain/domain/repo/chat_repositories.dart';
import 'package:growmind_tutuor/features/chat/domain/domain/usecases/get_TutorConversation.dart';
import 'package:growmind_tutuor/features/chat/domain/domain/usecases/get_message_students.dart';
import 'package:growmind_tutuor/features/chat/domain/domain/usecases/get_send_message.dart';
import 'package:growmind_tutuor/features/chat/domain/domain/usecases/get_student_info.dart';
import 'package:growmind_tutuor/features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:growmind_tutuor/features/chat/presentation/bloc/conversation_bloc/conversation_bloc.dart';
import 'package:growmind_tutuor/features/home/data/data_source/saled_course_datasource.dart';
import 'package:growmind_tutuor/features/home/data/data_source/student_datasource.dart';
import 'package:growmind_tutuor/features/home/data/data_source/student_datasource_impl.dart';
import 'package:growmind_tutuor/features/home/data/repository_impl/fetch_category_repoimpl.dart';
import 'package:growmind_tutuor/features/home/data/repository_impl/fetch_course_repoimpl.dart';
import 'package:growmind_tutuor/features/home/data/repository_impl/saled_course_repo_impl.dart';
import 'package:growmind_tutuor/features/home/data/repository_impl/student_repo_impl.dart';
import 'package:growmind_tutuor/features/home/data/repository_impl/upload_course_repoimpl.dart';
import 'package:growmind_tutuor/features/home/domain/repository/fetch_category_repo.dart';
import 'package:growmind_tutuor/features/home/domain/repository/fetch_course_repo.dart';
import 'package:growmind_tutuor/features/home/domain/repository/fetch_student_repositories.dart';
import 'package:growmind_tutuor/features/home/domain/repository/saled_course_repostory.dart';
import 'package:growmind_tutuor/features/home/domain/repository/upload_course_repo.dart';
import 'package:growmind_tutuor/features/home/domain/usecases/fetch_category_usecases.dart';
import 'package:growmind_tutuor/features/home/domain/usecases/fetch_course_usecases.dart';
import 'package:growmind_tutuor/features/home/domain/usecases/fetch_student_usecases.dart';
import 'package:growmind_tutuor/features/home/domain/usecases/get_saled_course_usecase.dart';
import 'package:growmind_tutuor/features/home/domain/usecases/upload_course_usecases.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/create_course_bloc/create_course_bloc.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/fetch_category_bloc/bloc/fetch_category_bloc.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/fetch_course_bloc/fetch_course_bloc.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/sales_course_bloc/sales_course_bloc.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/student_bloc/student_bloc.dart';
import 'package:growmind_tutuor/features/profile/data/datasource/profile_remote_datasorce.dart';
import 'package:growmind_tutuor/features/profile/data/repo/profile_repo.dart';
import 'package:growmind_tutuor/features/profile/data/repo/update_profile_repImpl.dart';
import 'package:growmind_tutuor/features/profile/domain/repo/profile_repo.dart';
import 'package:growmind_tutuor/features/profile/domain/repo/update_profile_repo.dart';
import 'package:growmind_tutuor/features/profile/domain/usecases/get_profile.dart';
import 'package:growmind_tutuor/features/profile/domain/usecases/update_profile_usecases.dart';
import 'package:growmind_tutuor/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:growmind_tutuor/features/profile/presentation/bloc/profile_update_bloc/bloc/profile_update_bloc.dart';

final getIt = GetIt.instance;

void setup() {
  // Data Layer
  getIt.registerLazySingleton<Cloudinary>(() => Cloudinary.signedConfig(
        apiKey: '642889674424333',
        apiSecret: 'EB9XFjTTm5kNygU6hxJMls79Tj8',
        cloudName: 'dj01ka9ga',
      ));
  getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);
  getIt.registerLazySingleton<TutorRepositories>(() => TutorRepositoryImpl(
        cloudinary: getIt<Cloudinary>(),
        firestore: getIt<FirebaseFirestore>(),
      ));
  getIt.registerLazySingleton<ProfileRemoteDatasource>(
      () => ProfileRemoteDatasource(getIt<FirebaseFirestore>()));

  getIt.registerLazySingleton<ProfileRepo>(
      () => ProfileRepoImpl(getIt<ProfileRemoteDatasource>()));
  getIt.registerLazySingleton<UploadDataRepo>(() =>
      UploadCourseRepoImpl(getIt<Cloudinary>(), getIt<FirebaseFirestore>()));
  getIt.registerLazySingleton<FetchCategoryRepo>(
      () => FetchCategoryRepoimpl(getIt<FirebaseFirestore>()));
  getIt.registerLazySingleton<UpdateProfileRepo>(() =>
      UpdateProfileRepimpl(getIt<Cloudinary>(), getIt<FirebaseFirestore>()));
  getIt.registerLazySingleton<FetchCourseRepo>(
      () => FetchCourseRepoimpl(getIt<FirebaseFirestore>()));
  getIt.registerLazySingleton<ChatRemoteDatasource>(
      () => ChatRemotDatasourceimpl(getIt<FirebaseFirestore>()));
  getIt.registerLazySingleton<ChatRepositories>(
      () => ChatRepoImpl(getIt<ChatRemoteDatasource>()));
  getIt.registerLazySingleton<SaledCourseDatasource>(
      () => SaledCourseDatasource(getIt<FirebaseFirestore>()));
  getIt.registerLazySingleton<SaledCourseRepostory>(
      () => SaledCourseRepoImpl(getIt<SaledCourseDatasource>()));
  getIt.registerLazySingleton<StudentDatasource>(
      () => StudentDatasourceImpl(getIt<FirebaseFirestore>()));
  getIt.registerLazySingleton<FetchStudentRepositories>(
      () => StudentRepoImpl(getIt<StudentDatasource>()));
  // Domain Layer
  getIt.registerLazySingleton(
      () => UploadPDFUseCase(getIt<TutorRepositories>()));
  getIt.registerLazySingleton(
      () => SubmitKycUseCase(getIt<TutorRepositories>()));
  getIt.registerLazySingleton(() => GetProfile(getIt<ProfileRepo>()));
  getIt.registerLazySingleton(
      () => UploadCourseUsecases(getIt<UploadDataRepo>()));

  getIt
      .registerLazySingleton(() => FetchCategories(getIt<FetchCategoryRepo>()));
  getIt.registerLazySingleton(
      () => FetchSubCategories(getIt<FetchCategoryRepo>()));
  getIt.registerLazySingleton(
      () => UpdateProfileUsecases(getIt<UpdateProfileRepo>()));
  getIt.registerLazySingleton(
      () => FetchCourseUsecases(getIt<FetchCourseRepo>()));
  getIt.registerLazySingleton(() => GetSendMessage(getIt<ChatRepositories>()));
  getIt.registerLazySingleton(
      () => GetMessageStudents(getIt<ChatRepositories>()));
  getIt.registerLazySingleton(
      () => GetTutorconversation(getIt<ChatRepositories>()));
  getIt.registerLazySingleton(
      () => GetStudentProfile(getIt<ChatRepositories>()));
  getIt.registerLazySingleton(
      () => GetSaledCourseUsecase(getIt<SaledCourseRepostory>()));
  getIt.registerLazySingleton(
      () => FetchStudentUsecases(getIt<FetchStudentRepositories>()));
  // Presentation Layer
  getIt.registerFactory(() => TutorKycBloc(
        uploadPDFUseCase: getIt<UploadPDFUseCase>(),
        submitKycUseCase: getIt<SubmitKycUseCase>(),
      ));
  getIt.registerFactory(() => ProfileBloc(getIt<GetProfile>()));
  getIt.registerFactory(() => CreateCourseBloc(getIt<UploadCourseUsecases>()));
  getIt.registerFactory(() =>
      FetchCategoryBloc(getIt<FetchCategories>(), getIt<FetchSubCategories>()));
  getIt
      .registerFactory(() => ProfileUpdateBloc(getIt<UpdateProfileUsecases>()));
  getIt.registerFactory(() => FetchCourseBloc(getIt<FetchCourseUsecases>()));
  getIt.registerFactory(() => ChatBloc(
      getMessageWithStudents: getIt<GetMessageStudents>(),
      sendMessage: getIt<GetSendMessage>()));

  getIt.registerFactory(() => ConversationBloc(
      getTutorConversations: getIt<GetTutorconversation>(),
      getStudentProfile: getIt<GetStudentProfile>()));
  getIt.registerFactory(() => SalesCourseBloc(getIt<GetSaledCourseUsecase>()));
  getIt.registerFactory(() => StudentBloc(getIt<FetchStudentUsecases>()));
}
