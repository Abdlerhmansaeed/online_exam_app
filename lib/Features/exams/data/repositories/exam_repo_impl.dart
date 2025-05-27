import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/exams/data/data_sources/remote_data_source/exam_remote_data_source.dart';
import 'package:online_exam_app/Features/exams/data/models/check_questions_request.dart';
import 'package:online_exam_app/Features/exams/data/models/check_questions_response.dart';
import 'package:online_exam_app/Features/exams/data/models/exam_questions_response.dart';
import 'package:online_exam_app/Features/exams/domain/repositories/exam_repo.dart';
import 'package:online_exam_app/core/helper/api_result.dart';
import 'package:online_exam_app/core/helper/handel_response.dart';

import '../../../home/data/model/get_exams_on_subject.dart';

@Injectable(as: ExamRepo)
class ExamRepoImpl implements ExamRepo {
  final ExamRemoteDataSource examRemoteDataSource;

  ExamRepoImpl({required this.examRemoteDataSource});


  @override
  Future<ApiResult<GetExamsOnSubject>> getExamsOnSubject(
      String subjectId) async {
    var response = await examRemoteDataSource.getExamsOnSubject(subjectId);
    return handleResponse(response);
  }

  @override
  Future<ApiResult< ExamQuestionsResponse>> getExamsQuestions(String? examId) async{
    var response =  await examRemoteDataSource.getExamsQuestions(examId);
    return handleResponse(response);
  }

  @override
  Future<ApiResult< CheckQuestionsResponse>> checkAnswers(CheckQuestionsRequest data) async{
   var response =  await examRemoteDataSource.checkAnswers(data);
    return handleResponse(response);
  }



}