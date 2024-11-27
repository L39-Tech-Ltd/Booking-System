

import 'package:booking_system/models/booking_data.dart';
import 'package:flutter/material.dart';

class BookingCard extends StatelessWidget{
  final BookingData? bookingData;

  const BookingCard({super.key, required this.bookingData});

  @override
  Widget build(BuildContext context){
    return Card(
      child:Column(
        children: [
          Text("Title: ${bookingData?.title ?? "N/A"}"),
          Text("Start Date: ${bookingData?.startDate ?? "N/A"}"),
          Text("Location: ${bookingData?.location ?? "N/A"}"),
          Text("Status: ${bookingData?.status ?? "N/A"}"),
          Text("Employee: ${bookingData?.employee ?? "N/A"}"),
        ],
      )
    );
  }
}