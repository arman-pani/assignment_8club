part of 'question_bloc.dart';

@immutable
sealed class QuestionEvent {}

final class StartAudioRecordingEvent extends QuestionEvent {}

final class StopAudioRecordingEvent extends QuestionEvent {}

final class StartVideoRecordingEvent extends QuestionEvent {}

final class UpdateAnswerTextEvent extends QuestionEvent {
  final String answerText;

  UpdateAnswerTextEvent(this.answerText);
}

final class DeleteAudioRecordingEvent extends QuestionEvent {}

final class DeleteVideoRecordingEvent extends QuestionEvent {}

final class SubmitAnswerEvent extends QuestionEvent {}
