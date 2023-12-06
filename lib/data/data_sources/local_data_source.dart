import 'dart:io';

import 'package:ffmpeg_kit_flutter_full/ffmpeg_kit.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

abstract final class LocalDataSource {
  const LocalDataSource();

  Future<String?> createWav(
    String filePath,
  );
}

final class LocalDataSourceImpl implements LocalDataSource {
  const LocalDataSourceImpl();

  @override
  Future<String?> createWav(
    String filePath,
  ) async {
    try {
      const fileName = 'Audio';

      final wavFile = File(
        '$filePath/$fileName.wav',
      );
      if (await wavFile.exists()) {
        await wavFile.delete();
      }

      final ffmpegSession = await FFmpegKit.executeAsync(
        '-i $filePath/$fileName.mp4 -c:v wav $filePath/$fileName.wav',
      );

      // Just for logging purposes
      // -------------------------------------------------------------
      if (kDebugMode) {
        final allLogsAsString = await ffmpegSession.getAllLogsAsString();
        final output = await ffmpegSession.getOutput();
        print('$allLogsAsString $output');
      }
      // -------------------------------------------------------------

      return '$filePath/$fileName.wav';
    } catch (_) {
      return null;
    }
  }
}
