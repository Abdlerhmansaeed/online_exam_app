import 'package:equatable/equatable.dart';
import 'package:online_exam_app/Features/home/data/model/get_exams_on_subject.dart';
import 'user_answer.dart';

class ExamAnswersModel extends Equatable {
  final Exams exam;
  final Map<String, Map<String, dynamic>> questionsMap;
  final Map<String, String> userAnswersMap;
  final List<UserAnswer> userAnswers;

  const ExamAnswersModel({
    required this.exam,
    required this.questionsMap,
    required this.userAnswersMap,
    required this.userAnswers,
  });

  @override
  List<Object?> get props => [exam, questionsMap, userAnswersMap, userAnswers];
}
