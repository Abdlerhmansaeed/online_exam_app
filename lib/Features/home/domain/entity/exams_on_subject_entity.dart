import 'package:online_exam_app/Features/home/data/model/exams_on_subject_model.dart';

class ExamsOnSubjectEntity {
  String? id;
  String? title;
  int? duration;
  String? subject;
  int? numberOfQuestions;
  bool? active;
  String? createdAt;

  ExamsOnSubjectEntity({this.id, this.title, this.duration, this.subject, this.numberOfQuestions, this.active, this.createdAt});
 }
