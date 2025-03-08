// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_questions_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckQuestionsResponse _$CheckQuestionsResponseFromJson(
        Map<String, dynamic> json) =>
    CheckQuestionsResponse(
      message: json['message'] as String?,
      correct: (json['correct'] as num?)?.toInt(),
      wrong: (json['wrong'] as num?)?.toInt(),
      total: json['total'] as String?,
      WrongQuestions: json['WrongQuestions'] as List<dynamic>?,
      correctQuestions: json['correctQuestions'] as List<dynamic>?,
    );

Map<String, dynamic> _$CheckQuestionsResponseToJson(
        CheckQuestionsResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'correct': instance.correct,
      'wrong': instance.wrong,
      'total': instance.total,
      'WrongQuestions': instance.WrongQuestions,
      'correctQuestions': instance.correctQuestions,
    };

WrongQuestions _$WrongQuestionsFromJson(Map<String, dynamic> json) =>
    WrongQuestions(
      QID: json['QID'] as String?,
      Question: json['Question'] as String?,
      inCorrectAnswer: json['inCorrectAnswer'] as String?,
      correctAnswer: json['correctAnswer'] as String?,
      answers: json['answers'] == null
          ? null
          : Answers.fromJson(json['answers'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WrongQuestionsToJson(WrongQuestions instance) =>
    <String, dynamic>{
      'QID': instance.QID,
      'Question': instance.Question,
      'inCorrectAnswer': instance.inCorrectAnswer,
      'correctAnswer': instance.correctAnswer,
      'answers': instance.answers,
    };

Answers _$AnswersFromJson(Map<String, dynamic> json) => Answers();

Map<String, dynamic> _$AnswersToJson(Answers instance) => <String, dynamic>{};
