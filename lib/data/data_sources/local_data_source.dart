import 'dart:typed_data';

abstract final class LocalDataSource {
  const LocalDataSource();

  Future<String?> createWav(
    Stream<Uint8List> audio,
  );
}

final class LocalDataSourceImplementation implements LocalDataSource {
  const LocalDataSourceImplementation();

  @override
  Future<String?> createWav(
    Stream<Uint8List> audio,
  ) async {
    try {
      // create wav file. Return null if there was an issue creating file
      return null;
    } catch (_) {
      return null;
    }
  }
}