part of 'api_calls_counter_bloc.dart';

abstract final class ApiCallsCounterEvent extends Equatable {
  const ApiCallsCounterEvent();
}

final class StartOperationEvent extends ApiCallsCounterEvent {
  const StartOperationEvent();

  @override
  List<Object?> get props => [];
}

final class _DispatchRequestEvent extends ApiCallsCounterEvent {
  const _DispatchRequestEvent(
    this.wavFilePath,
  );

  final String wavFilePath;

  @override
  List<Object?> get props => [
        wavFilePath,
      ];
}

final class _EmitTranscriptionEntityEvent extends ApiCallsCounterEvent {
  const _EmitTranscriptionEntityEvent(
    this.transcriptionEntity,
  );

  final TranscriptionEntity transcriptionEntity;

  @override
  List<Object?> get props => [
        transcriptionEntity,
      ];
}

final class _EmitFailureEvent extends ApiCallsCounterEvent {
  const _EmitFailureEvent(
    this.failure,
  );

  final Failure failure;

  @override
  List<Object?> get props => [
        failure,
      ];
}

final class StopOperationEvent extends ApiCallsCounterEvent {
  const StopOperationEvent();

  @override
  List<Object?> get props => [];
}
