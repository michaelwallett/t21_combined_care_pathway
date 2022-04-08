import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/user_settings_provider.dart';

class UserSettingsForm extends HookConsumerWidget {
  final bool shouldPopOnSave;
  final _formKey = GlobalKey<FormState>();

  UserSettingsForm({Key? key, this.shouldPopOnSave: false}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateOfBirthController = useTextEditingController();
    final userSettingsAsyncValue = ref.watch(userSettingsProvider);

    return userSettingsAsyncValue.when(
        data: (userSettings) {
          _setDateOfBirthController(
              dateOfBirthController, userSettings.dateOfBirth);
          return Form(
              key: _formKey,
              child: Column(children: [
                GestureDetector(
                  onTap: () => _selectDateOfBirth(
                      context, dateOfBirthController, userSettings.dateOfBirth),
                  child: AbsorbPointer(
                    child: TextFormField(
                        controller: dateOfBirthController,
                        keyboardType: TextInputType.datetime,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a Date of Birth';
                          }

                          return null;
                        },
                        onSaved: (value) {
                          final dateOfBirth = DateFormat.yMMMd().parse(value!);

                          ref
                              .read(userSettingsProvider.notifier)
                              .updateDateOfBirth(dateOfBirth);
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
                        _formKey.currentState!.save();

                        ref.read(userSettingsProvider.notifier).save();

                        if (shouldPopOnSave) {
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: const Text('Save', style: TextStyle(fontSize: 24)))
              ]));
        },
        error: (err, _) => const Text('Oops'),
        loading: () => const CircularProgressIndicator());
  }

  _selectDateOfBirth(
      BuildContext context,
      TextEditingController dateOfBirthController,
      DateTime? dateOfBirth) async {
    final currentDate = DateTime.now();

    final initialDate = dateOfBirth ?? currentDate;

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
      _setDateOfBirthController(dateOfBirthController, pickedDate);
    }
  }

  _setDateOfBirthController(
      TextEditingController dateOfBirthController, DateTime? dateOfBirth) {
    if (dateOfBirth == null) {
      dateOfBirthController.text = '';
    } else {
      dateOfBirthController.text = DateFormat.yMMMd().format(dateOfBirth);
    }
  }
}
