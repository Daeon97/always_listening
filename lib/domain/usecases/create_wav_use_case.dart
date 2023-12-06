import 'dart:typed_data';

import 'package:always_listening/core/errors/failure.dart';
import 'package:always_listening/domain/repositories/create_wav_repository.dart';
import 'package:dartz/dartz.dart';

abstract class CreateWavUseCase {
  Future<Either<Failure, String>> call(
    String filePath,
  );
}

final class CreateWavUseCaseImpl implements CreateWavUseCase {
  const CreateWavUseCaseImpl(
    this.createWavRepository,
  );

  final CreateWavRepository createWavRepository;

  @override
  Future<Either<Failure, String>> call(
    String filePath,
  ) =>
      createWavRepository(
        filePath,
      );
}
