import 'package:flutter/material.dart';
import '../../../widgets/base_screen.dart';
import '../forms/sign_up_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context){
    return BaseScreen(
      title: 'L39',
      body: const Center(
        child: SignUpForm()
        ),
    );
  }

}