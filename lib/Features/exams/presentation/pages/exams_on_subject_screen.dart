import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/Features/home/domain/entity/all_subjects_entity.dart';
import 'package:online_exam_app/Features/home/presentation/cubit/home_cubit.dart';
import 'package:online_exam_app/Features/user_results/presentation/widgets/cart_widget.dart';
import 'package:online_exam_app/core/di/di.dart';

import 'instructions_screen.dart';

class ExamsOnSubjectScreen extends StatelessWidget {
  ExamsOnSubjectScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as SubjectsEntity;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
       title: Text(args.name??''),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 16.0.h),
        child: Column(
          children: [
           
            Expanded(
              child: BlocBuilder(
                bloc: getIt<HomeCubit>()..getExamsOnSubject(args.id ?? ''),
                builder: (context, state) {
                  if (state is ExamOnSubjectSuccessState) {
                    return ListView.builder(
                      itemCount: state.examsList.length,
                      itemBuilder: (context, index) {
                        return state.examsList==[] ?
                         const Center(child: Text('No exams found'))
                         : InkWell(
                          onTap: (){
                            Navigator.push(context, 
                            MaterialPageRoute(builder: (context) => 
                            ExamInstructionsScreen(
                              createdAt: state.examsList[index].createdAt,
                              duration: state.examsList[index].duration,
                              numberOfQuestions: state.examsList[index].numberOfQuestions,
                             subjectName: state.examsList[index].subject,
                              quizTitle: state.examsList[index].title,
                              examId: state.examsList[index].Id,
                            ),),
                            );
                          },
                           child: CartWidget(
                            subjectName: args.name,quizTitle: state.examsList[index].title,
                            createdAt: state.examsList[index].createdAt,
                            duration: state.examsList[index].duration,
                            numberOfQuestions: state.examsList[index].numberOfQuestions,
                            
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
