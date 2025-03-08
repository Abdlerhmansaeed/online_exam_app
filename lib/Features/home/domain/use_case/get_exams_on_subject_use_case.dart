import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/home/data/model/get_exams_on_subject.dart';
import 'package:online_exam_app/Features/home/domain/repository/contract/home_tab_repo.dart';

@injectable
class GetExamsOnSubjectUseCase {
 final  HomeTabRepoContract _homeTabRepoContract;

  GetExamsOnSubjectUseCase(this._homeTabRepoContract,);

  Future<Either<String, GetExamsOnSubject>> invoke(String subjectId) async {
    var response = await _homeTabRepoContract.getExamsOnSubject(subjectId);
    return response;
  }
}