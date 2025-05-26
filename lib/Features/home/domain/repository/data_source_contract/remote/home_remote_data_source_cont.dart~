import 'package:dartz/dartz.dart';
import 'package:online_exam_app/Features/home/data/model/get_exams_on_subject.dart';
import 'package:online_exam_app/Features/home/data/model/get_subjects_response.dart';
import 'package:online_exam_app/Features/home/domain/entity/all_subjects_entity.dart';
import 'package:online_exam_app/Features/home/domain/entity/exams_on_subject_entity.dart';
import 'package:online_exam_app/core/exceptions/failure.dart';

abstract class HomRemoteDataSourceContract {
  Future<Either<Failures,GetSubjectsResponse>> getAllSubjects();
  Future<Either<Failures,GetExamsOnSubject>> getExamsOnSubject(String subjectId);

}