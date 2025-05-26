import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/exams/data/data_sources/local_data_source/exam_local_data_base_contract.dart';
import 'package:online_exam_app/core/Constant/app_keys.dart';
import '../../models/exam_result.dart';
import '../../models/user_answer.dart';
import '../../models/exam_questions_response.dart';

@LazySingleton(as : ExamLocalDataBaseContract)
class ExamLocalDataSource implements ExamLocalDataBaseContract {
  // Safe box getter
  Future<Box<dynamic>> _getSafeBox() async {
    try {
      if (Hive.isBoxOpen(AppKeys.examAnswersBoxName)) {
        return Hive.box(AppKeys.examAnswersBoxName);
      } else {
        return await Hive.openBox(AppKeys.examAnswersBoxName);
      }
    } catch (e) {
      debugPrint('🔴 Error opening Hive box: $e');
      return await Hive.openBox('temporary_answers_box');
    }
  }

  @override
  Future<void> addExamResultToList(ExamResult examResult) async {
    try {
      var box = await _getSafeBox();
      // Get existing list or create a new one
      List<dynamic> resultsListDynamic =
          box.get('all_exam_results_list', defaultValue: <dynamic>[])
              as List<dynamic>;

      // Convert dynamic list to List<Map<String, dynamic>>
      List<Map<String, dynamic>> resultsListMap = resultsListDynamic
          .where((item) => item is Map)
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList();

      // Add the new result (as JSON)
      resultsListMap.add(examResult.toJson());

      await box.put('all_exam_results_list', resultsListMap);
      debugPrint(
          '✅ Exam result added to list. Total results: ${resultsListMap.length}');
    } catch (e) {
      debugPrint('🔴 Error adding exam result to list: $e');
    }
  }

  // UPDATED: saveExamResultModel now calls addExamResultToList
  @override
  Future<void> saveExamResultModel(ExamResult examResult) async {
    await addExamResultToList(examResult);
  }

  // UPDATED: saveExamResults (legacy) now calls addExamResultToList
  Future<void> saveExamResults(Map<String, dynamic> resultsData) async {
    try {
      final examResult = ExamResult.fromJson(resultsData);
      await addExamResultToList(examResult); // Use the new method
      debugPrint('✅ Exam results saved via legacy method to list');
    } catch (e) {
      debugPrint('🔴 Error in legacy saveExamResults (adding to list): $e');
      // Fallback might be tricky here if you want a list.
      // For now, this fallback will overwrite if it happens.
      var box = await _getSafeBox();
      await box.put('latest_exam_results_fallback_single', resultsData);
    }
  }

  // NEW METHOD: Get ALL exam results as a List<ExamResult>
  @override
  Future<List<ExamResult>> getAllExamResultsAsModel() async {
    try {
      var box = await _getSafeBox();
      final data = box.get('all_exam_results_list', defaultValue: <dynamic>[]);

      if (data is List) {
        return data
            .where((item) => item is Map) // Ensure item is a map
            .map((item) =>
                ExamResult.fromJson(Map<String, dynamic>.from(item as Map)))
            .toList()
            .reversed // Optional: show latest first
            .toList();
      }
      return [];
    } catch (e) {
      debugPrint('🔴 Error getting all exam results as model list: $e');
      return [];
    }
  }

  // UPDATED: getExamResultsAsModel (singular) can now be a utility or fetch the very latest if needed
  // For now, let's keep it fetching the "latest_exam_results" key if it exists for any other purpose,
  // but the main logic for the results page will use getAllExamResultsAsModel.
  @override
  Future<ExamResult?> getExamResultsAsModel() async {
    // This might be used for a "last exam summary" elsewhere
    try {
      var box = await _getSafeBox();
      // Attempt to get the single "latest" if it's still being saved by some old path
      final data = box.get('latest_exam_results');
      if (data is Map) {
        return ExamResult.fromJson(Map<String, dynamic>.from(data));
      }
      // If not found, try to get the first from the list as "latest"
      final allResults = await getAllExamResultsAsModel();
      return allResults.isNotEmpty ? allResults.first : null;
    } catch (e) {
      debugPrint('🔴 Error getting single/latest exam result as model: $e');
      return null;
    }
  }

  @override
  Future<void> saveUserAnswers(List<UserAnswer> userAnswers) async {
    try {
      var box = await _getSafeBox();
      final answersJson = userAnswers.map((answer) => answer.toJson()).toList();
      await box.put('user_answers', answersJson);
      debugPrint('✅ Saved ${userAnswers.length} user answers using model');
    } catch (e) {
      debugPrint('🔴 Error saving user answers: $e');
    }
  }

