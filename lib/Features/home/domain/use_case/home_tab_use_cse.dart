import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/home/domain/repository/contract/home_tab_repo.dart';
import 'package:online_exam_app/core/Error/failure.dart';

import '../entity/all_subjects_entity.dart';
@injectable
class GetAllSubjectsUseCase {
HomeTabRepoContract homeTabRepo;

GetAllSubjectsUseCase(this.homeTabRepo);
Future<Either<Failures, List<SubjectsEntity>>> invoke() async {
  var either= await homeTabRepo.getAllSubjects();
 return either.fold( (l) => Left(l), (r) {
    return Right(r);
  },);
}
}