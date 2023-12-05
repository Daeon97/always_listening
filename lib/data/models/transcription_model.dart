import 'package:always_listening/domain/entities/transcription_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transcription_model.g.dart';

@JsonSerializable()
final class TranscriptionModel extends TranscriptionEntity {
  const TranscriptionModel(
    super.text,
  );

  factory TranscriptionModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$TranscriptionModelFromJson(
        json,
      );

  Map<String, dynamic> toJson() => _$TranscriptionModelToJson(
        this,
      );
}
