import 'dart:convert';

import 'package:always_listening/data/models/transcription_model.dart';
import 'package:http/http.dart' as http;

abstract final class RemoteDataSource {
  const RemoteDataSource();

  Future<TranscriptionModel?> sendAudioWav(
    String filePath,
  );
}

final class RemoteDataSourceImpl implements RemoteDataSource {
  const RemoteDataSourceImpl();

  @override
  Future<TranscriptionModel?> sendAudioWav(
    String filePath,
  ) async {
    try {
      // Create a multipart request
      final request = http.MultipartRequest('POST',
          Uri.parse('https://35.207.149.36:443/stt_flutter_tech_assignment'));

      // Add headers
      request.headers.addAll({
        'Authorization': 'Bearer KsJ5Ag3',
      });

      // Add the file
      var file = await http.MultipartFile.fromPath('file', filePath);
      request.files.add(file);

      // Send the request
      final response = await request.send();

      if (response.statusCode == 200) {
        // final body = response.body; // Usually the raw json string
        //
        // return jsonDecode(body); // Decoded Map<String, dynamic>
        // return the model here
        return null;
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }
}
