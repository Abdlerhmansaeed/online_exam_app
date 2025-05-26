// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_exams_on_subject.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExamsAdapter extends TypeAdapter<Exams> {
  @override
  final int typeId = 1;

  @override
  Exams read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Exams(
      id: fields[0] as String?,
      title: fields[1] as String?,
      duration: fields[2] as int?,
      subject: fields[3] as String?,
      numberOfQuestions: fields[4] as int?,
      active: fields[5] as bool?,
      createdAt: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Exams obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.duration)
      ..writeByte(3)
      ..write(obj.subject)
      ..writeByte(4)
      ..write(obj.numberOfQuestions)
      ..writeByte(5)
      ..write(obj.active)
      ..writeByte(6)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExamsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetExamsOnSubject _$GetExamsOnSubjectFromJson(Map<String, dynamic> json) =>
    GetExamsOnSubject(
      message: json['message'] as String?,
      metadata: json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      exams: (json['exams'] as List<dynamic>?)
          ?.map((e) => Exams.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetExamsOnSubjectToJson(GetExamsOnSubject instance) =>
    <String, dynamic>{
      'message': instance.message,
      'metadata': instance.metadata,
      'exams': instance.exams,
    };

Metadata _$MetadataFromJson(Map<String, dynamic> json) => Metadata(
      currentPage: (json['currentPage'] as num?)?.toInt(),
      numberOfPages: (json['numberOfPages'] as num?)?.toInt(),
      limit: (json['limit'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MetadataToJson(Metadata instance) => <String, dynamic>{
      'currentPage': instance.currentPage,
      'numberOfPages': instance.numberOfPages,
      'limit': instance.limit,
    };

Exams _$ExamsFromJson(Map<String, dynamic> json) => Exams(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      duration: (json['duration'] as num?)?.toInt(),
      subject: json['subject'] as String?,
      numberOfQuestions: (json['numberOfQuestions'] as num?)?.toInt(),
      active: json['active'] as bool?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$ExamsToJson(Exams instance) => <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'duration': instance.duration,
      'subject': instance.subject,
      'numberOfQuestions': instance.numberOfQuestions,
      'active': instance.active,
      'createdAt': instance.createdAt,
    };
