import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/Features/auth/presentation/manager/auth_cubit.dart';
import 'package:online_exam_app/Features/auth/presentation/manager/auth_states.dart';
import 'package:online_exam_app/core/routes/app_routes.dart';
import 'package:online_exam_app/core/routes/app_routes_generator.dart';
import 'package:online_exam_app/core/theme/app_colors.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  AuthCubit authCubit = AuthCubit();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => authCubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          leading: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        body: BlocConsumer<AuthCubit, AuthStates>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              Navigator.pushReplacementNamed(context, 
              AppRoutes.homePage);
            }
            if (state is LoginLoadingState) {}
            if (state is LoginErrorState) {}
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                children: [
                  TextFormField(
                    controller: authCubit.emailController,
                    decoration: InputDecoration(
                      hintText: 'Enter Your Email',
                      labelText: ' Email',
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: authCubit.passwordController,
                    decoration: InputDecoration(
                      hintText: 'Enter Your Password',
                      labelText: 'Password',
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: false,
                        side: BorderSide(color: AppColors.gray),
                        overlayColor:
                            WidgetStatePropertyAll(Colors.transparent),
                        onChanged: (value) {},
                      ),
                      const Text('Remember me'),
                      const Spacer(),
                      TextButton(
                        style: const ButtonStyle(
                          overlayColor:
                              WidgetStatePropertyAll(Colors.transparent),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.forgotPass);
                        },
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(
                            color: AppColors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 48,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      authCubit.login();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Login"),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account?'),
                      TextButton(
                        style: const ButtonStyle(
                          overlayColor:
                              WidgetStatePropertyAll(Colors.transparent),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.signUpPage,
                              arguments: authCubit);
                        },
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                            color: AppColors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
