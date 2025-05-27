import 'package:online_exam_app/Features/home/domain/entity/all_subjects_entity.dart';
import 'package:online_exam_app/core/helper/api_result.dart';

abstract class HomeTabRepoContract {
  Future<ApiResult<List<SubjectsEntity>>> getAllSubjects(
      {bool forceRefresh = false});
}
