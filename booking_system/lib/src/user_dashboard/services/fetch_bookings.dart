
import 'package:booking_system/config/app_config.dart';
import 'package:booking_system/models/booking_data.dart';
import 'package:dio/dio.dart';

Future<List<BookingData>> fetchBookings(Dio dio) async{
  final url = AppConfig.getBookingsUrl;
  try{
    final response = await dio.get(
      url,
    );
    
    if(response.statusCode == 200){
      final List<BookingData> responseBookings = [];

      for(var booking in response.data['data']){
        responseBookings.add(BookingData.fromJson(booking));
      }

      return responseBookings;
    }else{
      throw Exception('Failed to retrive Data : ${response.statusCode}');
    }
  }catch (error){
    throw Exception('Failed to retrieve Data : $error');
  }
}