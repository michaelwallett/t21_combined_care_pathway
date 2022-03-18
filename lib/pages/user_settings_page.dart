import 'package:flutter/material.dart';
import '../screens/user_settings_screen.dart';

class UserSettingsPage extends Page {
  UserSettingsPage() : super(key: ValueKey('$UserSettingsPage'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return const UserSettingsScreen();
      },
    );
  }
}
