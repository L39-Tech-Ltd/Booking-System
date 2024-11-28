import 'package:booking_system/navigation/breadcrumbNav.dart';
import 'package:booking_system/navigation/routeItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../src/authentication/services/authenticate_user.dart';
import 'package:booking_system/navigation/router.dart';

class Header extends StatelessWidget implements PreferredSizeWidget{
  final String title;

  const Header({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final authUser = Provider.of<AuthenticateUser>(context);
    final breadcrumbNavigator = Provider.of<BreadcrumbNavigator>(context);
    
    List<RouteItem> routes = breadcrumbNavigator.routeStack;
    //List<String> routesText = ['test'];//breadcrumbNavigator.routeStack;
    //List<String> routes = ['test'];//routesText.map(getRouteFromName).toList();

    //print(routes2);
    //print(routes);

    List<Widget> breadcrumbNavStack = List.generate(routes.length * 2 -1, (index){
      if (index.isEven){
        int buttonIndex = index ~/ 2;
        return TextButton(
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName(routes[buttonIndex].routeSettings.name ?? 'Unknown'));
          },
          child: Text(routes[buttonIndex].name),
        );
      } else {
        return Text(' > ');
      }
    });
    
    List<Widget> action = [];
    if (authUser.isAuthenticated) {
      action.add(ElevatedButton(onPressed: () {Navigator.pushReplacementNamed(context, '/');}, child: const Text("Home")));
      action.add(ElevatedButton(onPressed: () {Navigator.pushReplacementNamed(context, '/UserHome');}, child: const Text("Profile")));
      action.add(ElevatedButton(onPressed: () {Navigator.pushReplacementNamed(context, '/Business');}, child: const Text("Business")));
      action.add(ElevatedButton(onPressed: () {Navigator.pushReplacementNamed(context, '/CreateBookings');}, child: const Text("Create Bookings")));
      action.add(ElevatedButton(onPressed: () async {
          await authUser.logOut();
          if (context.mounted) {Navigator.pushReplacementNamed(context, '/Login');}
          }, child: const Text("Log Out"),));
    }
    else{
      action.add(ElevatedButton(onPressed: () {Navigator.pushReplacementNamed(context, '/');}, child: const Text("Home")));
      action.add(ElevatedButton(onPressed: () {Navigator.pushReplacementNamed(context, '/Login');}, child: const Text("Login")));
      action.add(ElevatedButton(onPressed: () {Navigator.pushReplacementNamed(context, '/SignUp');}, child: const Text("Sign Up")));
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(
          backgroundColor: const Color.fromARGB(255, 112, 110, 110),
          leading: TextButton(
            onPressed: () {Navigator.pushReplacementNamed(context, '/');}, 
            child: const Text(
              "L39", 
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              )
            )
          ),
          flexibleSpace: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: action,
            )
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: breadcrumbNavStack,
        )
      ],
    );
    

  }

  @override
  Size get preferredSize => Size.fromHeight(60.0);
}