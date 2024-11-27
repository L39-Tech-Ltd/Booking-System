import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../src/authentication/services/authenticate_user.dart';

class NavBar extends StatelessWidget{

  const NavBar({super.key});

  @override
  Widget build(BuildContext context){
    final authUser = Provider.of<AuthenticateUser>(context);
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(onPressed: () {Navigator.pushReplacementNamed(context, '/');}, child: const Text("Home")),
          ElevatedButton(onPressed: () {Navigator.pushReplacementNamed(context, '/Login');}, child: const Text("Login")),
          ElevatedButton(onPressed: () {Navigator.pushReplacementNamed(context, '/Profile');}, child: const Text("Profile")),
          ElevatedButton(onPressed: () {Navigator.pushReplacementNamed(context, '/Business');}, child: const Text("Business")),
          ElevatedButton(onPressed: () {Navigator.pushReplacementNamed(context, '/CreateBookings');}, child: const Text("Create Bookings")),
          authUser.isAuthenticated ? ElevatedButton(onPressed: () async {
            await authUser.logOut();
            if (context.mounted) {Navigator.pushReplacementNamed(context, '/Login');}
            }, child: const Text("Log Out"),) :  SizedBox.shrink(),
        ]
      ),
    );
  }
}