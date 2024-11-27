import 'package:flutter/material.dart';
import '../../../widgets/base_screen.dart';
import '../forms/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context){
    return BaseScreen(
      title: 'L39',
      body: Center(
        child: LoginForm()
        ),
    );
  }
}