import 'package:flutter/material.dart';

import '../screens/list_screen.dart';
import '../screens/location_details_screen.dart';
import '../screens/post_screen1.dart';
import '../screens/post_screen2.dart';
import '../screens/post_screen3.dart';
import '../screens/signin_details_screen.dart';
import '../screens/signin_screen.dart';

class AppRoutes {
  static String get initialRoute => SigninScreen.route;

  static Map<String, Widget Function(BuildContext context)> get routes {
    return {
      SigninScreen.route: (_) => const SigninScreen(),
      SigninDetailsScreen.route: (_) => const SigninDetailsScreen(),
      ListScreen.route: (_) => const ListScreen(),
      LocationDetailScreen.route: (_) => const LocationDetailScreen(),
      PostScreen1.route: (_) => const PostScreen1(),
      PostScreen2.route: (_) => const PostScreen2(),
      PostScreen3.route: (_) => const PostScreen3(),
    };
  }
}
