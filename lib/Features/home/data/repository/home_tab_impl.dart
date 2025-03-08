import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/home/data/model/get_exams_on_subject.dart';
import 'package:online_exam_app/Features/home/domain/entity/all_subjects_entity.dart';
import 'package:online_exam_app/Features/home/domain/repository/data_source_contract/remote/home_remote_data_source_cont.dart';
import 'package:online_exam_app/Features/home/domain/repository/contract/home_tab_repo.dart';
import 'package:online_exam_app/core/helper/handel_response.dart';

@Injectable(as: HomeTabRepoContract)
class HomeTabImpl implements HomeTabRepoContract {
  HomRemoteDataSourceContract remoteDataSourceContract;
  HomeTabImpl({
    required this.remoteDataSourceContract,
  });

  @override
  Future<Either<String, GetExamsOnSubject>> getExamsOnSubject(
      String subjectId) async {
    var response = await remoteDataSourceContract.getExamsOnSubject(subjectId);
    return handleResponse(response);
  }

  @override
  Future<Either<String, List<SubjectsEntity>>> getAllSubjects() async {
    var response = await remoteDataSourceContract.getAllSubjects();

    var data = response.map(
      (data) =>
          data.subjects?.map(
            (subjects) {
              return SubjectsEntity(
                id: subjects.Id ?? '',
                name: subjects.name ?? '',
                icon: subjects.icon ?? '',
                createdAt: subjects.createdAt ?? '',
              );
            },
          ).toList() ??
          [],
    );
    return handleResponse(data);
  }
}