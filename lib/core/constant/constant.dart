import 'package:flutter/material.dart';

import '../model/bottom_navigation_model.dart';
import '../router/app_pages.dart';

class Constant {
  List<BottomNavigationModel> listBottomNavigation = [
    BottomNavigationModel(
        icon: const Icon(Icons.home), label: 'Home', route: Routes.HOME),
    BottomNavigationModel(
        icon: const Icon(Icons.shopping_cart),
        label: 'Cart',
        route: Routes.CART),
    BottomNavigationModel(
        icon: const Icon(Icons.person),
        label: 'Profile',
        route: Routes.PROFILE),
  ];
}
