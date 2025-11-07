import 'package:flutter_bloc/flutter_bloc.dart';

enum OnboardingPage {
  experience,
  question,
}

class OnboardingFlowCubit extends Cubit<OnboardingPage> {
  OnboardingFlowCubit() : super(OnboardingPage.experience);

  void next() {
    if (state == OnboardingPage.experience) {
      emit(OnboardingPage.question);
    }
  }

  void back() {
    if (state == OnboardingPage.question) {
      emit(OnboardingPage.experience);
    }
  }
}

