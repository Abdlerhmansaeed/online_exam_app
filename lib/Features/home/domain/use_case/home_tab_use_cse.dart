import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/home/domain/entity/all_subjects_entity.dart';
import 'package:online_exam_app/Features/home/domain/repository/contract/home_tab_repo.dart';

@injectable
class GetAllSubjectsUseCase {
  final HomeTabRepoContract _homeTabRepository;

  GetAllSubjectsUseCase(this._homeTabRepository);

  Future<Either<String, List<SubjectsEntity>>> invoke(
      {bool forceRefresh = false}) {
    return _homeTabRepository.getAllSubjects(forceRefresh: forceRefresh);
  }
}
