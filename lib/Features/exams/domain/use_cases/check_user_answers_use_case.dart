import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/exams/data/models/check_questions_response.dart';
import 'package:online_exam_app/Features/exams/domain/repositories/exam_repo.dart';
import '../../data/models/check_questions_request.dart';

@injectable
class CheckUserAnswersUseCase {
  final ExamRepo _examRepo;
  CheckUserAnswersUseCase(this._examRepo);
  Future<Either<String, CheckQuestionsResponse>> call(
      CheckQuestionsRequest data) async {
    var response = await _examRepo.checkAnswers(data);

    return response;
  }
}
