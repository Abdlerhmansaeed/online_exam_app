// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/home/domain/entity/exams_on_subject_entity.dart';

import 'package:online_exam_app/Features/home/domain/repository/contract/home_tab_repo.dart';
import 'package:online_exam_app/core/Error/failure.dart';

@injectable
class GetExamsOnSubjectUseCase {
  HomeTabRepoContract homeTabRepoContract;
  GetExamsOnSubjectUseCase({
    required this.homeTabRepoContract,
  });
 Future<Either<Failures, List<ExamsOnSubjectEntity>>> invoke(String subjectId) async {
   var either= await homeTabRepoContract.getExamsOnSubject(subjectId);
    return either.fold((l) => Left(l), (r) => Right(r));
  }
}
