import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/exams/data/data_sources/local_data_source/exam_local_data_base.dart';

import '../../../home/data/model/get_exams_on_subject.dart';

@injectable
class UserResultsDataSource {
  ExamLocalDataSource ? examLocalDataSource;

  UserResultsDataSource(this.examLocalDataSource);

  Future<List<Exams>> getSavedExams() async {
    return await examLocalDataSource?.getSavedExams() ?? [];
  }
}