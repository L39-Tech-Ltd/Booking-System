import 'package:booking_system/models/business_data.dart';
import 'package:booking_system/src/user_dashboard/screens/user_dashboard_screen.dart';
import 'package:flutter/material.dart';

import '../src/authentication/screens/login_screen.dart';
import '../src/authentication/screens/sign_up_screen.dart';

import '../src/home/screens/home_screen.dart';
import '../src/search/screens/search_screen.dart';
import '../src/profile/screens/profile_screen.dart';
import '../src/business/screens/business_dashboard.dart';
import '../src/bookings/screens/create_bookings.dart';

final Map<String, String> routeNameMap = {
  '/': 'Home',
  '/Login': 'Login',
  '/SignUp': 'Sign Up',
  '/Profile': 'Profile',
  '/UserHome': 'User Home',
  '/Search': 'Search',
  '/Business': 'Business',
  '/CreateBookings': 'Create Bookings',
};

String getRouteFromName(String name){
  final entry = routeNameMap.entries.firstWhere(
    (entry) => entry.value == name,
    orElse: () => MapEntry('', '')
  );
  return entry.key;
}


Route<dynamic> generateRoute(RouteSettings settings, isAuthenticated){

  switch (settings.name){
    case '/':
      return MaterialPageRoute(
        builder: (context) => HomeScreen(),
        settings: RouteSettings(name: "Home"),
      );
    
    case '/Login':
      return MaterialPageRoute(
        builder: (context) => !isAuthenticated ? LoginScreen() : HomeScreen(),
        settings: RouteSettings(name: settings.name),
      );

    case '/SignUp':
      return MaterialPageRoute(
        builder: (context) => !isAuthenticated ? SignUpScreen() : HomeScreen(),
        settings: RouteSettings(name: settings.name),
      );

    case '/Profile':
      return MaterialPageRoute(
        builder: (context) => isAuthenticated ? ProfileScreen() : LoginScreen(),
        settings: RouteSettings(name: settings.name),
      );

    case '/UserHome':
      return MaterialPageRoute(
        builder: (context) => isAuthenticated ? UserDashboardScreen() : LoginScreen(),
        settings: RouteSettings(name: settings.name),
      );

    case '/Search':
      return MaterialPageRoute(
        builder: (context) => isAuthenticated ? SearchScreen() : LoginScreen(),
        settings: RouteSettings(name: settings.name),
      );


    case '/Business':
      final businessData = settings.arguments as BusinessData?;
      return MaterialPageRoute(
        builder: (context) => isAuthenticated 
        ? BusinessDashboard(businessData: businessData) 
        : LoginScreen(),
        settings: RouteSettings(name: settings.name, arguments: settings.arguments), //settings
      );

    case '/CreateBookings':
      final businessData = settings.arguments as BusinessData?;

      if(businessData == null){
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
          settings: RouteSettings(name: settings.name),
        );
      }

      return MaterialPageRoute(
        builder: (context) => isAuthenticated 
        ? CreateBookingScreen(businessData: businessData) 
        : LoginScreen(),
        settings: RouteSettings(name: settings.name),
      );

 
    //Unknown Route
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(child: Text('Unknown Route: ${settings.name}')),
        ),
      );

  }
}


  // final Map<String, WidgetBuilder> routes = {
  //   '/': (context) => HomeScreen(),
  //   '/Login': (context) => !isAuthenticated ? LoginScreen() : HomeScreen(),
  //   '/SignUp': (context) => !isAuthenticated ? SignUpScreen() : HomeScreen(),
  //   '/Profile': (context) => isAuthenticated ? ProfileScreen() : LoginScreen(),
  //   '/Business': (context) => isAuthenticated ? BusinessDashboard() : LoginScreen(),
  //   '/CreateBookings': (context) => isAuthenticated ? CreateBookingScreen() : LoginScreen(),
  // };

  // final WidgetBuilder builder = routes[settings.name] ?? (context) => Scaffold(
  //       body: Center(child: Text('Unknown Route: ${settings.name}')),
  //     );

  // return MaterialPageRoute(builder: builder);