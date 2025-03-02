import 'package:online_exam_app/Features/home/domain/entity/exams_on_subject_entity.dart';

class ExamsOnSubjectResponse {
  String? message;
  Metadata? metadata;
  List<ExamsOnSubjectModel>? exams;

  ExamsOnSubjectResponse({this.message, this.metadata, this.exams});

  ExamsOnSubjectResponse.fromJson(Map<String, dynamic> json) {
    if(json["message"] is String) {
      message = json["message"];
    }
    if(json["metadata"] is Map) {
      metadata = json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]);
    }
    if(json["exams"] is List) {
      exams = json["exams"] == null ? null : (json["exams"] as List).map((e) => ExamsOnSubjectModel.fromJson(e)).toList();
    }
  }

  static List<ExamsOnSubjectResponse> fromList(List<Map<String, dynamic>> list) {
    return list.map(ExamsOnSubjectResponse.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["message"] = message;
    if(metadata != null) {
      _data["metadata"] = metadata?.toJson();
    }
    if(exams != null) {
      _data["exams"] = exams?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class ExamsOnSubjectModel extends ExamsOnSubjectEntity {

  ExamsOnSubjectModel({super.id, super.title, super.duration, super.subject, super.numberOfQuestions, super.active, super.createdAt});

  ExamsOnSubjectModel.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["title"] is String) {
      title = json["title"];
    }
    if(json["duration"] is int) {
      duration = json["duration"];
    }
    if(json["subject"] is String) {
      subject = json["subject"];
    }
    if(json["numberOfQuestions"] is int) {
      numberOfQuestions = json["numberOfQuestions"];
    }
    if(json["active"] is bool) {
      active = json["active"];
    }
    if(json["createdAt"] is String) {
      createdAt = json["createdAt"];
    }
  }

  static List<ExamsOnSubjectModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(ExamsOnSubjectModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["title"] = title;
    _data["duration"] = duration;
    _data["subject"] = subject;
    _data["numberOfQuestions"] = numberOfQuestions;
    _data["active"] = active;
    _data["createdAt"] = createdAt;
    return _data;
  }
 ExamsOnSubjectEntity toExamsOnSubjectEntity() {
    return ExamsOnSubjectEntity(
        id: id,
        title: title,
        duration: duration,
        subject: subject,
        numberOfQuestions: numberOfQuestions,
        active: active,
        createdAt: createdAt);
  }
}

class Metadata {
  int? currentPage;
  int? numberOfPages;
  int? limit;

  Metadata({this.currentPage, this.numberOfPages, this.limit});

  Metadata.fromJson(Map<String, dynamic> json) {
    if(json["currentPage"] is int) {
      currentPage = json["currentPage"];
    }
    if(json["numberOfPages"] is int) {
      numberOfPages = json["numberOfPages"];
    }
    if(json["limit"] is int) {
      limit = json["limit"];
    }
  }

  static List<Metadata> fromList(List<Map<String, dynamic>> list) {
    return list.map(Metadata.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["currentPage"] = currentPage;
    _data["numberOfPages"] = numberOfPages;
    _data["limit"] = limit;
    return _data;
  }
}