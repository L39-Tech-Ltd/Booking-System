import 'package:booking_system/navigation/breadcrumbNav.dart';
import 'package:booking_system/models/token_storage.dart';
import 'package:booking_system/services/auth_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'navigation/router.dart';
import 'src/authentication/services/authenticate_user.dart';
import 'src/home/screens/home_screen.dart';

void main() async{

  runApp(
    MultiProvider( 
      providers: [
        Provider(create: (_) => TokenStorage()),
        ChangeNotifierProvider(create: (_) => BreadcrumbNavigator(routeNameMap)),
        ChangeNotifierProvider(create: (context) => AuthenticateUser(Provider.of<TokenStorage>(context, listen: false))),
        Provider<Dio>(
          create: (context){
            final authenticateUser = Provider.of<AuthenticateUser>(context, listen: false);
            final tokenStorage = Provider.of<TokenStorage>(context, listen: false);
            final dio = Dio();
            dio.interceptors.add(AuthInterceptor(tokenStorage, authenticateUser));
            return dio;
          }
        ),
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatefulWidget{
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {

    final authUser = Provider.of<AuthenticateUser>(context);
    final breadcrumbNavigator = Provider.of<BreadcrumbNavigator>(context);

    return MaterialApp(
      navigatorObservers: [breadcrumbNavigator],
      title: 'Booking App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 134, 23, 23)),
        useMaterial3: true,
      ),
      home: HomeScreen(),
      onGenerateRoute: (settings) => generateRoute(settings, authUser.isAuthenticated),
    );
  }
}