import 'package:dartz/dartz.dart';
import 'package:online_exam_app/Features/home/domain/entity/all_exams_entity.dart';
import 'package:online_exam_app/core/Error/failure.dart';

abstract class HomRemoteDataSourceContract {
  Future<Either<Failures, ExamsEntity>> getAllExams();
}