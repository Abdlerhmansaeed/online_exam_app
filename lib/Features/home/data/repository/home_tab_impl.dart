import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/home/domain/entity/all_subjects_entity.dart';
import 'package:online_exam_app/Features/home/domain/repository/data_source_contract/remote/home_remote_data_source_cont.dart';
import 'package:online_exam_app/Features/home/domain/repository/contract/home_tab_repo.dart';
import 'package:online_exam_app/core/helper/api_result.dart';
import 'package:online_exam_app/core/helper/handel_response.dart';

@Injectable(as: HomeTabRepoContract)
class HomeTabImpl implements HomeTabRepoContract {
  HomRemoteDataSourceContract remoteDataSourceContract;

  List<SubjectsEntity>? _cachedSubjects;
  // DateTime? _cacheTimestamp;
  // final Duration _cacheDuration = const Duration(minutes: 15);

  HomeTabImpl({
    required this.remoteDataSourceContract,
  });

  @override
  Future<ApiResult<List<SubjectsEntity>>> getAllSubjects(
      {bool forceRefresh = false}) async {
    var response = await remoteDataSourceContract.getAllSubjects();
    return handleResponse(response).map(
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
  }
}
