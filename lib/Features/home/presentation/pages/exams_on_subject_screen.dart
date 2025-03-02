import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/Features/home/domain/entity/all_subjects_entity.dart';
import 'package:online_exam_app/Features/home/presentation/cubit/home_cubit.dart';
import 'package:online_exam_app/Features/home/presentation/pages/instructions_screen.dart';
import 'package:online_exam_app/Features/user_results/presentation/widgets/cart_widget.dart';
import 'package:online_exam_app/core/di/di.dart';

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
                      itemCount: state.examsOnSubjectEntity.length,
                      itemBuilder: (context, index) {
                        return state.examsOnSubjectEntity==[] ?
                         const Center(child: Text('No exams found'))
                         : InkWell(
                          onTap: (){
                            Navigator.push(context, 
                            MaterialPageRoute(builder: (context) => 
                            ExamInstructionsScreen(
                              createdAt: state.examsOnSubjectEntity[index].createdAt,
                              duration: state.examsOnSubjectEntity[index].duration,
                              numberOfQuestions: state.examsOnSubjectEntity[index].numberOfQuestions,
                             subjectName: state.examsOnSubjectEntity[index].subject,
                              quizTitle: state.examsOnSubjectEntity[index].title,
                            ),)
                            );
                          },
                           child: CartWidget(
                            subjectName: args.name,quizTitle: state.examsOnSubjectEntity[index].title,
                            createdAt: state.examsOnSubjectEntity[index].createdAt,
                            duration: state.examsOnSubjectEntity[index].duration,
                            numberOfQuestions: state.examsOnSubjectEntity[index].numberOfQuestions,
                            
                                                   ),
                         );
                      },
                    );
                  } else if (state is HomeLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const Center(child: Text('Something went wrong'));
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
