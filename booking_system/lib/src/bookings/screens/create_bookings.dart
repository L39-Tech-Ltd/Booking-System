import 'package:booking_system/src/bookings/forms/create_booking_form.dart';
import 'package:booking_system/models/business_data.dart';
import 'package:flutter/material.dart';
import '../../../widgets/base_screen.dart';

class CreateBookingScreen extends StatelessWidget{
  final BusinessData businessData;

  const CreateBookingScreen({super.key, required this.businessData});

  

  @override
  Widget build(BuildContext context){
    return BaseScreen(
      title: 'L39',
      body: CreateBookingForm(businessData: businessData),
    );
  }

}