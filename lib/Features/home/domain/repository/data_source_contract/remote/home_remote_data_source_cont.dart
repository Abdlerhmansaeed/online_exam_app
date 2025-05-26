import 'package:dartz/dartz.dart';
import 'package:online_exam_app/Features/home/data/model/get_subjects_response.dart';
import 'package:online_exam_app/core/exceptions/failure.dart';

abstract class HomRemoteDataSourceContract {
  Future<Either<Failures,GetSubjectsResponse>> getAllSubjects();

}