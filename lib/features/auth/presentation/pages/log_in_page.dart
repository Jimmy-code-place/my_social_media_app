import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:social_media_app/features/auth/presentation/widgets/my_log_button.dart';
import 'package:social_media_app/features/auth/presentation/widgets/my_text_field.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final emailController = TextEditingController();

  final pwController = TextEditingController();

  void logIn() {
    final String email = emailController.text;
    final String pw = pwController.text;

    final authCubit = context.read<AuthCubit>();

    if (email.isNotEmpty || pw.isNotEmpty) {
      authCubit.loginWithEmailAndPw(email, pw);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('pls enter both email and pawssword')),
      );
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
                  'welcome back',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 80),
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

                MyLogButton(onTap: logIn, text: 'LOG IN'),
                const SizedBox(height: 20),

                Text(
                  'not a member',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'signup'),
                  child: Text(
                    ' regester now',
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
