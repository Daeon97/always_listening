import 'dart:typed_data';

import 'package:always_listening/core/errors/failure.dart';
import 'package:always_listening/data/data_sources/local_data_source.dart';
import 'package:always_listening/domain/repositories/create_wav_repository.dart';
import 'package:dartz/dartz.dart';

final class CreateWavRepositoryImpl implements CreateWavRepository {
  const CreateWavRepositoryImpl(
    this.localDataSource,
  );

  final LocalDataSource localDataSource;

  @override
  Future<Either<Failure, String>> call(
    String filePath,
  ) async {
    final path = await localDataSource.createWav(
      filePath,
    );
    return switch (path) {
      null => const Left(
          Failure(
            'Could not create wav file',
          ),
        ),
      _ => Right(
          path,
        )
    };
  }
}
