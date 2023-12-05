import 'dart:typed_data';

import 'package:always_listening/core/errors/failure.dart';
import 'package:always_listening/domain/repositories/create_wav_repository.dart';
import 'package:dartz/dartz.dart';

abstract class CreateWavUseCase {
  Future<Either<Failure, String>> call(
    Stream<Uint8List> audio,
  );
}

final class CreateWavUseCaseImpl implements CreateWavUseCase {
  const CreateWavUseCaseImpl(
    this.createWavRepository,
  );

  final CreateWavRepository createWavRepository;

  @override
  Future<Either<Failure, String>> call(
    Stream<Uint8List> audio,
  ) =>
      createWavRepository(
        audio,
      );
}
