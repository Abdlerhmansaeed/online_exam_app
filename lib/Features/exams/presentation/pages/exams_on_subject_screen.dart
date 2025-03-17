import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/Features/exams/presentation/manager/exam_veiw_model.dart';
import 'package:online_exam_app/Features/home/data/model/get_exams_on_subject.dart';
import 'package:online_exam_app/Features/home/domain/entity/all_subjects_entity.dart';
import 'package:online_exam_app/Features/home/presentation/cubit/home_cubit.dart';
import 'package:online_exam_app/Features/user_results/presentation/widgets/cart_widget.dart';
import 'package:online_exam_app/core/base_states/base_states.dart';
import 'package:online_exam_app/core/di/di.dart';
import '../manager/exam_veiw_states.dart';
import 'instructions_screen.dart';

class ExamsOnSubjectScreen extends StatelessWidget {
  const ExamsOnSubjectScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as SubjectsEntity;

    return Scaffold(
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
                bloc: getIt<ExamViewModel>()..getExamsOnSubject(args.id),
                builder: (context, state) {
                  if (state.examOnSubjectStates is SuccessState<GetExamsOnSubject>) {
                    var data = (state.examOnSubjectStates as SuccessState<GetExamsOnSubject>).data;
                    return ListView.builder(
                      itemCount:data?.exams?.length ,
                      itemBuilder: (context, index) {
                        return data?.exams?.isEmpty ?? true ?
                         const Center(child: Text('No exams found'))
                         : InkWell(
                          onTap: (){
                            Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>
                            ExamInstructionsScreen(
                              createdAt: data?.exams?[index].createdAt,
                              duration:data?.exams?[index].duration,
                              numberOfQuestions: data?.exams?[index].numberOfQuestions,
                             subjectName: data?.exams?[index].subject,
                              quizTitle: data?.exams?[index].title,
                              examId: data?.exams?[index].Id,
                            ),),
                            );
                          },
                           child: CartWidget(
                            subjectName: args.name,quizTitle: data?.exams?[index].title,
                            createdAt: data?.exams?[index].createdAt,
                            duration: data?.exams?[index].duration,
                            numberOfQuestions: data?.exams?[index].numberOfQuestions,

                                                   ),
                         );
                      },
                    );
                  } else if (state is HomeLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const Center(child: Text('No exams found'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
