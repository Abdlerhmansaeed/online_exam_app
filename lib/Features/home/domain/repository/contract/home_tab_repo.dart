import 'package:dartz/dartz.dart';
import 'package:online_exam_app/Features/home/domain/entity/all_subjects_entity.dart';

abstract class HomeTabRepoContract {
  Future<Either<String, List<SubjectsEntity>>> getAllSubjects(
      {bool forceRefresh = false});
}
