
import 'package:booking_system/models/business_data.dart';
import 'package:flutter/material.dart';

class BreadcrumbNavigator extends NavigatorObserver with ChangeNotifier{
  List<String> _routeStack = [];
  final Map<String, String> routeNameMap;

  BreadcrumbNavigator(this.routeNameMap);

  String _getReadableName(Route<dynamic> route){
    final settings = route.settings;
    final String? baseName = routeNameMap[route.settings.name] ?? route.settings.name ?? 'Unknown';

    if(settings.arguments is BusinessData){
      final businessData = settings.arguments as BusinessData;
      return businessData.name ?? "Business Name";
    }

    return baseName!;
  }

  List<String> get routeStack => List.unmodifiable(_routeStack);

  void addRoute(String route) {
    _routeStack.add(route);
    notifyListeners();
    //print(_routeStack);
  }

  void removeRoute() {
    if (_routeStack.isNotEmpty) {
      _routeStack.removeLast();
      notifyListeners(); 
      //print(_routeStack);
    }
  }

  void resetRoute() {
    _routeStack.clear();
    notifyListeners(); 
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    addRoute(_getReadableName(route));
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    removeRoute();
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    removeRoute();
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    //print("T");
    if (oldRoute != null){
      //_routeStack.removeLast();
      resetRoute();
    }
    if (newRoute != null) {
      addRoute(_getReadableName(newRoute));
    }
  }

}