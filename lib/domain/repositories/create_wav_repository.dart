import 'dart:typed_data';

import 'package:always_listening/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class CreateWavRepository {
  Future<Either<Failure, String>> call(
      Stream<Uint8List> audio,
      );
}