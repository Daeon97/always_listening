import 'package:equatable/equatable.dart';

base class TranscriptionEntity extends Equatable {
  const TranscriptionEntity(
    this.text,
  );

  final String text;

  @override
  List<Object?> get props => [
        text,
      ];
}
