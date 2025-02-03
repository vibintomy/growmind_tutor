import 'package:growmind_tutuor/features/home/domain/entities/section_entity.dart';

abstract class UpdateSectionState {}

class SectinUpdateState extends UpdateSectionState {
  final List<SectionEntity> section;
  SectinUpdateState(this.section);
}
