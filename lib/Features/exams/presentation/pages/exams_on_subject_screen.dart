import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/Features/exams/presentation/manager/exam_veiw_model.dart';
import 'package:online_exam_app/Features/home/domain/entity/all_subjects_entity.dart';
import 'package:online_exam_app/core/di/di.dart';
import 'package:online_exam_app/core/theme/app_colors.dart';
import '../manager/exam_states.dart';
import 'instructions_screen.dart';
import 'package:online_exam_app/Features/user_results/presentation/widgets/cart_widget.dart';

class ExamsOnSubjectScreen extends StatelessWidget {
  const ExamsOnSubjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as SubjectsEntity;

    return BlocProvider(
      create: (context) {
        final cubit = getIt<ExamViewModel>();
        debugPrint(
            '🔍 ExamsOnSubjectScreen: Getting exams for subject ID: ${args.id}, Name: ${args.name}');
        cubit.getExamsOnSubject(args.id);
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          title: Text(args.name),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 16.0.h),
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<ExamViewModel, ExamStates>(
                  builder: (context, state) {
                    if (state.examOnSubjectStates == null) {

                      return Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      );
                    }

                    return state.examOnSubjectStates!.when(
                      loading: () {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        );
                      },
                      success: (data) {
                        // Check if exams list is empty or null
                        if (data.exams == null || data.exams!.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.quiz_outlined,
                                  size: 64.r,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 16.h),
                                Text(
                                  'No exams available for this subject.',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: AppColors.black,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  'Please check back later.',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: Colors.grey,
                                      ),
                                ),
                              ],
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: data.exams!.length,
                          itemBuilder: (context, index) {
                            final exam = data.exams![index];
                            return InkWell(
                              onTap: () {
                                if (exam.id != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ExamInstructionsScreen(
                                        createdAt: exam.createdAt ?? '',
                                        duration: exam.duration ?? 0,
                                        numberOfQuestions:
                                            exam.numberOfQuestions ?? 0,
                                        subjectName: args
                                            .name, // Use the subject name from args
                                        quizTitle: exam.title ?? '',
                                        examId: exam.id ?? '',
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: CartWidget(
                                subjectName: args.name,
                                quizTitle: exam.title,
                                createdAt: exam.createdAt,
                                duration: exam.duration,
                                numberOfQuestions: exam.numberOfQuestions,
                              ),
                            );
                          },
                        );
                      },
                      error: (error) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: 64.r,
                                color: Colors.red,
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                'Error loading exams',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: Colors.red),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                error ?? 'Unknown error occurred',
                                style: Theme.of(context).textTheme.bodyMedium,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 16.h),
                              ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<ExamViewModel>()
                                      .getExamsOnSubject(args.id);
                                },
                                child: const Text('Try Again'),
                              ),
                            ],
                          ),
                        );
                      },
                      initial: () {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