  @override
  Future<List<UserAnswer>> getUserAnswers() async {
    try {
      var box = await _getSafeBox();
      final data = box.get('user_answers', defaultValue: []);

      List<UserAnswer> answers = [];
      if (data is List) {
        for (var item in data) {
          if (item is Map) {
            answers.add(
                UserAnswer.fromJson(Map<String, dynamic>.from(item as Map)));
          }
        }
      }
      debugPrint('✅ Retrieved ${answers.length} user answers as models');
      return answers;
    } catch (e) {
      debugPrint('🔴 Error getting user answers: $e');
      return [];
    }
  }

  @override
  Future<void> saveAnswer(UserAnswer userAnswer) async {
    try {
      var box = await _getSafeBox();

      List<UserAnswer> existingAnswers = await getUserAnswers();

      existingAnswers.removeWhere((a) => a.questionId == userAnswer.questionId);

      existingAnswers.add(userAnswer);

      await saveUserAnswers(existingAnswers);

      debugPrint(
          '✅ Answer saved using model: ${userAnswer.questionId} = ${userAnswer.answerId}');
    } catch (e) {
      debugPrint('🔴 Error saving answer: $e');
    }
  }

  @override
  Future<void> saveUserAnswersMap(Map<String, String> answersMap) async {
    try {
      List<UserAnswer> userAnswers = [];
      answersMap.forEach((questionId, answerId) {
        userAnswers.add(UserAnswer(
          questionId: questionId,
          answerId: answerId,
        ));
      });

      await saveUserAnswers(userAnswers);
      debugPrint('✅ Saved ${answersMap.length} user answers from map');
    } catch (e) {
      debugPrint('🔴 Error saving user answers map: $e');

      // Fallback to legacy storage
      var box = await _getSafeBox();
      await box.put('user_answers_map', answersMap);
    }
  }

  @override
  Future<Map<String, String>> getUserAnswersMap() async {
    try {
      List<UserAnswer> userAnswers = await getUserAnswers();
      Map<String, String> answersMap = {};

      for (var answer in userAnswers) {
        answersMap[answer.questionId] = answer.answerId;
      }

      debugPrint('✅ Retrieved ${answersMap.length} user answers as map');
      return answersMap;
    } catch (e) {
      debugPrint('🔴 Error converting user answers to map: $e');

      // Fallback to legacy retrieval
      var box = await _getSafeBox();
      final data = box.get('user_answers_map', defaultValue: {});

      if (data is Map) {
        return Map<String, String>.from(data);
      }
      return {};
    }
  }

  @override
  Future<void> saveCachedApiResponse(Map<String, dynamic> response) async {
    try {
      var box = await _getSafeBox();
      await box.put('api_response_cache', response);

      // Also convert and save as ExamResult for consistency
      try {
        final examResult = ExamResult.fromJson(response);
        await saveExamResultModel(examResult);
      } catch (e) {
        debugPrint('⚠️ Could not convert API response to ExamResult: $e');
      }

      debugPrint('✅ API response cached successfully');
    } catch (e) {
      debugPrint('🔴 Error caching API response: $e');
    }
  }

  @override
  Future<Map<String, dynamic>?> getCachedApiResponse() async {
    try {
      var box = await _getSafeBox();
      final data = box.get('api_response_cache');

      if (data is Map) {
        return Map<String, dynamic>.from(data);
      }
      return null;
    } catch (e) {
      debugPrint('🔴 Error retrieving API cache: $e');
      return null;
    }
  }

  @override
  Future<void> saveQuestionsAsMap(List<Questions> questions) async {
    try {
      final questionsMap = <String, Map<String, dynamic>>{};
      for (var q in questions) {
        if (q.Id != null) {
          final qJson = q.toJson();
          if (qJson['answers'] is List) {
            qJson['answers'] = (qJson['answers'] as List)
                .map((a) => a is Map ? a : (a as dynamic).toJson())
                .toList();
          }
          if (qJson['subject'] != null && qJson['subject'] is! Map) {
            qJson['subject'] = (qJson['subject'] as dynamic).toJson();
          }
          if (qJson['exam'] != null && qJson['exam'] is! Map) {
            qJson['exam'] = (qJson['exam'] as dynamic).toJson();
          }
          questionsMap[q.Id!] = qJson;
        }
      }
      await (await _getSafeBox()).put('questions_map', questionsMap);
      debugPrint('✅ Saved ${questions.length} questions as map');
    } catch (e) {
      debugPrint('🔴 Error saving questions as map: $e');
    }
  }

  @override
  Future<Map<String, Map<String, dynamic>>> getQuestionsAsMap() async {
    try {
      var box = await _getSafeBox();
      final data = box.get('questions_map', defaultValue: {});
      if (data is Map) {
        return data.map((key, value) => MapEntry(key.toString(),
            value is Map ? Map<String, dynamic>.from(value) : {}));
      }
      return {};
    } catch (e) {
      debugPrint('🔴 Error getting questions as map: $e');
      return {};
    }
  }
}
