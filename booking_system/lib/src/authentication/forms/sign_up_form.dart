import 'package:booking_system/widgets/base_form.dart';
import 'package:flutter/material.dart';
import '../services/create_account.dart';
import 'package:provider/provider.dart';
import '../services/authenticate_user.dart';
import 'package:dio/dio.dart';

class SignUpForm extends StatefulWidget{
  const SignUpForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm>{
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController forenameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  bool _passwordView = true;
  bool _confPasswordView = true;

  void _submitForm() async{
    String email = emailController.text;
    String password = passwordController.text;
    String forename = forenameController.text;
    String surname = surnameController.text;
    final dio = Provider.of<Dio>(context, listen: false);
    try{
      bool accountCreated = await createAccount(email, password, forename, surname, dio);
      if (!mounted) return;
      if(accountCreated){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Account Created, Logging In...')),
        );
        _autoLogin();
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid Email or Password')),
        );
      }
    } catch (error){
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  void _autoLogin() async{
    String email = emailController.text;
    String password = passwordController.text;
    final authUser = Provider.of<AuthenticateUser>(context, listen: false);
    try{
      bool loggedIn = await authUser.authenticate(email, password);
      if (!mounted) return;
      if(loggedIn){
        Navigator.pushReplacementNamed(context, '/');
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid Email or Password, please try again')),
        );
      }
    } catch (error){
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context){
    return Column( 
      children: [
        BaseForm(
          formKey: _formKey,
          formName: "Sign Up",
          formFields: [

            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email'
              ),
              validator: (value) {
                if (value == null || value.isEmpty){
                  return 'Please enter your email';
                }

                return null;
              },
            ),

            TextFormField(
              controller: passwordController,
              obscureText: _passwordView,
              decoration: InputDecoration(
              border: OutlineInputBorder(),
                labelText: 'Password',
                suffixIcon: IconButton(onPressed: () { setState((){_passwordView = !_passwordView;});}, icon: Icon(_passwordView ? Icons.visibility : Icons.visibility_off)),
              ),
              validator: (value) {
                if (value == null || value.isEmpty){
                return 'Please enter your password';
              }

              return null;
              },
            ),

            TextFormField(
              controller: confirmPasswordController,
              obscureText: _confPasswordView,
              decoration: InputDecoration(
              border: OutlineInputBorder(),
                labelText: 'Confirm Password',
                suffixIcon: IconButton(onPressed: () { setState((){_confPasswordView = !_confPasswordView;});}, icon: Icon(_confPasswordView ? Icons.visibility : Icons.visibility_off)),
              ),
              validator: (value) {
                if (value == null || value.isEmpty){
                return 'Please enter your password';
              }else if(value != passwordController.text){
                return 'Password and Confirm Password dont match';
              }

              return null;
              },
            ),

            TextFormField(
              controller: forenameController,
              decoration: const InputDecoration(
              border: OutlineInputBorder(),
                labelText: 'First Name'
              ),
              validator: (value) {
                if (value == null || value.isEmpty){
                return 'Please enter your Firt name';
              }

              return null;
              },
            ),

            TextFormField(
              controller: surnameController,
              decoration: const InputDecoration(
              border: OutlineInputBorder(),
                labelText: 'Surname'
              ),
              validator: (value) {
                if (value == null || value.isEmpty){
                return 'Please enter your Surname';
              }

              return null;
              },
            ),
          ],
          onSubmit: _submitForm,
        ),

        //Alreay have an account Text & Button
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Alreay have an accouunt?"),
              TextButton(onPressed: () {Navigator.pushReplacementNamed(context, '/Login');}, child: const Text("Sign in Here"))
            ],
          ),
        )
      ]
    );

  }
}