import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/exams/data/models/check_questions_request.dart';
import 'package:online_exam_app/core/Constant/app_keys.dart';
import '../../../../home/data/model/get_exams_on_subject.dart';
import '../../models/exam_questions_response.dart';

@LazySingleton()
class ExamLocalDataSource {
  Future<void> saveAnswers(List<UserAnswers> answers) async {
    print(
        "🔵 Saving Answers: ${answers.map((e) => "${e.questionId}: ${e.correct}").toList()}");

    var box = await Hive.openBox<List<UserAnswers>>(AppKeys.examAnswersBoxName);
    await box.put(AppKeys.examAnswersKey, answers);

    print("🟢 Data Saved!");
  }

  Future<List<UserAnswers>> getAnswers() async {
    var box = await Hive.openBox<List<UserAnswers>>(AppKeys.examAnswersBoxName);
    var data = box.get(AppKeys.examAnswersKey, defaultValue: []);

    print("🔴 Retrieved Data: $data");

    if (data is List<UserAnswers>) {
      return data;
    } else if (data is List) {
      return data ?? [].map((e) => e as UserAnswers).toList();
    } else {
      return [];
    }
  }

  Future<void> saveQuestions(List<Questions> questions) async {
    var box = await Hive.openBox<Questions>(AppKeys.questionBoxName);
   for(var question in questions){
     await box.put(question.Id, question);
     print("🟢 Data Saved! ID: ${question.Id}");
   }
   print("✅ Total questions saved in Hive: ${box.length}");
  }

  Future<List<Questions>> getQuestions() async {
    var box = await Hive.openBox<Questions>(AppKeys.questionBoxName);
    List<Questions> savedQuestions = box.values.toList();
    if (savedQuestions.isEmpty) {
      print("❌ No questions found in Hive!");
      return [];
    } else {
      print("✅ Total questions found in Hive: ${savedQuestions.length}");
      return savedQuestions;
    }
  }

  Future<void> saveExams(List<Exams> exams) async {
    var box = await Hive.openBox<Exams>(AppKeys.examBoxName);

    for (var exam in exams) {
      await box.put(exam.Id, exam);
      print("🟢 Data Saved! ID: ${exam.Id}");
    }

    print("✅ Total exams saved in Hive: ${box.length}");
  }

  Future<List<Exams>> getSavedExams() async {
    var box = await Hive.openBox<Exams>(AppKeys.examBoxName);
    List<Exams> savedExams = box.values.toList();
    if (savedExams.isEmpty) {
      print("❌ No exams found in Hive!");
      return [];
    } else {
      print("✅ Total exams found in Hive: ${savedExams.length}");
      return savedExams;
    }
  }
}
