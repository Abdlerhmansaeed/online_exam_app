// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/home/data/model/subjects_model.dart';
import 'package:online_exam_app/Features/home/domain/entity/all_subjects_entity.dart';
import 'package:online_exam_app/Features/home/domain/entity/exams_on_subject_entity.dart';
import 'package:online_exam_app/Features/home/domain/repository/data_source_contract/remote/hom_remote_data_source_cont.dart';
import 'package:online_exam_app/Features/home/domain/repository/contract/home_tab_repo.dart';
import 'package:online_exam_app/core/Error/failure.dart';
@Injectable(as: HomeTabRepoContract)
class HomeTabImpl implements HomeTabRepoContract {
HomRemoteDataSourceContract remoteDataSourceContract;
  HomeTabImpl({
    required this.remoteDataSourceContract,
  });
  
  @override
  Future<Either<Failures,List <SubjectsEntity>>> getAllSubjects() async {
    return await remoteDataSourceContract.getAllSubjects();
  }

  @override
  Future<Either<Failures, List<ExamsOnSubjectEntity>>> getExamsOnSubject(String subjectId) async {
   return await remoteDataSourceContract.getExamsOnSubject(subjectId);
  }
}