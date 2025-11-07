import 'dart:ui';

import 'package:assignment_8club/bloc/question/question_bloc.dart';
import 'package:assignment_8club/constants/app_colors.dart';
import 'package:assignment_8club/constants/app_strings.dart';
import 'package:assignment_8club/constants/app_textstyles.dart';
import 'package:assignment_8club/utils/helpers.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AudioRecorder extends StatefulWidget {
  final RecorderController audioController;
  final QuestionReady state;
  const AudioRecorder({
    super.key,
    required this.audioController,
    required this.state,
  });

  @override
  State<AudioRecorder> createState() => _AudioRecorderState();
}

class _AudioRecorderState extends State<AudioRecorder>
    with WidgetsBindingObserver {
  bool keyboardOpen = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding
        .instance
        .platformDispatcher
        .views
        .first
        .viewInsets
        .bottom;

    setState(() {
      keyboardOpen = bottomInset > 0;
    });
  }

  void onPlayerTap() async {
    final _playerController = context.read<QuestionBloc>().playerController;

    if (!widget.state.isRecording) {
      if (_playerController.playerState.isPlaying) {
        await _playerController.pausePlayer();
      } else {
        await _playerController.startPlayer();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isRecording = widget.state.isRecording;

    return ListenableBuilder(
      listenable: widget.audioController,
      builder: (context, _) {
        return Container(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 4.0,
            top: 8.0,
            bottom: 8.0,
          ),
          decoration: BoxDecoration(
            gradient: AppColors.boxGradient ,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: AppColors.border1),
          ),
          child: Column(
            spacing: 8.0,
            children: [
              _buildHeader(context, isRecording),
              if (!keyboardOpen) _buildAudioSection(isRecording),
            ],
          ),
        );
      },
    );
  }

  Row _buildAudioSection(bool isRecording) {
    final _playerController = context.read<QuestionBloc>().playerController;
    return Row(
      children: [
        _buildPlayButton(isRecording, _playerController),
        SizedBox(width: 12.0),
        isRecording
            ? AudioWaveforms(
                enableGesture: false,
                size: Size(200, 50),
                recorderController: widget.audioController,
                waveStyle: WaveStyle(
                  waveColor: AppColors.text1,
                  extendWaveform: true,
                  showMiddleLine: false,
                ),
              )
            : AudioFileWaveforms(
                waveformType: WaveformType.fitWidth,
                continuousWaveform: true,
                animationDuration: Duration(milliseconds: 80),
                enableSeekGesture: false,
                size: Size(200, 50),
                playerController: _playerController,
              ),

        if (isRecording)
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Text(
              formatDuration(widget.audioController.elapsedDuration),
              style: AppTextStyles.b1.copyWith(
                color: AppColors.primaryAccent,
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
      ],
    );
  }

  Row _buildHeader(BuildContext context, bool isRecording) {
    final _playerController = context.read<QuestionBloc>().playerController;
    return Row(
      spacing: 12.0,
      children: [
        if (keyboardOpen) _buildPlayButton(isRecording, _playerController),
        Text.rich(
          TextSpan(
            text: isRecording
                ? AppStrings.recordingAudio
                : AppStrings.audioRecorded,
            style: AppTextStyles.b1.copyWith(
              fontWeight: FontWeight.w200,
              color: AppColors.text1,
            ),
            children: [
              if (!isRecording)
                TextSpan(
                  text:
                      " • ${formatDuration(widget.audioController.recordedDuration)}",
                  style: AppTextStyles.b1.copyWith(
                    fontWeight: FontWeight.w200,
                    color: AppColors.text4,
                  ),
                ),
            ],
          ),
        ),
        Spacer(),
        IconButton(
          visualDensity: VisualDensity.compact,
          onPressed: () =>
              context.read<QuestionBloc>().add(DeleteAudioRecordingEvent()),
          iconSize: 16.0,
          icon: Icon(LucideIcons.trash2, color: AppColors.primaryAccent),
        ),
      ],
    );
  }

  Widget _buildPlayButton(bool isRecording, PlayerController playerController) {
    final circleRadius = keyboardOpen ? 24.0 : 34.0;
    final iconSize = keyboardOpen ? 12.0 : 16.0;
    return GestureDetector(
      onTap: onPlayerTap,
      child: Container(
        height: circleRadius,
        width: circleRadius,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isRecording
              ? AppColors.primaryAccent
              : AppColors.secondaryAccent,
        ),
        child: Icon(
          isRecording
              ? LucideIcons.mic
              : playerController.playerState.isStopped
              ? LucideIcons.pause
              : LucideIcons.play,
          color: AppColors.text1,
          size: iconSize,
        ),
      ),
    );
  }
}
