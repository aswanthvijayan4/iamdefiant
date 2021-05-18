import 'package:authentication_with_bloc/Screens/Dashboard/DefaultDashboard.dart';
import 'package:authentication_with_bloc/Screens/Masters/Inventory/InventoryGroupList.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => DefaultDashboard());
      case '/InvGroupList':
        return MaterialPageRoute(builder: (_) => InventoryGroupList());
      default:
        return _routeError();
    }
  }

  static Route<dynamic> _routeError() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        body: Center(child: Text('Route Error')),
      );
    });
  }
}
