import 'package:always_listening/core/errors/failure.dart';
import 'package:always_listening/data/data_sources/remote_data_source.dart';
import 'package:always_listening/domain/entities/transcription_entity.dart';
import 'package:always_listening/domain/repositories/send_audio_wav_repository.dart';
import 'package:dartz/dartz.dart';

final class SendAudioWavRepositoryImpl implements SendAudioWavRepository {
  const SendAudioWavRepositoryImpl(
    this.remoteDataSource,
  );

  final RemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, TranscriptionEntity>> call(
    String filePath,
  ) async {
    final transcriptionModel = await remoteDataSource.sendAudioWav(
      filePath,
    );
    return switch (transcriptionModel) {
      null => const Left(
          Failure(
            'Could not send audio',
          ),
        ),
      _ => Right(
          transcriptionModel,
        )
    };
  }
}
