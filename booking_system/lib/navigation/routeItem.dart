
import 'package:flutter/material.dart';

class RouteItem {
  final String name;
  final RouteSettings routeSettings;

  RouteItem(this.name, String route, {Object? arguments})
    : routeSettings = RouteSettings(name: route, arguments: arguments);
}