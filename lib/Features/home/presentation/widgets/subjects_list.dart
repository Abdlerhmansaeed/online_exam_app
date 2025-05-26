import 'package:flutter/material.dart';
import 'package:online_exam_app/Features/home/presentation/widgets/subject_item.dart';

import '../../../../core/routes/app_routes.dart';

class SubjectAnimatedList extends StatelessWidget {
  final GlobalKey<AnimatedListState> listKey;
  final List<dynamic> subjects;

  const SubjectAnimatedList({
    super.key,
    required this.listKey,
    required this.subjects,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: listKey,
      initialItemCount: subjects.length,
      itemBuilder: (context, index, animation) {
        final subject = subjects[index];
        return _buildAnimatedItem(context, subject, animation, index);
      },
    );
  }

  Widget _buildAnimatedItem(
      BuildContext context, dynamic subject, Animation<double> animation, int index) {
    return FadeTransition(
      opacity: animation.drive(CurveTween(curve: Curves.easeInOut)),
      child: SlideTransition(
        position: animation.drive(
          Tween<Offset>(
            begin: const Offset(0.5, 0),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeInOut)),
        ),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.subjectDetails,
              arguments: subject,
            );
          },
          child: SubjectItem(
            imageUrl: subject.icon ?? 'default_icon_url',
            name: subject.name ?? 'Unnamed Subject',
          ),
        ),
      ),
    );
  }
}