part of 'api_calls_counter_bloc.dart';

abstract final class ApiCallsCounterEvent extends Equatable {
  const ApiCallsCounterEvent();
}

final class StartOperation extends ApiCallsCounterEvent {
  const StartOperation();

  @override
  List<Object?> get props => [];
}

final class StopOperation extends ApiCallsCounterEvent {
  const StopOperation();

  @override
  List<Object?> get props => [];
}
