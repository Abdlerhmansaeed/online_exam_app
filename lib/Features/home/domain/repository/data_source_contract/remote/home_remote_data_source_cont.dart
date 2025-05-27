import 'package:online_exam_app/Features/home/data/model/get_subjects_response.dart';
import 'package:online_exam_app/core/helper/api_result.dart';

abstract class HomRemoteDataSourceContract {
   Future<ApiResult <GetSubjectsResponse>> getAllSubjects();

}