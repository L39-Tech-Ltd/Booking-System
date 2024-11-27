import 'package:booking_system/models/business_data.dart';
import 'package:flutter/material.dart';
import '../../../widgets/base_screen.dart';

class BusinessDashboard extends StatefulWidget{
  final BusinessData businessData;

  BusinessDashboard({super.key, BusinessData? businessData})
  : businessData = businessData ?? BusinessData(name: "Test", email: "Test", phone: "Test", location: "Test");

  @override
  _BusinessDashboard createState() => _BusinessDashboard();
}

class _BusinessDashboard extends State<BusinessDashboard>{

  @override
  Widget build(BuildContext context){

    BusinessData data = widget.businessData;

    return BaseScreen(
      title: 'L39',
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {Navigator.pop(context);},
                  child: Text("Back")
                ),
                ElevatedButton(
                  onPressed: () {Navigator.pushNamed(context, '/CreateBookings', arguments: data);}, 
                  child: Text("Create Booking")
                )
              ],
            ),
          ),

          Text('Busines Name: ${data.name ?? "N/A"}'),
          Text('email: ${data.email ?? "N/A"}'),
          Text('phone: ${data.phone ?? "N/A"}'),
          Text('location: ${data.location ?? "N/A"}'),
        ],
      ),
    );
  }
}