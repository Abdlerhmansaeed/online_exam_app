// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_questions_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExamQuestionsResponse _$ExamQuestionsResponseFromJson(
        Map<String, dynamic> json) =>
    ExamQuestionsResponse(
      message: json['message'] as String?,
      questions: (json['questions'] as List<dynamic>?)
          ?.map((e) => Questions.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExamQuestionsResponseToJson(
        ExamQuestionsResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'questions': instance.questions,
    };

Questions _$QuestionsFromJson(Map<String, dynamic> json) => Questions(
      answers: (json['answers'] as List<dynamic>?)
          ?.map((e) => Answers.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: json['type'] as String?,
      Id: json['_id'] as String?,
      question: json['question'] as String?,
      correct: json['correct'] as String?,
      subject: json['subject'] == null
          ? null
          : Subject.fromJson(json['subject'] as Map<String, dynamic>),
      exam: json['exam'] == null
          ? null
          : Exam.fromJson(json['exam'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$QuestionsToJson(Questions instance) => <String, dynamic>{
      'answers': instance.answers,
      'type': instance.type,
      '_id': instance.Id,
      'question': instance.question,
      'correct': instance.correct,
      'subject': instance.subject,
      'exam': instance.exam,
      'createdAt': instance.createdAt,
    };

Answers _$AnswersFromJson(Map<String, dynamic> json) => Answers(
      answer: json['answer'] as String?,
      key: json['key'] as String?,
    );

Map<String, dynamic> _$AnswersToJson(Answers instance) => <String, dynamic>{
      'answer': instance.answer,
      'key': instance.key,
    };

Subject _$SubjectFromJson(Map<String, dynamic> json) => Subject(
      Id: json['_id'] as String?,
      name: json['name'] as String?,
      icon: json['icon'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$SubjectToJson(Subject instance) => <String, dynamic>{
      '_id': instance.Id,
      'name': instance.name,
      'icon': instance.icon,
      'createdAt': instance.createdAt,
    };

Exam _$ExamFromJson(Map<String, dynamic> json) => Exam(
      Id: json['_id'] as String?,
      title: json['title'] as String?,
      duration: (json['duration'] as num?)?.toInt(),
      subject: json['subject'] as String?,
      numberOfQuestions: (json['numberOfQuestions'] as num?)?.toInt(),
      active: json['active'] as bool?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$ExamToJson(Exam instance) => <String, dynamic>{
      '_id': instance.Id,
      'title': instance.title,
      'duration': instance.duration,
      'subject': instance.subject,
      'numberOfQuestions': instance.numberOfQuestions,
      'active': instance.active,
      'createdAt': instance.createdAt,
    };
