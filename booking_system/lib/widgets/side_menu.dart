

import 'package:booking_system/src/authentication/services/authenticate_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    final authUser = Provider.of<AuthenticateUser>(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          
          //Display basic user info
          _userDetails(),

          // Account and Sign Out section
          _accountSignOut(context, authUser),

          _bookings(),

          _favourites(),

          _comingSoon(),

          _comingSoon(),

          _devMenu(context, authUser)
        ],

      )
    );
  }


  Widget _userDetails(){
    return DrawerHeader(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 76, 81, 85),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //Profile Pic
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[200],
            child: Icon(
              Icons.person,
              size: 50,
              color: Colors.grey[600],
            ),
          ),

          //User Detaissl
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Name"),
              Text("Email"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _accountSignOut(context, authUser){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      color: const Color.fromARGB(255, 117, 124, 133),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: Material(
                color: Colors.transparent, // Ensures the background remains the same
                child: ListTile(
                  title: const Center(child: Text('Account')),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/Profile');
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: Material(
                color: Colors.transparent,
                child: ListTile(
                  title: const Center(child: Text('Sign Out')),
                  onTap: () async {
                    await authUser.logOut();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bookings(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      color: const Color.fromARGB(255, 117, 124, 133),
      child: Column(
        children: [
          SizedBox(height: 10.0,),
          Text("Bookings"),
          SizedBox(height: 10.0,),
        ],
      )
    );
  }

  Widget _favourites(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      color: const Color.fromARGB(255, 117, 124, 133),
      child: Column(
        children: [
          SizedBox(height: 10.0,),
          Text("Favourites"),
          SizedBox(height: 10.0,),
        ],
      )
    );
  }

  Widget _comingSoon(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      color: const Color.fromARGB(255, 117, 124, 133),
      child: Column(
        children: [
          SizedBox(height: 10.0,),
          Text("Coming Soon..."),
          SizedBox(height: 10.0,),
        ],
      )
    );
  }

  Widget _devMenu(context, authUser){
    
    //final authUser = Provider.of<AuthenticateUser>(context);

    List<Widget> action = [];
    if (authUser.isAuthenticated) {
      action.add(ElevatedButton(onPressed: () {Navigator.pushReplacementNamed(context, '/');}, child: const Text("Home")));
      action.add(ElevatedButton(onPressed: () {Navigator.pushReplacementNamed(context, '/Profile');}, child: const Text("Profile")));
      action.add(ElevatedButton(onPressed: () {Navigator.pushReplacementNamed(context, '/Business');}, child: const Text("Business")));
      action.add(ElevatedButton(onPressed: () {Navigator.pushReplacementNamed(context, '/CreateBookings');}, child: const Text("Create Bookings")));
      action.add(ElevatedButton(onPressed: () async {
          await authUser.logOut();
          }, child: const Text("Log Out"),));
    }
    else{
      action.add(ElevatedButton(onPressed: () {Navigator.pushReplacementNamed(context, '/Login');}, child: const Text("Login")));
      action.add(ElevatedButton(onPressed: () {Navigator.pushReplacementNamed(context, '/SignUp');}, child: const Text("Sign Up")));
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      color: const Color.fromARGB(255, 117, 124, 133),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: action.map((widget){
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: widget, 
          );
        }).toList(),
      )
    );
  }

}

