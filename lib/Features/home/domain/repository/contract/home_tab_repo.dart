import 'package:dartz/dartz.dart';
import 'package:online_exam_app/Features/home/data/model/get_exams_on_subject.dart';
import '../../entity/all_subjects_entity.dart';

abstract class HomeTabRepoContract {
  Future<Either<String, List<SubjectsEntity>>> getAllSubjects();
  Future<Either<String, GetExamsOnSubject>> getExamsOnSubject(
      String subjectId);
}
