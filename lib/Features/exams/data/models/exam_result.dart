import 'package:equatable/equatable.dart';
import 'question_result.dart';

class ExamResult extends Equatable {
 final  String? examId; // Added examId for unique identification
  final String subjectName; // Added subjectName
  final String examTitle; // Added examTitle to be displayed
  final int numberOfQuestions; // Added numberOfQuestions
  final int duration; // Added duration in minutes
  final Map<String, dynamic> score;
  final List<QuestionResult> correctQuestions;
  final List<QuestionResult> wrongQuestions;
  final int timestamp;

  const ExamResult({
    required this.examId,
    required this.subjectName, // Added subjectName
    required this.examTitle, // Added examTitle
    required this.numberOfQuestions, // Added numberOfQuestions
    required this.duration, // Added duration
    required this.score,
    required this.correctQuestions,
    required this.wrongQuestions,
    required this.timestamp,
  });

  factory ExamResult.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> scoreData = json['score'] is Map
        ? Map<String, dynamic>.from(json['score'])
        : <String, dynamic>{};

    final List<QuestionResult> correctQs = [];
    if (json['correctQuestions'] is List) {
      for (var q in json['correctQuestions']) {
        if (q is Map) {
          correctQs.add(QuestionResult.fromJson(Map<String, dynamic>.from(q)));
        }
      }
    }

    final List<QuestionResult> wrongQs = [];
    final wrongQuestionsData = json['wrongQuestions'] ?? json['WrongQuestions'];
    if (wrongQuestionsData is List) {
      for (var q in wrongQuestionsData) {
        if (q is Map) {
          wrongQs.add(QuestionResult.fromJson(Map<String, dynamic>.from(q)));
        }
      }
    }

    return ExamResult(
      examId: json['examId'] ?? json['_id'], // Added examId for unique identification
      subjectName:
          json['subjectName'] ?? 'Unknown Subject', // Added subjectName
      examTitle: json['examTitle'] ?? 'Unknown Exam', // Added examTitle
      numberOfQuestions:
          json['numberOfQuestions'] ?? 0, // Added numberOfQuestions
      duration: json['duration'] ?? 0, // Added duration
      score: scoreData,
      correctQuestions: correctQs,
      wrongQuestions: wrongQs,
      timestamp: json['timestamp'] ?? DateTime.now().millisecondsSinceEpoch,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subjectName': subjectName, // Added subjectName
      'examTitle': examTitle, // Added examTitle
      'numberOfQuestions': numberOfQuestions, // Added numberOfQuestions
      'duration': duration, // Added duration
      'score': score,
      'correctQuestions': correctQuestions.map((q) => q.toJson()).toList(),
      'wrongQuestions': wrongQuestions.map((q) => q.toJson()).toList(),
      'timestamp': timestamp,
    };
  }

  @override
  List<Object?> get props => [
        subjectName, // Added subjectName
        examTitle, // Added examTitle
        numberOfQuestions, // Added numberOfQuestions
        duration, // Added duration
        score,
        correctQuestions,
        wrongQuestions,
        timestamp
      ];
}
