import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exam_questions_response.g.dart';

@JsonSerializable()
class ExamQuestionsResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "questions")
  final List<Questions>? questions;

  ExamQuestionsResponse ({
    this.message,
    this.questions,
  });

  factory ExamQuestionsResponse.fromJson(Map<String, dynamic> json) {
    return _$ExamQuestionsResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ExamQuestionsResponseToJson(this);
  }
}

@HiveType(typeId: 2)
@JsonSerializable()
class Questions extends HiveObject {
  @HiveField(0)
  @JsonKey(name: "answers")
  final List<ExamAnswers>? answers;

  @HiveField(1)
  @JsonKey(name: "type")
  final String? type;

  @HiveField(2)
  @JsonKey(name: "_id")
  final String? Id;

  @HiveField(3)
  @JsonKey(name: "question")
  final String? question;

  @HiveField(4)
  @JsonKey(name: "correct")
  final String? correct;

  @HiveField(5)
  @JsonKey(name: "subject")
  final Subject? subject;

  @HiveField(6)
  @JsonKey(name: "exam")
  final Exam? exam;

  @HiveField(7)
  @JsonKey(name: "createdAt")
  final String? createdAt;

  Questions({
    this.answers,
    this.type,
    this.Id,
    this.question,
    this.correct,
    this.subject,
    this.exam,
    this.createdAt,
  });

  factory Questions.fromJson(Map<String, dynamic> json) => _$QuestionsFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionsToJson(this);
}

@JsonSerializable()
class ExamAnswers {
  @JsonKey(name: "answer")
  final String? answer;
  @JsonKey(name: "key")
  final String? key;

  ExamAnswers ({
    this.answer,
    this.key,
  });

  factory ExamAnswers.fromJson(Map<String, dynamic> json) {
    return _$ExamAnswersFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ExamAnswersToJson(this);
  }
}

@JsonSerializable()
class Subject {
  @JsonKey(name: "_id")
  final String? Id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "icon")
  final String? icon;
  @JsonKey(name: "createdAt")
  final String? createdAt;

  Subject ({
    this.Id,
    this.name,
    this.icon,
    this.createdAt,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return _$SubjectFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SubjectToJson(this);
  }
}

@JsonSerializable()
class Exam {
  @JsonKey(name: "_id")
  final String? Id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "duration")
  final int? duration;
  @JsonKey(name: "subject")
  final String? subject;
  @JsonKey(name: "numberOfQuestions")
  final int? numberOfQuestions;
  @JsonKey(name: "active")
  final bool? active;
  @JsonKey(name: "createdAt")
  final String? createdAt;

  Exam ({
    this.Id,
    this.title,
    this.duration,
    this.subject,
    this.numberOfQuestions,
    this.active,
    this.createdAt,
  });

  factory Exam.fromJson(Map<String, dynamic> json) {
    return _$ExamFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ExamToJson(this);
  }
}


