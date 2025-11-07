import 'dart:ui';

import 'package:assignment_8club/bloc/experience/experience_bloc.dart';
import 'package:assignment_8club/bloc/experience/experience_state.dart';
import 'package:assignment_8club/bloc/onboarding_flow/onboarding_flow_cubit.dart';
import 'package:assignment_8club/bloc/question/question_bloc.dart';
import 'package:assignment_8club/constants/app_colors.dart';
import 'package:assignment_8club/constants/app_strings.dart';
import 'package:assignment_8club/screens/experience_selection_screen.dart';
import 'package:assignment_8club/screens/onboarding_question_screen.dart';
import 'package:assignment_8club/widgets/gradient_button.dart';
import 'package:assignment_8club/widgets/recording_buttons.dart';
import 'package:assignment_8club/widgets/wavy_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ScaffoldWithAppbar extends StatefulWidget {
  const ScaffoldWithAppbar({super.key});

  @override
  State<ScaffoldWithAppbar> createState() => _ScaffoldWithAppbarState();
}

class _ScaffoldWithAppbarState extends State<ScaffoldWithAppbar> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingFlowCubit, OnboardingPage>(
      listener: (context, currentPage) {
        _pageController.animateToPage(
          currentPage.index,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },

      builder: (context, currentPage) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                child: Container(
                  decoration: BoxDecoration(gradient: AppColors.boxGradient),
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    elevation: 0,
                    actionsPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    leading: GestureDetector(
                      onTap: () => context.read<OnboardingFlowCubit>().back(),
                      child: Icon(
                        LucideIcons.arrowLeft,
                        color: AppColors.text1,
                      ),
                    ),
                    title: WavySlider(
                      value: currentPage == OnboardingPage.experience
                          ? 0.25
                          : 0.50,
                      width: 250,
                    ),
                    actions: [Icon(LucideIcons.x, color: AppColors.text1)],
                  ),
                ),
              ),
            ),
          ),
          body: _buildBody(context, currentPage),
          bottomNavigationBar: AnimatedPadding(
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeIn,
            padding: EdgeInsets.only(
              right: 16.0,
              left: 16.0,
              bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              top: 16.0,
            ),
            child: Row(
              children: [
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  transitionBuilder: (child, animation) =>
                      FadeTransition(opacity: animation, child: child),
                  child: currentPage == OnboardingPage.question
                      ? BlocBuilder<QuestionBloc, QuestionState>(
                          builder: (context, state) {
                            if (state is! QuestionReady) {
                              return const SizedBox.shrink();
                            }

                            return state.showRecordingButtons
                                ? Padding(
                                    padding: const EdgeInsets.only(right: 16.0),
                                    child: RecordingButtons(
                                      key: ValueKey("recording"),
                                      state: state,
                                    ),
                                  )
                                : SizedBox.shrink(key: ValueKey("empty"));
                          },
                        )
                      : SizedBox.shrink(key: ValueKey("empty")),
                ),
                Expanded(child: _buildNextButton(context, currentPage)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, OnboardingPage page) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [ExperienceSelectionScreen(), OnboardingQuestionScreen()],
      ),
    );
  }

  Widget _buildNextButton(BuildContext context, OnboardingPage page) {
    switch (page) {
      case OnboardingPage.experience:
        final expState = context.watch<ExperienceBloc>().state;

        final bool isEnabled = expState is ExperienceLoaded
            ? expState.enableNextButton()
            : false;

        return GradientButton(
          label: AppStrings.next,
          isClickable: isEnabled,
          onTap: isEnabled
              ? () => context.read<OnboardingFlowCubit>().next()
              : () {},
        );

      case OnboardingPage.question:
        final state = context.watch<QuestionBloc>().state as QuestionReady;
        return GradientButton(
          label: AppStrings.next,
          isClickable: state.answerText.isNotEmpty || state.videoPath != null,
          onTap: () {},
        );
    }
  }
}
