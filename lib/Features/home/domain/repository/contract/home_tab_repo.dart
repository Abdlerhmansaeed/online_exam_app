import 'package:dartz/dartz.dart';
import '../../entity/all_subjects_entity.dart';

abstract class HomeTabRepoContract {
  Future<Either<String, List<SubjectsEntity>>> getAllSubjects();

}
