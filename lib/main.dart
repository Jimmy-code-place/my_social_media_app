import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_media_app/core/theme/light_mode.dart';
import 'package:social_media_app/features/auth/data/repos/firebase_auth_repo.dart';
import 'package:social_media_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:social_media_app/features/auth/presentation/cubits/auth_states.dart';
import 'package:social_media_app/features/auth/presentation/pages/log_in_page.dart';
import 'package:social_media_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:social_media_app/features/homepage/presentaion/home_page.dart';
import 'package:social_media_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  final authRepo = FirebaseAuthRepo();
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(authRepo)..authCheck(),
      child: MaterialApp(
        initialRoute: '/login',
        routes: {
          '/login': (context) => LogInPage(),
          '/signup': (context) => SignUpPage(),
          '/homescreen': (context) => HomePage(),
        },
        theme: lightMode,
        home: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, authState) {
            if (authState is UnAuthintecated) {
              return LogInPage();
            }
            if (authState is Authintecated) {
              return HomePage();
            } else {
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            }
          },
          listener: (context, state) {
            if (AuthState is AuthError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('invalid input')));
            }
          },
        ),
      ),
    );
  }
}
