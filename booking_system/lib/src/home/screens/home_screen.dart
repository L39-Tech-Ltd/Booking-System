import 'package:flutter/material.dart';
import '../../../widgets/base_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context){
    return BaseScreen(
      title: 'L39',
      body: Container(
        child: Column(
          children: [
            const Text("Home"),
            SizedBox(height: 25.0),
            Text("Welcome to L39 Bookings!"),
            SizedBox(height: 25.0),
            Text("Login In to create and view bookings"),
            SizedBox(height: 100.0),
            Text("Business control coming soon"),

          ]
        ),
      ),
    );
  }
}