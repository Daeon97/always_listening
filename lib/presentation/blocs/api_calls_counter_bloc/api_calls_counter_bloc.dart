import 'dart:async';

import 'package:always_listening/core/errors/failure.dart';
import 'package:always_listening/domain/entities/transcription_entity.dart';
import 'package:always_listening/domain/usecases/create_wav_use_case.dart';
import 'package:always_listening/domain/usecases/send_audio_wav_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

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
    on<StartOperationEvent>(
      (event, emit) async {
        const MethodChannel(
          "com.engels_immanuel.always_listening",
        ).invokeMethod(
          "alwaysListen",
        );

        if (streamSubscription != null) {
          await streamSubscription!.cancel();
          streamSubscription = null;
        }

        streamSubscription = Stream.periodic(
          const Duration(
            seconds: 10,
          ),
        ).listen(
          (_) async {
            final directory = await getExternalStorageDirectory();
            final failureOrWavFilePath = await createWavUseCase(
              directory!.path,
            );
            failureOrWavFilePath.fold(
              (failure) => add(
                _EmitFailureEvent(
                  failure,
                ),
              ),
              (wavFilePath) => add(
                _DispatchRequestEvent(
                  wavFilePath,
                ),
              ),
            );
          },
        );
      },
    );

    on<_DispatchRequestEvent>(
      (event, emit) async {
        final failureOrTranscriptionEntity = await sendAudioWavUseCase(
          event.wavFilePath,
        );
        failureOrTranscriptionEntity.fold(
          (failure) => add(
            _EmitFailureEvent(
              failure,
            ),
          ),
          (transcriptionEntity) => add(
            _EmitTranscriptionEntityEvent(
              transcriptionEntity,
            ),
          ),
        );
      },
    );

    on<_EmitTranscriptionEntityEvent>(
      (event, emit) => emit(
        TranscriptionSuccessState(
          event.transcriptionEntity,
        ),
      ),
    );

    on<_EmitFailureEvent>(
      (event, emit) => emit(
        ApiCallsFailedState(
          event.failure,
        ),
      ),
    );

    on<StopOperationEvent>(
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
    return null;
  }

  @override
  Map<String, dynamic>? toJson(
    ApiCallsCounterState state,
  ) {
    return null;
  }
}
