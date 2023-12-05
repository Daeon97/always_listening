import 'dart:typed_data';

import 'package:always_listening/core/errors/failure.dart';
import 'package:always_listening/domain/repositories/create_wav_repository.dart';
import 'package:dartz/dartz.dart';

final class CreateWavUseCase {
  const CreateWavUseCase(
    this.createWavRepository,
  );

  final CreateWavRepository createWavRepository;

  Future<Either<Failure, String>> call(
    Stream<Uint8List> audio,
  ) =>
      createWavRepository(
        audio,
      );
}
