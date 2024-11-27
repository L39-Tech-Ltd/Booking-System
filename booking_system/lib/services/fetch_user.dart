import 'package:booking_system/config/app_config.dart';
import 'package:dio/dio.dart';
import '../models/user_data.dart';
import 'dart:async';

Future<UserData> fetchUserData(Dio dio) async{
  final url = AppConfig.userData;
  try{
    final response = await dio.get(
      url,
    );
    if(response.statusCode == 200){

      final responseData = response.data['data'][0];
      
      return UserData.fromJson(responseData);
    }else{
      throw Exception('Failed to retrieve Data : ${response.statusCode}');
    }
  }catch (error){
    throw Exception('Failed to retrieve Data : $error');
  }
}
