import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/home/domain/entity/all_subjects_entity.dart';
import 'package:online_exam_app/Features/home/domain/repository/data_source_contract/remote/hom_remote_data_source_cont.dart';
import 'package:online_exam_app/core/Error/failure.dart';
import 'package:online_exam_app/core/di/di.dart';
import 'package:online_exam_app/core/services/api_manager.dart';

@Injectable(as: HomRemoteDataSourceContract)
class HomeTabRemoteImpl implements HomRemoteDataSourceContract {

  @override
  Future<Either<Failures, List<SubjectsEntity>>> getAllSubjects() async {
    final either=  await getIt<ApiManager>().getAllSubjects();
    return either.fold((l) => Left(l), (r) => Right(r));
  }
 
}
