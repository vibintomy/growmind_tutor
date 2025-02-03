abstract class UpdateSectionEvent {}

class UpdateVideoEvent extends UpdateSectionEvent {
  final int sectionIndex;
  final String videoPath;
  UpdateVideoEvent({required this.sectionIndex,required this.videoPath});
}


