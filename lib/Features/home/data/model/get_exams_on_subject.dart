import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_exams_on_subject.g.dart';

@JsonSerializable()
class GetExamsOnSubject {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "metadata")
  final Metadata? metadata;
  @JsonKey(name: "exams")
  final List<Exams>? exams;

  GetExamsOnSubject ({
    this.message,
    this.metadata,
    this.exams,
  });

  factory GetExamsOnSubject.fromJson(Map<String, dynamic> json) {
    return _$GetExamsOnSubjectFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetExamsOnSubjectToJson(this);
  }
}

@JsonSerializable()
class Metadata {
  @JsonKey(name: "currentPage")
  final int? currentPage;
  @JsonKey(name: "numberOfPages")
  final int? numberOfPages;
  @JsonKey(name: "limit")
  final int? limit;

  Metadata ({
    this.currentPage,
    this.numberOfPages,
    this.limit,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return _$MetadataFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MetadataToJson(this);
  }
}

@HiveType(typeId: 1) // Unique type ID for Hive
@JsonSerializable()
class Exams extends HiveObject {
  @HiveField(0)
  @JsonKey(name: "_id")
  final String? Id;

  @HiveField(1)
  @JsonKey(name: "title")
  final String? title;

  @HiveField(2)
  @JsonKey(name: "duration")
  final int? duration;

  @HiveField(3)
  @JsonKey(name: "subject")
  final String? subject;

  @HiveField(4)
  @JsonKey(name: "numberOfQuestions")
  final int? numberOfQuestions;

  @HiveField(5)
  @JsonKey(name: "active")
  final bool? active;

  @HiveField(6)
  @JsonKey(name: "createdAt")
  final String? createdAt;

  Exams({
    this.Id,
    this.title,
    this.duration,
    this.subject,
    this.numberOfQuestions,
    this.active,
    this.createdAt,
  });

  /// JSON Serialization
  factory Exams.fromJson(Map<String, dynamic> json) => _$ExamsFromJson(json);
  Map<String, dynamic> toJson() => _$ExamsToJson(this);
}


