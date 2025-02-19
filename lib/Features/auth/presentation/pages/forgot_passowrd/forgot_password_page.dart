import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        leading: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                "Forget password",
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              const Text("Please enter your email associated"),
              const Text("with your account"),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter Your Email',
                  labelText: 'Email',
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "continue",
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
