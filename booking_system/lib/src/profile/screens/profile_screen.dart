import 'package:booking_system/widgets/base_screen.dart';
import 'package:flutter/material.dart';
import '../../../services/fetch_user.dart';
import '../../../models/user_data.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

class ProfileScreen extends StatefulWidget{
  const ProfileScreen({super.key});

  @override
  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen>{
  UserData? userData;
  bool isLoading = true;

  @override
  void initState(){
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final dio = Provider.of<Dio>(context, listen: false);
    try {
      userData = await fetchUserData(dio); // Fetch user data
    } catch (error) {
      // Handle error (e.g., show a message)
      print(error);
    } finally {
      setState(() {
        isLoading = false; // Stop loading
      });
    }
  }

  @override
  Widget build(BuildContext context){
    return BaseScreen(
      title: 'L39',
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          children: [
            const Text("Account"),
            Row(
              children: [
            
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.red,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey[200],
                          child: Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 10.0,),
                        Text("Username"),
                        SizedBox(height: 75.0,),
                        Text("User Info"),
                        SizedBox(height: 10.0,),
                        Text("Bookings"),
                        SizedBox(height: 10.0,),
                        Text("Example 1"),
                        SizedBox(height: 10.0,),
                        Text("Example 2"),
                        SizedBox(height: 10.0,),
                        Text("Example 3"),
                      ],
                    ),
                  )
                ),
            
                Expanded(
                  flex: 4,
                  child: Container(
                    color: Colors.blue,
                    child: Text("Main Content")
                  )
                ),
            
              ],
            ),
          ],
        )
      )
    );
  }
}

// isLoading? const Center(child: CircularProgressIndicator())
// : userData != null ?
//   Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       Text('Email: ${userData!.email ?? "N/A"}'),
//       Text('Forename: ${userData!.forename ?? "N/A"}'),
//       Text('Surname: ${userData!.surname ?? "N/A"}'),
//     ],
//   )
//   : const Center(child: Text('No user Data Availabe')),