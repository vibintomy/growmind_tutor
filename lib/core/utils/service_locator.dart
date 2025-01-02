import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growmind_tutuor/core/utils/cloudinary.dart';

import 'package:growmind_tutuor/features/auth/data/repository/tutor_repository_impl.dart';
import 'package:growmind_tutuor/features/auth/domain/repositories/tutor_repositories.dart';
import 'package:growmind_tutuor/features/auth/domain/usecases/kyc_usecases.dart';
import 'package:growmind_tutuor/features/auth/presentation/bloc/kyc_bloc/kyc_bloc.dart';
final getIt = GetIt.instance;

void setup() {
  // Data Layer
  getIt.registerLazySingleton<Cloudinary>(() => Cloudinary.signedConfig(
        apiKey: '642889674424333',
        apiSecret: 'EB9XFjTTm5kNygU6hxJMls79Tj8',
        cloudName: 'dj01ka9ga',
      ));
  getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  getIt.registerLazySingleton<TutorRepositories>(() => TutorRepositoryImpl(
        cloudinary: getIt<Cloudinary>(),
        firestore: getIt<FirebaseFirestore>(),
      ));

  // Domain Layer
  getIt.registerLazySingleton(() => UploadPDFUseCase(getIt<TutorRepositories>()));
  getIt.registerLazySingleton(() => SubmitKycUseCase(getIt<TutorRepositories>()));

  // Presentation Layer
  getIt.registerFactory(() => TutorKycBloc(
        uploadPDFUseCase: getIt<UploadPDFUseCase>(),
        submitKycUseCase: getIt<SubmitKycUseCase>(),
      ));
}
