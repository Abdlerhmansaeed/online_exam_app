import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/exams/data/models/check_questions_request.dart';
import 'package:online_exam_app/core/Constant/app_constant.dart';
import 'package:online_exam_app/core/services/hive_local_storage.dart';

@injectable
 class ExamLocalDataSource {
  HiveLocalStorage? hiveLocalStorage;

  ExamLocalDataSource(this.hiveLocalStorage);
  Future<void> saveAnswers(List<UserAnswers> answers) async {
   print("🔵 Saving Answers: ${answers.map((e) => "${e.questionId}: ${e.correct}").toList()}");

   var box = await Hive.openBox<List<UserAnswers>>(AppConstant.examBoxName);
   await box.put(AppConstant.examDataKey, answers);

   print("🟢 Data Saved!");
  }

  Future<List<UserAnswers>> getAnswers() async {
   var box = await Hive.openBox<List<UserAnswers>>(AppConstant.examBoxName);
   var data = box.get(AppConstant.examDataKey, defaultValue: []);

   print("🔴 Retrieved Data: $data");

   if (data is List<UserAnswers>) {
    return data;
   } else if (data is List) {
    return data??[].map((e) => e as UserAnswers).toList() ?? [];
   } else {
    return [];
   }
  }


}