part of 'question_bloc.dart';

enum RecordingType { audio, video, none }

@immutable
sealed class QuestionState {}

final class QuestionInitial extends QuestionState {}

final class RecordingInProgress extends QuestionState {
  final RecorderController controller;
  RecordingInProgress(this.controller);
}

final class QuestionReady extends QuestionState with EquatableMixin {
  final String answerText;
  final String? audioPath;
  final String? videoPath;
  final bool isRecording;
  final RecordingType recordingType;
  final bool isDeleteAudio;
  final bool isDeleteVideo;
  final String? error;


  QuestionReady({
    this.answerText = '',
    this.audioPath,
    this.videoPath,
    this.isRecording = false,
    this.recordingType = RecordingType.none,
    this.isDeleteAudio = false,
    this.isDeleteVideo = false,
    this.error,
  });

  @override
  List<Object?> get props => [
    answerText,
    audioPath,
    videoPath,
    isRecording,
    recordingType,
    isDeleteAudio,
    isDeleteVideo,
    error,
  ];

  QuestionReady copyWith({
    String? answerText,
    String? audioPath,
    String? videoPath,
    bool? isRecording,
    RecordingType? recordingType,
    bool? isDeleteAudio,
    bool? isDeleteVideo,
    String? error,
  }) {
    return QuestionReady(
      answerText: answerText ?? this.answerText,
      audioPath: audioPath ?? this.audioPath,
      videoPath: videoPath ?? this.videoPath,
      isRecording: isRecording ?? this.isRecording,
      recordingType: recordingType ?? this.recordingType,
      isDeleteAudio: isDeleteAudio ?? this.isDeleteAudio,
      isDeleteVideo: isDeleteVideo ?? this.isDeleteVideo,
      error: error ?? this.error,
    );
  }

  bool get showRecordingButtons => (audioPath == null || isDeleteAudio) && 
    (videoPath == null || isDeleteVideo);

  bool get showAudioRecording =>
      audioPath == null && recordingType == RecordingType.audio;
  bool get showAudioRecorded => audioPath != null && recordingType == RecordingType.none;
  bool get showVideoRecorded =>
      videoPath != null &&
      videoPath!.isNotEmpty &&
      recordingType == RecordingType.none;

  bool get shortTextfield => audioPath != null || videoPath != null || isRecording;
}
