import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growmind_tutuor/core/utils/cloudinary.dart';

import 'package:growmind_tutuor/features/auth/data/repository/tutor_repository_impl.dart';
import 'package:growmind_tutuor/features/auth/domain/repositories/tutor_repositories.dart';
import 'package:growmind_tutuor/features/auth/domain/usecases/kyc_usecases.dart';
import 'package:growmind_tutuor/features/auth/presentation/bloc/kyc_bloc/kyc_bloc.dart';
import 'package:growmind_tutuor/features/home/data/data_source/fetch_cat_remotedata.dart';
import 'package:growmind_tutuor/features/home/data/repository_impl/upload_course_repoimpl.dart';
import 'package:growmind_tutuor/features/home/domain/repository/upload_course_repo.dart';
import 'package:growmind_tutuor/features/home/domain/usecases/upload_course_usecases.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/create_course_bloc/create_course_bloc.dart';

import 'package:growmind_tutuor/features/profile/data/datasource/profile_remote_datasorce.dart';
import 'package:growmind_tutuor/features/profile/data/repo/profile_repo.dart';
import 'package:growmind_tutuor/features/profile/domain/repo/profile_repo.dart';
import 'package:growmind_tutuor/features/profile/domain/usecases/get_profile.dart';
import 'package:growmind_tutuor/features/profile/presentation/bloc/profile_bloc.dart';

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

  // Domain Layer
  getIt.registerLazySingleton(
      () => UploadPDFUseCase(getIt<TutorRepositories>()));
  getIt.registerLazySingleton(
      () => SubmitKycUseCase(getIt<TutorRepositories>()));
  getIt.registerLazySingleton(() => GetProfile(getIt<ProfileRepo>()));
  getIt.registerLazySingleton(
      () => UploadCourseUsecases(getIt<UploadDataRepo>()));

  // Presentation Layer
  getIt.registerFactory(() => TutorKycBloc(
        uploadPDFUseCase: getIt<UploadPDFUseCase>(),
        submitKycUseCase: getIt<SubmitKycUseCase>(),
      ));
  getIt.registerFactory(() => ProfileBloc(getIt<GetProfile>()));
  getIt.registerFactory(() => CreateCourseBloc(getIt<UploadCourseUsecases>()));
}
