import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/home/domain/entity/all_subjects_entity.dart';
import 'package:online_exam_app/Features/home/domain/entity/exams_on_subject_entity.dart';
import 'package:online_exam_app/core/Error/failure.dart';
abstract class HomeTabRepoContract {
  Future<Either<Failures,List< SubjectsEntity>>> getAllSubjects();
  Future<Either<Failures,List<ExamsOnSubjectEntity>>> getExamsOnSubject(String subjectId);
  
}