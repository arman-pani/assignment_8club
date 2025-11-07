import 'package:assignment_8club/bloc/question/question_bloc.dart';
import 'package:assignment_8club/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class RecordingButtons extends StatelessWidget {
  final QuestionReady state;
  const RecordingButtons({super.key, required this.state});

  void onAudioTap(BuildContext context) {
    final state = context.read<QuestionBloc>().state;
    //  context.read<QuestionBloc>().add(StartAudioRecordingEvent());
    if (state is QuestionReady &&
        !state.isRecording &&
        state.recordingType == RecordingType.none) {
        context.read<QuestionBloc>().add(StartAudioRecordingEvent());
      } else {
        context.read<QuestionBloc>().add(StopAudioRecordingEvent());
      }
    
  }

  void onVideoTap(BuildContext context) {
    final state = context.read<QuestionBloc>().state;
    if (state is QuestionReady &&
        !state.isRecording &&
        state.recordingType == RecordingType.none) {
      context.read<QuestionBloc>().add(StartVideoRecordingEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: AppColors.border1),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => onAudioTap(context),
            child: Container(
              padding: EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                gradient:
                    state.isRecording &&
                        state.recordingType == RecordingType.audio
                    ? AppColors.boxGradient
                    : null,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                ),
              ),
              child: Icon(LucideIcons.mic, color: AppColors.text1),
            ),
          ),
          Divider(color: AppColors.border1, thickness: 2.0, height: 20.0),
          GestureDetector(
            onTap: () => onVideoTap(context),
            child: Container(
              padding: EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                gradient: state.isRecording &&
                        state.recordingType == RecordingType.video
                    ? AppColors.boxGradient
                    : null,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                ),
              ),
              child: Icon(LucideIcons.video, color: AppColors.text1),
            ),
          ),
        ],
      ),
    );
  }
}
