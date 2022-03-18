import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/user_settings.dart';
import '../repositories/user_settings_repository.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: const [SettingsForm()])));
  }
}

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final _dateOfBirthController = TextEditingController();

  final _userSettings = UserSettingsRepository().get();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: FutureBuilder<UserSettings>(
            future: _userSettings,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _setDateOfBirthController(snapshot.data!.dateOfBirth);

                return Column(children: [
                  GestureDetector(
                    onTap: () => _selectDateOfBirth(context, snapshot.data!),
                    child: AbsorbPointer(
                      child: TextFormField(
                          controller: _dateOfBirthController,
                          keyboardType: TextInputType.datetime,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a Date of Birth';
                            }

                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: 'Date of Birth',
                              icon: Icon(Icons.calendar_today))),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          UserSettingsRepository().save(snapshot.data!);

                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Save', style: TextStyle(fontSize: 24)))
                ]);
              } else {
                return const CircularProgressIndicator();
              }
            }));
  }

  @override
  void dispose() {
    _dateOfBirthController.dispose();

    super.dispose();
  }

  _selectDateOfBirth(BuildContext context, UserSettings settings) async {
    final currentDate = DateTime.now();

    final initialDate = settings.dateOfBirth ?? DateTime.now();

    final firstDate =
        DateTime(currentDate.year - 18, currentDate.month, currentDate.day);
    final lastDate =
        DateTime(currentDate.year + 1, currentDate.month, currentDate.day);

    final pickedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate);

    if (pickedDate != null) {
      setState(() {
        settings.dateOfBirth = pickedDate;
        _setDateOfBirthController(pickedDate);
      });
    }
  }

  _setDateOfBirthController(DateTime? dateTime) {
    if (dateTime == null) {
      return;
    }

    _dateOfBirthController.text = DateFormat.yMMMd().format(dateTime);
  }
}
