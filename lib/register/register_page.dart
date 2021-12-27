import 'package:books_app/register/bloc/register_bloc.dart';
import 'package:books_app/register/widgets/register_form.dart';
import 'package:books_app/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  final UserRepository _userRepository = UserRepository();

  RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(_userRepository),
          child: const RegisterForm(),
        ),
      ),
    );
  }
}