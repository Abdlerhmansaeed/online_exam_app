import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_questions_request.g.dart';

@JsonSerializable()
class CheckQuestionsRequest {
  @JsonKey(name: "answers")
  final List<UserAnswers>? answers;
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
@HiveType(typeId: 0)
@JsonSerializable()
class UserAnswers {
  @HiveField(0)
  @JsonKey(name: "questionId")
  final String? questionId;
  @HiveField(1)
  @JsonKey(name: "correct")
  final String? correct;

  UserAnswers ({
    this.questionId,
    this.correct,
  });

  factory UserAnswers.fromJson(Map<String, dynamic> json) {
    return _$UserAnswersFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserAnswersToJson(this);
  }
}


