import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/Features/exams/presentation/manager/exam_veiw_model.dart';
import 'package:online_exam_app/Features/exams/presentation/manager/exam_states.dart';
import 'package:online_exam_app/core/di/di.dart';
import 'package:online_exam_app/core/routes/app_routes.dart';
import 'package:online_exam_app/core/theme/app_colors.dart';
import '../widgets/exam_content.dart';

class ExamScreen extends StatefulWidget {
  final int? duration;
  final String examId;
  final String? examTitle; 
  final String? subjectName; 
  final int? numberOfQuestions; 
  final int? examDuration; 

  const ExamScreen({
    super.key,
    this.duration,
    required this.examId,
    this.examTitle, 
    this.subjectName, 
    this.numberOfQuestions, 
    this.examDuration, 
  });

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {

  @override
  void initState() {
    super.initState();
    final examViewModel = getIt<ExamViewModel>();
    if (widget.duration != null) {
      examViewModel.timerController(widget.duration!.toDouble());
    }
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
        ..timerController(widget.duration?.toDouble() ?? 0)
        ..setCurrentExamMetadata(
            examId: widget.examId,
            examTitle: widget.examTitle ?? '',
            subjectName: widget.subjectName ?? '',
            numberOfQuestions: widget.numberOfQuestions ?? 0,
            duration: widget.examDuration ?? 0),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Exam"),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          actions: [
            Image.asset('assets/images/alarm.png'),
            ValueListenableBuilder<int>(
              valueListenable: examViewModel.examDurationNotifier,
              builder: (context, duration, _) {
                final minutes = (duration ~/ 60).toString().padLeft(2, '0');
                final seconds = (duration % 60).toString().padLeft(2, '0');

                return Container(
                  margin: EdgeInsets.all(10.r),
                  child: Text(
                    '$minutes : $seconds',
                    style: TextStyle(
                      color: examViewModel.isDangerTimeNotifier.value
                          ? AppColors.red
                          : AppColors.green,
                      fontSize: 20.sp,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: BlocConsumer<ExamViewModel, ExamStates>(
          listenWhen: (previous, current) =>
              current.examTimeOutState != previous.examTimeOutState,
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
                            onPressed: () {
                              Navigator.pop(context);
                              examViewModel.navigateToRoute(
                                routeName: AppRoutes.examScoreScreen,
                                context: context,
                                arguments: examViewModel,
                              );
                            },
                            child: const Text("View score"),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
          builder: (context, state) {
            return state.examStates.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              success: (data) => ExamContentScreen(
                  examData: data, examViewModel: examViewModel),
              error: (error) {
                return Center(
                  child: Text(
                    error ?? "Error occurred",
                    style: theme.textTheme.titleLarge,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
