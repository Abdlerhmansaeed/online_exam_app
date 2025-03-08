import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/Features/exams/data/models/exam_questions_response.dart';
import 'package:online_exam_app/Features/exams/presentation/manager/exam_veiw_model.dart';
import 'package:online_exam_app/Features/exams/presentation/manager/exam_veiw_states.dart';
import 'package:online_exam_app/core/base_states/base_states.dart';
import 'package:online_exam_app/core/di/di.dart';
import 'package:online_exam_app/core/routes/app_routes.dart';
import 'package:online_exam_app/core/theme/app_colors.dart';
import '../widgets/exam_content.dart';

class ExamScreen extends StatefulWidget {
  final String? examId;
  final int? duration;
  const ExamScreen({super.key, this.examId, this.duration});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  @override
  void initState() {
    super.initState();
    final examViewModel = getIt<ExamViewModel>();
    examViewModel.timerController(widget.duration!.toDouble());
  }

  @override
  void dispose() {
    final examViewModel = getIt<ExamViewModel>();
    examViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ExamViewModel examViewModel = getIt<ExamViewModel>();
    var theme = Theme.of(context);
    return BlocProvider.value(
      value: examViewModel
        ..getExamQuestions(widget.examId)
        ..timerController(widget.duration!.toDouble()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Exam"),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          actions: [
            Image.asset('assets/images/alarm.png'),
            BlocBuilder<ExamViewModel, ExamStates>(
              bloc: examViewModel,
              buildWhen: (previous, current) {
                return current.examDuration != previous.examDuration;
              },
              builder: (context, state) {
                final remainingTime = state.examDuration ?? 0;
                final minutes =
                    (remainingTime ~/ 60).toString().padLeft(2, '0');
                final seconds = (remainingTime % 60).toString().padLeft(2, '0');

                return Container(
                  margin: EdgeInsets.all(10.r),
                  child: Text(
                    '${minutes} : ${seconds}',
                    style: TextStyle(
                      color: AppColors.green,
                      fontSize: 20.sp,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: BlocConsumer<ExamViewModel, ExamStates>(
          listener: (context, state) {
            if (state.examTimeOutState ?? false) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: SizedBox(
                      height: 230.h,
                      width: 289.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/sand-clock.png'),
                              Text(
                                "Time out !!",
                                style: theme.textTheme.bodyLarge!.copyWith(
                                  color: AppColors.red,
                                  fontSize: 30.sp,
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              padding: WidgetStatePropertyAll(EdgeInsets.symmetric(
                              vertical: 8.w, horizontal: 50.h),)

                            ),
                              onPressed: () {
                              examViewModel.navigateToRoute(AppRoutes.examScoreScreen, context);
                              }, child: Text("View score"))
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
          listenWhen: (previous, current) {
            return current.examTimeOutState != previous.examTimeOutState;
          },
          builder: (context, state) {
            if (state.examStates is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.examStates is ErrorState) {
              return Center(
                child: Text(
                    (state.examStates as ErrorState).error ?? "Error occurred"),
              );
            }

            if (state.examStates is SuccessState<ExamQuestionsResponse>) {
              final examData =
                  (state.examStates as SuccessState<ExamQuestionsResponse>)
                      .data;
              return examData?.questions?.isEmpty ?? true
                  ? const Center(child: Text("No Questions Found"))
                  : buildExamContent(context, examData, examViewModel);
            }

            return const SizedBox(); // Default empty state
          },
        ),
      ),
    );
  }
}
