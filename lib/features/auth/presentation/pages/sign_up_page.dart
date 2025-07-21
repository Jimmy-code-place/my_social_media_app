import 'package:flutter/material.dart';
import 'package:social_media_app/features/auth/presentation/widgets/my_log_button.dart';
import 'package:social_media_app/features/auth/presentation/widgets/my_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<SignUpPage> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final pwController = TextEditingController();
  final confirmPwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock_open_rounded,
                  color: Theme.of(context).colorScheme.primary,
                  size: 80,
                ),
                const SizedBox(height: 80),
                Text(
                  'SIGN IN',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 80),
                MyTextField(
                  controller: nameController,
                  hintText: 'Name',
                  isObscure: false,
                ),
                const SizedBox(height: 20),
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  isObscure: false,
                ),
                const SizedBox(height: 20),
                MyTextField(
                  controller: pwController,
                  hintText: 'Password',
                  isObscure: true,
                ),
                const SizedBox(height: 20),
                MyTextField(
                  controller: confirmPwController,
                  hintText: 'Confirm Password',
                  isObscure: true,
                ),
                const SizedBox(height: 20),

                MyLogButton(text: 'SIGN UP'),
                const SizedBox(height: 20),

                Text(
                  'already a member',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'login'),
                  child: Text(
                    ' sign in now',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
