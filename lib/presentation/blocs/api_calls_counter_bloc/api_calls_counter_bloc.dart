import 'dart:async';

import 'package:always_listening/domain/usecases/create_wav_use_case.dart';
import 'package:always_listening/domain/usecases/send_audio_wav_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'api_calls_counter_event.dart';

part 'api_calls_counter_state.dart';

class ApiCallsCounterBloc
    extends HydratedBloc<ApiCallsCounterEvent, ApiCallsCounterState> {
  ApiCallsCounterBloc({
    required this.sendAudioWavUseCase,
    required this.createWavUseCase,
  }) : super(
          const ApiCallsInitialState(),
        ) {
    on<StartOperation>(
      (event, emit) async {
        if (streamSubscription != null) {
          await streamSubscription!.cancel();
          streamSubscription = null;
        }
        streamSubscription = streamSubscription = Stream.periodic(
          const Duration(
            seconds: 5,
          ),
        ).listen(
          (event) {
            // invoke method channel first and get audio stream
            // final createWav = createWavUseCase(); //send audio stream to create wav use case
            // final sendWav = sendAudioWavUseCase();// use audio path returned from createWav to send to API
            // Then emit a new state. The state is always persisted when  we emit new state since we use hydrated BLoC
          },
        );
      },
    );

    on<StopOperation>(
      (event, emit) async {
        if (streamSubscription != null) {
          await streamSubscription!.cancel();
          streamSubscription = null;
        }
      },
    );
  }

  final SendAudioWavUseCase sendAudioWavUseCase;
  final CreateWavUseCase createWavUseCase;

  StreamSubscription? streamSubscription;

  @override
  ApiCallsCounterState? fromJson(
    Map<String, dynamic> json,
  ) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toJson(
    ApiCallsCounterState state,
  ) {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
