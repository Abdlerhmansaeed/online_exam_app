import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/home/domain/entity/all_subjects_entity.dart';
import 'package:online_exam_app/Features/home/domain/repository/data_source_contract/remote/home_remote_data_source_cont.dart';
import 'package:online_exam_app/Features/home/domain/repository/contract/home_tab_repo.dart';
import 'package:online_exam_app/core/helper/handel_response.dart';

@Injectable(as: HomeTabRepoContract)
class HomeTabImpl implements HomeTabRepoContract {
  HomRemoteDataSourceContract remoteDataSourceContract;

  List<SubjectsEntity>? _cachedSubjects;
  DateTime? _cacheTimestamp;
  final Duration _cacheDuration = const Duration(minutes: 15);

  HomeTabImpl({
    required this.remoteDataSourceContract,
  });

  @override
  Future<Either<String, List<SubjectsEntity>>> getAllSubjects(
      {bool forceRefresh = false}) async {
    if (!forceRefresh && _cachedSubjects != null && _isCacheValid()) {
      debugPrint('🔵 Using Data From (${_cachedSubjects!.length})');
      return Right(_cachedSubjects!);
    }

    try {
      debugPrint('🔄 getting data from api...');
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

      // معالجة النتيجة من API
      final result = handleResponse(data);

      result.fold((error) {
        if (_cachedSubjects != null) {
          print('⚠️ Error occurred, using cached data');
          return;
        }
      }, (subjects) {
        _cachedSubjects = subjects;
        _cacheTimestamp = DateTime.now();
        print('✅ Data Fetched(${subjects.length} )');
      });

      return result;
    } catch (e) {
      if (_cachedSubjects != null) {
        debugPrint('⚠️Error occurred, using cached data');
        return Right(_cachedSubjects!);
      }
      return Left('Error:${e.toString()}');
    }
  }

  bool _isCacheValid() {
    if (_cacheTimestamp == null) return false;
    return DateTime.now().difference(_cacheTimestamp!) < _cacheDuration;
  }

  void clearCache() {
    _cachedSubjects = null;
    _cacheTimestamp = null;
    debugPrint('🧹 Cache Cleared');
  }
}
