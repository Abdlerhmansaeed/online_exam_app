import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/home/data/model/get_exams_on_subject.dart';
import '../repositories/exam_repo.dart';

@injectable
class GetExamsOnSubjectUseCase {
  final ExamRepo _examRepo;

  GetExamsOnSubjectUseCase(this._examRepo,);

  Future<Either<String, GetExamsOnSubject>> invoke(String subjectId) async {
    var response = await _examRepo.getExamsOnSubject(subjectId);
    return response;
  }
}