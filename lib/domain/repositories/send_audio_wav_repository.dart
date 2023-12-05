import 'package:always_listening/core/errors/failure.dart';
import 'package:always_listening/domain/entities/transcription_entity.dart';
import 'package:dartz/dartz.dart';

abstract class SendAudioWavRepository {
  Future<Either<Failure, TranscriptionEntity>> call(
    String filePath,
  );
}
