import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_issues_app/data/repository/auth_repository_impl.dart';
import 'package:github_issues_app/feature/auth/auth_cubit.dart';
import 'package:github_issues_app/feature/main/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Issues App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => AuthCubit(
          AuthRepositoryImpl(),
        ),
        child: MainScreen(title: 'GitHub Issues App'),
      ),
    );
  }
}
