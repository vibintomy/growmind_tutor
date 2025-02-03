import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_tutuor/features/home/domain/entities/section_entity.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/update_section_course_bloc/bloc/update_section_event.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/update_section_course_bloc/bloc/update_section_state.dart';

class UpdateSectionBloc extends Bloc<UpdateSectionEvent, UpdateSectionState> {
  UpdateSectionBloc(List<SectionEntity> initialSections)
      : super(SectinUpdateState(List.from(initialSections))) {
    on<UpdateVideoEvent>(_onUpdateVideo);
   
  }

  void _onUpdateVideo(UpdateVideoEvent event, Emitter<UpdateSectionState> emit) {
    final updatedSections = List<SectionEntity>.from((state as SectinUpdateState).section);

    // Update the section with the new video URL
    updatedSections[event.sectionIndex] = updatedSections[event.sectionIndex].copyWith(
      videoUrl: event.videoPath, // Pass the new video path received from UI
    );

    emit(SectinUpdateState(updatedSections));
  }

  
}
