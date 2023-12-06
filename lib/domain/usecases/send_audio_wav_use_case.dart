import 'package:always_listening/core/errors/failure.dart';
import 'package:always_listening/domain/entities/transcription_entity.dart';
import 'package:always_listening/domain/repositories/send_audio_wav_repository.dart';
import 'package:dartz/dartz.dart';

abstract class SendAudioWavUseCase {
  Future<Either<Failure, TranscriptionEntity>> call(
    String filePath,
  );
}

final class SendAudioWavUseCaseImpl implements SendAudioWavUseCase {
  const SendAudioWavUseCaseImpl(
    this.sendAudioWavRepository,
  );

  final SendAudioWavRepository sendAudioWavRepository;

  @override
  Future<Either<Failure, TranscriptionEntity>> call(
    String filePath,
  ) =>
      sendAudioWavRepository(
        filePath,
      );
}
