class SubjectsEntity {
  final String id;
  final String name;
  final String icon;
  final String createdAt;

  SubjectsEntity({
    required this.id,
    required this.name,
    required this.icon,
    required this.createdAt,
  });

  factory SubjectsEntity.fromJson(Map<String, dynamic> json) {
    return SubjectsEntity(
      id: json["_id"] ?? '',
      name: json["name"] ?? '',
      icon: json["icon"]?.toString() ?? '',
      createdAt: json["createdAt"] ?? '',
    );
  }

  static List<SubjectsEntity> fromList(List<dynamic> list) {
    return List<SubjectsEntity>.from(
      list.map((item) => SubjectsEntity.fromJson(item)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "icon": icon,
      "createdAt": createdAt,
    };
  }

  @override
  String toString() {
    return 'Subject{id: $id, name: $name}';
  }
}
