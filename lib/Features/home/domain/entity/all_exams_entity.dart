

class SubjectsEntity {
  String? id;
  String? name;
  String? icon;
  String? createdAt;

  SubjectsEntity({this.id, this.name, this.icon, this.createdAt});

  SubjectsEntity.fromJson(Map<String, dynamic> json) {
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

  static List<SubjectsEntity> fromList(List<Map<String, dynamic>> list) {
    return list.map(SubjectsEntity.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["name"] = name;
    _data["icon"] = icon;
    _data["createdAt"] = createdAt;
    return _data;
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