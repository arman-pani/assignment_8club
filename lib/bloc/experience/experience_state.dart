import 'package:assignment_8club/models/experience_model.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class ExperienceState {}

final class ExperienceInitial extends ExperienceState {}

final class ExperienceLoading extends ExperienceState {}

final class ExperienceLoaded extends ExperienceState {
  final List<ExperienceModel> experiences;
  final List<ExperienceModel> selectedExperiences;
  final String experienceDescription;

  ExperienceLoaded({
    required this.experiences,
    required this.selectedExperiences,
    required this.experienceDescription,
  });

  ExperienceLoaded copyWith({
    List<ExperienceModel>? experiences,
    List<ExperienceModel>? selectedExperiences,
    String? experienceDescription,
  }) {
    return ExperienceLoaded(
      experiences: experiences ?? this.experiences,
      selectedExperiences: selectedExperiences ?? this.selectedExperiences,
      experienceDescription: experienceDescription ?? this.experienceDescription,
    );
  }

  bool enableNextButton() => selectedExperiences.isNotEmpty;
}

final class ExperienceError extends ExperienceState {
  final String message;

  ExperienceError(this.message);
}
