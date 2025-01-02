import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_tutuor/features/auth/domain/usecases/kyc_usecases.dart';

import 'package:growmind_tutuor/features/auth/presentation/bloc/kyc_bloc/kyc_event.dart';
import 'package:growmind_tutuor/features/auth/presentation/bloc/kyc_bloc/kyc_state.dart';

class TutorKycBloc extends Bloc<TutorKycEvent, TutorKycState> {
  final UploadPDFUseCase uploadPDFUseCase;
  final SubmitKycUseCase submitKycUseCase;

  TutorKycBloc({required this.submitKycUseCase, required this.uploadPDFUseCase})
      : super(TutuorKYCInitial()) {
    on<UploadPDFEvent>((event, emit) async {
      emit(UploadingPDF());
      try {
        final pdfUrl = await uploadPDFUseCase(event.filePath);
     
        emit(PDFUploaded(pdfUrl));
      } catch (eroor) {
        emit(KYCEroor('Failed to upload PDF $eroor'));
      }
    });

    on<SubmitKycEvent>((event, emit) async {
      emit(KYCSubmitting());
      try {
        // Use the submitKycUseCase to submit KYC data
        await submitKycUseCase(
          name: event.name,
          filePath: event.pdfUrl,
          profession: event.profession,
        );
        emit(KYCSucess()); // Emit success state
      } catch (error) {
        emit(KYCEroor('Failed to submit KYC: $error'));
      }
    });
  }
}
