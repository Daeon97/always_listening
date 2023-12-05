part of 'api_calls_counter_bloc.dart';

abstract final class ApiCallsCounterState extends Equatable {
  const ApiCallsCounterState();
}

final class ApiCallsInitialState extends ApiCallsCounterState {
  const ApiCallsInitialState();

  @override
  List<Object?> get props => [];
}

final class ApiCallsState extends ApiCallsCounterState {
  const ApiCallsState({
    required this.count,
    required this.lastThreeResults,
  });

  final int count;
  final List<TranscriptionEntity> lastThreeResults;

  @override
  List<Object?> get props => [
        count,
        lastThreeResults,
      ];
}

final class ApiCallsFailedState extends ApiCallsCounterState {
  const ApiCallsFailedState(
    this.failure,
  );

  final Failure failure;

  @override
  List<Object?> get props => [
        failure,
      ];
}
