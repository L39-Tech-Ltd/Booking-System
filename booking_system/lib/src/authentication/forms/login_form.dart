import 'package:booking_system/widgets/base_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/authenticate_user.dart';

class LoginForm extends StatefulWidget{
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm>{
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _passwordView = true;

  void _submitForm() async{
    String email = emailController.text;
    String password = passwordController.text;
    final authUser = Provider.of<AuthenticateUser>(context, listen: false);
    try{
      bool loggedIn = await authUser.authenticate(email, password);
      if (!mounted) return;
      if(loggedIn){
        Navigator.pushReplacementNamed(context, '/UserHome');
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
          formName: "Login",
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
                border: const OutlineInputBorder(),
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
        
          ], 
          onSubmit: _submitForm
        ),

        //No account Text & Button
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("No accouunt?"),
              TextButton(onPressed: () {Navigator.pushReplacementNamed(context, '/SignUp');}, child: const Text("Sign Up Here"))
            ],
          ),
        ),


        //Test Log in Button DELETE DELETEDELETEDELETEDELETEDELETEDELETEDELETEDELETEDELETEDELETEDELETEDELETEDELETEDELETEDELETEDELETEDELETEDELETEDELETEDELETEDELETEDELETEDELETEDELETEDELETEDELETEDELETE
        Container(
          padding: const EdgeInsets.all(8.0),
          child: OutlinedButton(
            onPressed: () {
              emailController.text = "test@test.com";
              passwordController.text= "password";

              if (_formKey.currentState!.validate()){
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Processing')));
                _submitForm();
              }
            }, 
              child: const Text("Quick Log In TEST")
            )
        ),
        
      ],
    );
  }
}
