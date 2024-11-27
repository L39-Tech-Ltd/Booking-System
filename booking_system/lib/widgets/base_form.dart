import 'package:flutter/material.dart';

class BaseForm extends StatelessWidget{
  final GlobalKey<FormState> formKey;
  final String? formName;
  final List<Widget> formFields;
  final VoidCallback onSubmit;

  const BaseForm({
    super.key,
    required this.formKey,
    required this.formFields,
    required this.onSubmit,
    this.formName,
  });

  @override
  Widget build(BuildContext context){
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(formName != null)
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(formName!),
            ),

          ...formFields.map((field) => Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: field
          )),

          Container(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
              onPressed: () {
                if (formKey.currentState!.validate()){
                  onSubmit();
                }
              }, 
                child: const Text("Submit")
              )
          ),

        ],
      )
    );
  }
}
//ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Processing')));

//ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Processing')));