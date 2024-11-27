
import 'package:booking_system/config/app_config.dart';
import 'package:booking_system/models/employee_data.dart';
import 'package:dio/dio.dart';

Future<List<EmployeeData>> fetchEmployees(String? businessId, Dio dio) async{
  final url = AppConfig.getEmployeesUrl;
  try{
    final response = await dio.get(
      url,
      queryParameters: {
        'business_id': businessId,
      }
    );
    if(response.statusCode == 200){
      final List<EmployeeData> responseEmployees = [];

      for(var employee in response.data['data']){
        responseEmployees.add(EmployeeData.fromJson(employee));
      }

      return responseEmployees;
    }else{
      throw Exception('Failed to get employees : ${response.statusCode}');
    }
  }catch(error){
    throw Exception('Failed to get employees : $error');
  }
}