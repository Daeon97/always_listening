import 'dart:async';

import 'package:always_listening/core/errors/failure.dart';
import 'package:always_listening/domain/entities/transcription_entity.dart';
import 'package:always_listening/domain/usecases/create_wav_use_case.dart';
import 'package:always_listening/domain/usecases/send_audio_wav_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
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
        if (audioStreamSubscription != null) {
          await audioStreamSubscription!.cancel();
          audioStreamSubscription = null;
        }

        // final currentTimeSecond = DateTime.now().second;

        audioStreamSubscription =
            const EventChannel("com.engels_immanuel.always_listening")
                .receiveBroadcastStream()
                .listen(
          (event) {
            print('I have no idea what this is. Lets see --> $event');
            // if (currentTimeSecond % 5 == 0) {
            //   // collect
            // }
          },
        );
      },
    );

    on<StopOperation>(
      (event, emit) async {
        if (audioStreamSubscription != null) {
          await audioStreamSubscription!.cancel();
          audioStreamSubscription = null;
        }
      },
    );
  }

  final SendAudioWavUseCase sendAudioWavUseCase;
  final CreateWavUseCase createWavUseCase;

  StreamSubscription? audioStreamSubscription;

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
