
import 'package:online_exam_app/Features/home/domain/entity/all_subjects_entity.dart';

class AllSubjectsResponse {
  String? message;
  Metadata? metadata;
  List<SubjectsModel>? subjects;

  AllSubjectsResponse({this.message, this.metadata, this.subjects});

  AllSubjectsResponse.fromJson(Map<String, dynamic> json) {
    if(json["message"] is String) {
      message = json["message"];
    }
    if(json["metadata"] is Map) {
      metadata = json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]);
    }
    if(json["subjects"] is List) {
      subjects = json["subjects"] == null ? null : (json["subjects"] as List).map((e) => SubjectsModel.fromJson(e)).toList();
    }
  }
  static List<AllSubjectsResponse> fromList(List<Map<String, dynamic>> list) {
    return list.map(AllSubjectsResponse.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["message"] = message;
    if(metadata != null) {
      _data["metadata"] = metadata?.toJson();
    }
    if(subjects != null) {
      _data["subjects"] = subjects?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class SubjectsModel  {
 String? id;
  String? name;
  String? icon;
  String? createdAt;

  SubjectsModel({this.id, this.name, this.icon, this.createdAt});

  SubjectsModel.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["icon"] is String) {
      icon = json["icon"];
    }
    if(json["createdAt"] is String) {
      createdAt = json["createdAt"];
    }
  }

  static List<SubjectsModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(SubjectsModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["name"] = name;
    _data["icon"] = icon;
    _data["createdAt"] = createdAt;
    return _data;
  }
  SubjectsEntity toSubjectEntity(){
    return SubjectsEntity(name: name, icon: icon, createdAt: createdAt, id: id);
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