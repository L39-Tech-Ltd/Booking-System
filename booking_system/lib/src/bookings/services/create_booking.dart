

import 'package:booking_system/config/app_config.dart';
import 'package:dio/dio.dart';

Future<bool> createBooking(
  String? businessId, 
  String? employeeId, 
  String title,
  String startDate,
  String endDate,
  String location,
  String notes,
  String status,
  Dio dio) 
  async{

  final url = AppConfig.createBookingUrl;

  var formData = {
    'business_id' : businessId,
    'employee_id' : employeeId,
    'title' : title,
    'start_date' : startDate,
    'end_date' : endDate,
    'location' : location,
    'notes' : notes,
    'status' : status,
  };

  try{
    final response = await dio.post(
      url,
      data: formData,
      options: Options(
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      ),
    );

    if(response.statusCode == 200){
      return true;
    }else{
      throw Exception('Failed to create booking : ${response.statusMessage}');
    }
  }catch(e){
    throw Exception('Failed to create Booking: $e');
  }
}