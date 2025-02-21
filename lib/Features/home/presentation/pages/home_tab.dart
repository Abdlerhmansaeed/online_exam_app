import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/Features/home/presentation/cubit/home_cubit.dart';
import 'package:online_exam_app/Features/home/presentation/widgets/build_bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(body: Container(color: Colors.yellow,));

  }
}
