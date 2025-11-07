
import 'package:assignment_8club/bloc/experience/experience_event.dart';
import 'package:assignment_8club/bloc/experience/experience_state.dart';
import 'package:assignment_8club/models/experience_model.dart';
import 'package:assignment_8club/repositories/experience_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ExperienceBloc extends Bloc<ExperienceEvent, ExperienceState> {
  final ExperienceRepository experienceRepository;

  ExperienceBloc({required this.experienceRepository}) : super(ExperienceInitial()) {
    on<LoadExperiencesEvent>(_onLoadExperiences);
    on<SelectExperienceEvent>(_onSelectExperience);
    on<UpdateExperienceDescriptionEvent>(_onUpdateExperienceDescription);
  }

  Future<void> _onLoadExperiences(
    LoadExperiencesEvent event,
    Emitter<ExperienceState> emit,
  ) async {
    emit(ExperienceLoading());
    
    try {
      final experiences = await experienceRepository.getExperiences();
      emit(ExperienceLoaded(
        experiences: experiences,
        selectedExperiences: const [],
        experienceDescription: '',
      ));
    } catch (e) {
      emit(ExperienceError(e.toString()));
    }
  }

  void _onSelectExperience(
    SelectExperienceEvent event,
    Emitter<ExperienceState> emit,
  ) {
    if (state is ExperienceLoaded) {
      final currentState = state as ExperienceLoaded;
      final selectedExperiences = List<ExperienceModel>.from(currentState.selectedExperiences);
      
      if (selectedExperiences.contains(event.experience)) {
        selectedExperiences.remove(event.experience);
      } else {
        selectedExperiences.add(event.experience);
      }
      
      emit(currentState.copyWith(selectedExperiences: selectedExperiences));
    }
  }

  void _onUpdateExperienceDescription(
    UpdateExperienceDescriptionEvent event,
    Emitter<ExperienceState> emit,
  ) {
    if (state is ExperienceLoaded) {
      final currentState = state as ExperienceLoaded;
      emit(currentState.copyWith(experienceDescription: event.description));
    }
  }

}
