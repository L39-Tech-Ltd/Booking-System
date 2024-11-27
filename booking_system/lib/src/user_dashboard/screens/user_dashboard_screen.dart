

import 'package:booking_system/src/user_dashboard/widgets/upcoming_bookings.dart';
import 'package:booking_system/widgets/base_screen.dart';
import 'package:flutter/material.dart';

class UserDashboardScreen extends StatelessWidget{
  const UserDashboardScreen({super.key});

  @override
  Widget build(BuildContext context){
    return BaseScreen(
      title: 'User Dashboard',
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            Text("User Dashboard"),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(onPressed: () {Navigator.pushNamed(context, '/Search');}, child: const Text("Create New Booking")),
              ],
            ),
            SizedBox(height: 8.0,),

            //Upcoming bookings
            UpcomingBookings(),

          ],
        )
      )
    );
  }
}