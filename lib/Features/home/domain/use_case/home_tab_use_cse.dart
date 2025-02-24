import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/home/domain/repository/contract/home_tab_repo.dart';
import 'package:online_exam_app/core/Error/failure.dart';

import '../entity/all_exams_entity.dart';
@injectable
class GetAllExamsUseCase {
HomeTabRepoContract homeTabRepo;

GetAllExamsUseCase(this.homeTabRepo);
Future<Either<Failures, ExamsEntity>> invoke() async {
  var either= await homeTabRepo.getAllSubjects();
 return either.fold( (l) => Left(l), (r) {
    return Right(r);
  },);
}
}