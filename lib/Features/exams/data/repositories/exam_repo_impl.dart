import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/exams/data/data_sources/remote_data_source/exam_remote_data_source.dart';
import 'package:online_exam_app/Features/exams/data/models/exam_questions_response.dart';
import 'package:online_exam_app/Features/exams/domain/repositories/exam_repo.dart';
import 'package:online_exam_app/core/helper/handel_response.dart';

@Injectable(as: ExamRepo)
class ExamRepoImpl implements ExamRepo {
  final ExamRemoteDataSource examRemoteDataSource;

  ExamRepoImpl({required this.examRemoteDataSource});

  @override
  Future<Either<String, ExamQuestionsResponse>> getExamsQuestions(String? examId) async{
    var response =  await examRemoteDataSource.getExamsQuestions(examId);
    return handleResponse(response);
  }

}