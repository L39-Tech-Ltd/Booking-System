

import 'package:booking_system/models/booking_data.dart';
import 'package:booking_system/src/user_dashboard/services/fetch_bookings.dart';
import 'package:booking_system/src/user_dashboard/widgets/booking_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpcomingBookings extends StatefulWidget{
  const UpcomingBookings({super.key});

  @override
  _UpcomingBookings createState() => _UpcomingBookings();
}

class _UpcomingBookings extends State<UpcomingBookings>{
  List<BookingData> bookingData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchBookings();
  }

  Future<void> _fetchBookings() async{
    final dio = Provider.of<Dio>(context, listen: false);
    try{
      bookingData = await fetchBookings(dio);
    }catch (error){
      print(error);
    }finally{
      setState((){
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        )
      ),
      width: double.infinity,
      child: Column(
        children: [
          Text("Upcoming Bookings"),
          SizedBox(height: 50),

          isLoading
            ? const Center(child: CircularProgressIndicator())
            : bookingData.isEmpty
              ? Text("No bookings found")
              : Column(
                children: [
                  for(var booking in bookingData)
                    BookingCard(bookingData: booking),
                ],
              )
        ],
      ),
    );
  }
}


// Column(
//                 children: [
//                   BookingCard(bookingData: bookingData[0]),
//                 ],