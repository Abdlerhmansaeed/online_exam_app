import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/exams/data/models/exam_questions_response.dart';
import 'package:online_exam_app/Features/exams/domain/repositories/exam_repo.dart';

@injectable
class ExamQuestionsUseCase {
  final ExamRepo _examRepo;
  ExamQuestionsUseCase(this._examRepo);
  Future<Either<String, ExamQuestionsResponse>> call(String? examId) async {
    var response = await _examRepo.getExamsQuestions(examId);
     return response;
  }
}
