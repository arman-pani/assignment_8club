import 'dart:async';

import 'package:assignment_8club/utils/video_service.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  final VideoService videoService;

  final RecorderController recorderController;
  final PlayerController playerController;

  QuestionBloc(
    this.videoService,
    this.recorderController,
    this.playerController,
  ) : super(QuestionReady()) {
    playerController.updateFrequency = UpdateFrequency.high;
    playerController.setFinishMode(finishMode: FinishMode.pause);

    on<UpdateAnswerTextEvent>(_onUpdateAnswerText);
    on<StartAudioRecordingEvent>(_onStartAudioRecording);
    on<StopAudioRecordingEvent>(_onStopAudioRecording);
    on<DeleteAudioRecordingEvent>(_onDeleteAudioRecording);
    on<StartVideoRecordingEvent>(_onStartVideoRecording);
    on<DeleteVideoRecordingEvent>(_onDeleteVideoRecording);
    on<SubmitAnswerEvent>(_onSubmitAnswer);
  }

  void _onUpdateAnswerText(
    UpdateAnswerTextEvent event,
    Emitter<QuestionState> emit,
  ) {
    if (state is QuestionReady) {
      final currentState = state as QuestionReady;

      emit(currentState.copyWith(answerText: event.answerText));
    }
  }

  Future<void> _onStartAudioRecording(
    StartAudioRecordingEvent event,
    Emitter<QuestionState> emit,
  ) async {
    if (state is QuestionReady) {
      final currentState = state as QuestionReady;

      final status = await Permission.microphone.request();
      if (!status.isGranted) {
        emit(currentState.copyWith(error: 'Microphone permission denied'));
        return;
      }
      emit(
        currentState.copyWith(
          isDeleteAudio: false,
          isDeleteVideo: false 
        ),
      );

      await recorderController.record();
      debugPrint("recording :::");
      emit(
        currentState.copyWith(
          isRecording: true,
          recordingType: RecordingType.audio,
          error: null,
          isDeleteAudio: false,
          isDeleteVideo: false 
        ),
      );
    }
  }

  void _onStopAudioRecording(
    StopAudioRecordingEvent event,
    Emitter<QuestionState> emit,
  ) async {
    if (state is! QuestionReady) return;
    final currentState = state as QuestionReady;

    if (recorderController.isRecording) {
      final path = await recorderController.stop();

      if (path != null) {
        await playerController.preparePlayer(
          path: path,
          shouldExtractWaveform: true,
        );
      }

      emit(
        currentState.copyWith(
          isRecording: false,
          recordingType: RecordingType.none,
          audioPath: path,
        ),
      );
    }
  }

  void _onDeleteAudioRecording(
    DeleteAudioRecordingEvent event,
    Emitter<QuestionState> emit,
  ) {
    if (state is QuestionReady) {
      final currentState = state as QuestionReady;

      debugPrint("Deleting Audio!!!");

      emit(
        currentState.copyWith(
          isRecording: false,
          recordingType: RecordingType.none,
          audioPath: null,
          isDeleteAudio: true
        ),
      );
    }
  }

  Future<void> _onStartVideoRecording(
    StartVideoRecordingEvent event,
    Emitter<QuestionState> emit,
  ) async {
    if (state is QuestionReady) {
      final currentState = state as QuestionReady;

      final cameraStatus = await Permission.camera.request();
      final microphoneStatus = await Permission.microphone.request();

      if (!cameraStatus.isGranted || !microphoneStatus.isGranted) {
        emit(
          currentState.copyWith(
            error: 'Camera or microphone permission denied',
          ),
        );
        return;
      }

      emit(
        currentState.copyWith(
          isRecording: true,
          recordingType: RecordingType.video,
          error: null,
          videoPath: null,
          isDeleteAudio: false,
          isDeleteVideo: false 
        ),
      );

      final savedFile = await videoService.recordVideo();
      debugPrint('Video saved at: ${savedFile?.path}');

      emit(
        currentState.copyWith(
          isRecording: false,
          recordingType: RecordingType.none,
          videoPath: savedFile?.path,
          error: null,
        ),
      );
    }
  }

  // Future<void> _onStopVideoRecording(
  //   StopVideoRecordingEvent event,
  //   Emitter<QuestionState> emit,
  // ) async {
  //   if (state is QuestionReady) {
  //     final currentState = state as QuestionReady;
  //     _stopRecordingTimer();

  //     final savedFile = await videoService.stopRecording();

  //     debugPrint('Video saved at: ${savedFile.path}');

  //     emit(
  //       currentState.copyWith(
  //         isRecording: false,
  //         recordingType: RecordingType.none,
  //         videoPath: savedFile.path,
  //       ),
  //     );
  //   }
  // }

  void _onDeleteVideoRecording(
    DeleteVideoRecordingEvent event,
    Emitter<QuestionState> emit,
  ) {
    if (state is QuestionReady) {
      final currentState = state as QuestionReady;
      debugPrint('Deleting video at path: ${currentState.videoPath}');
      emit(
        currentState.copyWith(
          videoPath: null,
          recordingType: RecordingType.none,
          isRecording: false,
          error: null,
          isDeleteVideo: true
        ),
      );
    }
  }

  void _onSubmitAnswer(SubmitAnswerEvent event, Emitter<QuestionState> emit) {
    if (state is QuestionReady) {
      final currentState = state as QuestionReady;
      debugPrint('Answer submitted:');
      debugPrint('Text: ${currentState.answerText}');
      debugPrint('Audio: ${currentState.audioPath}');
      debugPrint('Video: ${currentState.videoPath}');
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
