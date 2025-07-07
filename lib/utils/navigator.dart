import 'package:flutter/material.dart';

class Nav {
  static void to(
    BuildContext context,
    String route, {
    Object? arguments,
  }) {
    Navigator.of(context).pushNamed(route, arguments: arguments);
  }

  static void toClearAll(
    BuildContext context,
    String route, {
    Object? arguments,
  }) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      route,
      (_) => false,
      arguments: arguments,
    );
  }
}
