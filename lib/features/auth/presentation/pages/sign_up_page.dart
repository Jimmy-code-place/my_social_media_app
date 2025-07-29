import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/auth/presentation/cubits/auth_cubit.dart';
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

  void signUp() {
    final name = nameController.text;
    final email = emailController.text;
    final pw = pwController.text;
    final confirmPw = confirmPwController.text;

    final authCubit = context.read<AuthCubit>();

    if (name.isNotEmpty &&
        email.isNotEmpty &&
        pw.isNotEmpty &&
        confirmPw.isNotEmpty) {
      if (pw != confirmPw) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('password doesnt match')));
      } else {
        authCubit.register(name, email, pw);
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('pls enter all fields')));
    }
  }

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

                MyLogButton(text: 'SIGN UP', onTap: signUp),
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
