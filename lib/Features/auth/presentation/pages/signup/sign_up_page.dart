import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/Features/auth/presentation/manager/auth_cubit.dart';
import 'package:online_exam_app/Features/auth/presentation/manager/auth_states.dart';
import 'package:online_exam_app/core/routes/app_routes.dart';
import 'package:online_exam_app/core/theme/app_colors.dart';

class SignUpPage extends StatelessWidget {
  final AuthCubit authCubit;

  const SignUpPage({super.key, required this.authCubit});
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: authCubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        body: BlocConsumer<AuthCubit, AuthStates>(
          listener: (context, state) {
            if (state is SignupSuccessState) {
              Navigator.pushReplacementNamed(context, AppRoutes.homePage);
            }
            if (state is SignupLoadingState) {}
            if (state is SignupErrorState) {}
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                children: [
                  TextFormField(
                    controller: authCubit.userNameController,
                    decoration: const InputDecoration(
                        hintText: 'Enter Your User Name',
                        labelText: 'User Name'),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 175,
                        height: 56,
                        child: TextFormField(
                            controller: authCubit.firstNameController,
                            decoration: const InputDecoration(
                                hintText: 'Enter First Name',
                                labelText: 'First Name')),
                      ),
                      const Spacer(),
                      SizedBox(
                          width: 175,
                          height: 56,
                          child: TextFormField(
                            controller: authCubit.lastNameController,
                            decoration: const InputDecoration(
                              hintText: 'Enter Last Name',
                              labelText: 'Last Name',
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                      controller: authCubit.emailController,
                      decoration: const InputDecoration(
                          hintText: 'Enter Email', labelText: 'Email')),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 175,
                        height: 56,
                        child: TextFormField(
                          controller: authCubit.passwordController,
                          decoration: const InputDecoration(
                              hintText: 'Enter Password',
                              labelText: 'Password'),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 175,
                        height: 56,
                        child: TextFormField(
                          controller: authCubit.rePasswordController,
                          decoration: const InputDecoration(
                              hintText: 'Confirm Password',
                              labelText: 'Confirm Password'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: authCubit.phoneNumberController,
                    decoration: const InputDecoration(
                        hintText: 'Enter Phone Nubmer',
                        labelText: 'Phone Nubmer'),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      authCubit.signup();
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Sign Up'),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                        style: const ButtonStyle(
                          overlayColor:
                              WidgetStatePropertyAll(Colors.transparent),
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.loginPage);
                        },
                        child: const Text(
                          'login',
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
