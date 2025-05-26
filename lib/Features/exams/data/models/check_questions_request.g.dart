// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_questions_request.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAnswersAdapter extends TypeAdapter<UserAnswers> {
  @override
  final int typeId = 0;

  @override
  UserAnswers read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserAnswers(
      questionId: fields[0] as String?,
      correct: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserAnswers obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.questionId)
      ..writeByte(1)
      ..write(obj.correct);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAnswersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckQuestionsRequest _$CheckQuestionsRequestFromJson(
        Map<String, dynamic> json) =>
    CheckQuestionsRequest(
      answers: (json['answers'] as List<dynamic>?)
          ?.map((e) => UserAnswers.fromJson(e as Map<String, dynamic>))
          .toList(),
      time: (json['time'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CheckQuestionsRequestToJson(
        CheckQuestionsRequest instance) =>
    <String, dynamic>{
      'answers': instance.answers,
      'time': instance.time,
    };

UserAnswers _$UserAnswersFromJson(Map<String, dynamic> json) => UserAnswers(
      questionId: json['questionId'] as String?,
      correct: json['correct'] as String?,
    );

Map<String, dynamic> _$UserAnswersToJson(UserAnswers instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'correct': instance.correct,
    };
