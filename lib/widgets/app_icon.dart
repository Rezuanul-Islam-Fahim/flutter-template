import 'package:flutter/material.dart';

import '../core/app_theme.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({super.key, this.biggerIcon = false});

  final bool biggerIcon;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: biggerIcon
            ? Theme.of(context).textTheme.displayLarge
            : Theme.of(context).textTheme.titleLarge,
        text: 'Kall',
        children: [
          TextSpan(
            text: 'o',
            style: TextStyle(color: AppTheme.primaryColor),
          ),
        ],
      ),
    );
  }
}
