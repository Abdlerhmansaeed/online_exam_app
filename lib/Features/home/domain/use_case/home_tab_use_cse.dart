import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/home/domain/entity/all_subjects_entity.dart';
import 'package:online_exam_app/Features/home/domain/repository/contract/home_tab_repo.dart';

@injectable
class GetAllSubjectsUseCase {
HomeTabRepoContract homeTabRepo;

GetAllSubjectsUseCase(this.homeTabRepo);
Future<Either<String, List<SubjectsEntity>>> invoke() async {
  var response = await homeTabRepo.getAllSubjects();
  return response;
}

}