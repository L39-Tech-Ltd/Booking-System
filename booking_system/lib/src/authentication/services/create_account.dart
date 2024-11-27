import 'dart:async';
import 'package:dio/dio.dart';
import '../../../config/app_config.dart';

Future<bool> createAccount(String email, String password, String forename, String surname, Dio dio) async{
  final url = AppConfig.createAccountUrl;

  var formData = {
    'email' : email,
    'password' : password,
    'forename' : forename,
    'surname' : surname
  };

  try{
    final response = await dio.post(
      url,
      data: formData,
      options: Options(
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      ),
    );

    if (response.statusCode == 200){
      return true;
    }else{
      throw Exception('Failed to create account : ${response.statusMessage}');
    } 
  }catch(e){
    throw Exception('Failed to create account: $e');
  }
}
