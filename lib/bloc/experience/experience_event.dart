
import 'package:assignment_8club/models/experience_model.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class ExperienceEvent {}

final class LoadExperiencesEvent extends ExperienceEvent {}

final class SelectExperienceEvent extends ExperienceEvent {
  final ExperienceModel experience;

  SelectExperienceEvent(this.experience);
}

final class UpdateExperienceDescriptionEvent extends ExperienceEvent {
  final String description;

  UpdateExperienceDescriptionEvent(this.description);
}