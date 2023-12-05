import 'package:always_listening/core/errors/failure.dart';
import 'package:always_listening/domain/entities/transcription_entity.dart';
import 'package:always_listening/domain/repositories/send_audio_wav_repository.dart';
import 'package:dartz/dartz.dart';

final class SendAudioWavUseCase {
  const SendAudioWavUseCase(
    this.sendAudioWavRepository,
  );

  final SendAudioWavRepository sendAudioWavRepository;

  Future<Either<Failure, TranscriptionEntity>> call(
    String filePath,
  ) =>
      sendAudioWavRepository(
        filePath,
      );
}
