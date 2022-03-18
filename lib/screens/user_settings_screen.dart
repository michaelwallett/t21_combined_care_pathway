import 'package:flutter/material.dart';
import '../widgets/user_settings_form.dart';

class UserSettingsScreen extends StatelessWidget {
  const UserSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: const [UserSettingsForm()])));
  }
}
