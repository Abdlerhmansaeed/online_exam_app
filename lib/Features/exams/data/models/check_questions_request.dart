import 'package:json_annotation/json_annotation.dart';

part 'check_questions_request.g.dart';

@JsonSerializable()
class CheckQuestionsRequest {
  @JsonKey(name: "answers")
  final List<Answers>? answers;
  @JsonKey(name: "time")
  final int? time;

  CheckQuestionsRequest ({
    this.answers,
    this.time,
  });

  factory CheckQuestionsRequest.fromJson(Map<String, dynamic> json) {
    return _$CheckQuestionsRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CheckQuestionsRequestToJson(this);
  }
}

@JsonSerializable()
class Answers {
  @JsonKey(name: "questionId")
  final String? questionId;
  @JsonKey(name: "correct")
  final String? correct;

  Answers ({
    this.questionId,
    this.correct,
  });

  factory Answers.fromJson(Map<String, dynamic> json) {
    return _$AnswersFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AnswersToJson(this);
  }
}


