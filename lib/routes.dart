import 'package:flutter/cupertino.dart';
import './screen/Dashboard/dashboard_screen.dart';
import 'screen/Pokedex/pokedex_screen.dart';

final Map<String, WidgetBuilder> routes = {
  DashboardScreen.id: (context) => const DashboardScreen(),
  Pokedex.id: (context) => const Pokedex(),
};
