import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/exams/data/models/check_questions_request.dart';
import 'package:online_exam_app/core/Constant/app_constant.dart';
import 'package:online_exam_app/core/services/hive_local_storage.dart';

@injectable
 class ExamLocalDataSource {
  HiveLocalStorage? hiveLocalStorage;

  ExamLocalDataSource(this.hiveLocalStorage);
  Future<void> saveAnswers(List<UserAnswers> answers) async{
   var data = await hiveLocalStorage?.saveData(AppConstant.examDataKey, answers, AppConstant.examBoxName);
   return data;
   }

  Future<List<UserAnswers>> getAnswers() async {
   var data = await hiveLocalStorage?.getData(AppConstant.examDataKey, AppConstant.examBoxName);

   if (data is List<UserAnswers>) {
    return data;
   } else {
    return [];
   }
  }

}