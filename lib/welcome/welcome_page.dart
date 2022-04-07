import 'package:flutter/material.dart';
import 'welcome_screen.dart';

class WelcomePage extends Page {
  WelcomePage() : super(key: ValueKey('$WelcomePage'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this,
        builder: (BuildContext context) {
          return const WelcomeScreen();
        });
  }
}
