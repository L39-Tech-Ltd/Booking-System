import 'package:booking_system/config/app_config.dart';
import 'package:dio/dio.dart';
import '../models/business_data.dart';
import 'dart:async';

Future<List<BusinessData>> searchBusiness(Dio dio, String searchTerm) async{
  final url = AppConfig.searchBusiness;

  try{
    final response = await dio.get(
      url,
      queryParameters: {
        'searchTerm': searchTerm,
      },
    );
    if(response.statusCode == 200){
      final List<BusinessData> responseBusiness = [];

      for(var business in response.data['data']){
        responseBusiness.add(BusinessData.fromJson(business));
      }

      return responseBusiness;
    }else{
      throw Exception('Failed to retrieve Data : ${response.statusCode} - ${response.data}');
    }
  }catch(error){
    throw Exception('Failed to retrieve Data : $error');
  }

}