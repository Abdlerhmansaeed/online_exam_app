import 'package:equatable/equatable.dart';

class AnswerOption extends Equatable {
  final String key;
  final String text;

  const AnswerOption({
    required this.key,
    required this.text,
  });

  factory AnswerOption.fromJson(Map<String, dynamic> json) {
    return AnswerOption(
      key: json['key'] ?? '',
      text: json['text'] ?? json['answer'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'text': text,
    };
  }

  @override
  List<Object?> get props => [key, text];
}
