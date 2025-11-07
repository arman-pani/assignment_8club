import 'package:assignment_8club/bloc/question/question_bloc.dart';
import 'package:assignment_8club/constants/app_colors.dart';
import 'package:assignment_8club/constants/app_strings.dart';
import 'package:assignment_8club/constants/app_textstyles.dart';
import 'package:assignment_8club/widgets/audio_recorder.dart';
import 'package:assignment_8club/widgets/multiline_textfield.dart';
import 'package:assignment_8club/widgets/video_recorded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingQuestionScreen extends StatefulWidget {
  const OnboardingQuestionScreen({super.key});

  @override
  State<OnboardingQuestionScreen> createState() =>
      _OnboardingQuestionScreenState();
}

class _OnboardingQuestionScreenState extends State<OnboardingQuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuestionBloc, QuestionState>(
      listener: (context, state) {
        if (state is QuestionReady && state.error != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error!)));
        }
      },
      builder: (context, state) {
        if (state is QuestionReady) {
          return _buildContent(context, state);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildContent(BuildContext context, QuestionReady state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          spacing: 8.0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.second,
              style: AppTextStyles.s1.copyWith(color: AppColors.text5),
            ),
            Text(
              AppStrings.onboardingQuestionTitle,
              style: AppTextStyles.b2.copyWith(color: AppColors.text1),
            ),
            Text(
              AppStrings.onboardingQuestionSubtitle,
              style: AppTextStyles.b2.copyWith(
                color: AppColors.text3,
                fontWeight: FontWeight.w200,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        MultilineTextfield(
          maxLength: 600,
          maxLines: state.shortTextfield ? 4 : 10,
          hintText: AppStrings.onboardingQuestionHint,
          controller: TextEditingController(),
          onChanged: (value) {
            context.read<QuestionBloc>().add(UpdateAnswerTextEvent(value));
          },
        ),
        state.showAudioRecording || state.showAudioRecorded
            ? !state.isDeleteAudio
                  ? Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: AudioRecorder(
                        audioController: context
                            .read<QuestionBloc>()
                            .recorderController,
                        state: state,
                      ),
                  )
                  : SizedBox()
            : SizedBox(),
        state.showVideoRecorded
            ? !state.isDeleteVideo
                  ? Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: VideoRecorded(
                        videoPath: state.videoPath!,
                        onDelete: () {
                          context.read<QuestionBloc>().add(
                            DeleteVideoRecordingEvent(),
                          );
                        },
                      ),
                  )
                  : SizedBox()
            : SizedBox(),
      ],
    );
  }
}
