import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../utils/navigator.dart';
import '../widgets/app_icon.dart';
import 'signin_details_screen.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  static const String route = '/signin';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: const Center(child: AppIcon(biggerIcon: true)),
        bottomSheet: SizedBox(
          height: 102,
          width: double.infinity,
          child: Column(
            children: [
              Text(
                'Continue with',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  Nav.to(context, SigninDetailsScreen.route);
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[200]!,
                        blurRadius: 8,
                        spreadRadius: 8,
                        offset: const Offset(0, -3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        size: 20,
                        color: AppTheme.primaryColor,
                      ),
                      const SizedBox(width: 20),
                      Text(
                        'Enter',
                        style: theme.textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
