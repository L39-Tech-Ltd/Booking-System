
import 'package:booking_system/models/business_data.dart';
import 'package:booking_system/navigation/routeItem.dart';
import 'package:flutter/material.dart';

class BreadcrumbNavigator extends NavigatorObserver with ChangeNotifier{
  List<RouteItem> _routeStack = [];

  final Map<String, String> routeNameMap;

  BreadcrumbNavigator(this.routeNameMap);

  RouteItem _getRouteItem(Route<dynamic> route){
    final settings = route.settings;
    final String settingsName = settings.name ?? "Unknown";

    String baseName = routeNameMap[settings.name] ?? settings.name ?? 'Unknown';

    if(settings.arguments is BusinessData){
      final businessData = settings.arguments as BusinessData;
      baseName = businessData.name ?? "Business Name";
      return RouteItem(baseName, settingsName, arguments: businessData);
    }

    return RouteItem(baseName, settingsName);
  }

  List<RouteItem> get routeStack => List.unmodifiable(_routeStack);

  void addRoute(RouteItem route) {
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
    addRoute(_getRouteItem(route));
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
      addRoute(_getRouteItem(newRoute));
    }
  }

}