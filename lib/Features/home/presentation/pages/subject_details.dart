
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/Features/home/domain/entity/all_subjects_entity.dart';
import 'package:online_exam_app/Features/home/presentation/cubit/home_cubit.dart';
import 'package:online_exam_app/Features/home/presentation/widgets/subject_item.dart';
import 'package:online_exam_app/core/di/di.dart';
import '../../../../core/helper/spacing.dart';

class SubjectDetails extends StatelessWidget {
  SubjectDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as SubjectsEntity;
    print("==========${args.id}");
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(args.name ?? ''),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 16.0.h),
        child: Column(
          children: [
            verticalSpace(40),
            Text(
              args.name ?? '',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            verticalSpace(20),
            Expanded(
              child: BlocBuilder(
                bloc: getIt<HomeCubit>()..getExamsOnSubject(args.id ?? ''),
                builder: (context, state) {
                  if (state is ExamOnSubjectSuccessState) {
                    return ListView.builder(
                      itemCount: state.examsOnSubjectEntity.length,
                      itemBuilder: (context, index) {
                        return SubjectAndExamItem(
                          imageUrl: args.icon??'',
                          name: state.examsOnSubjectEntity[index].title ?? '',
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
