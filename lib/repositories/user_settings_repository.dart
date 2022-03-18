import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_settings.dart';

class UserSettingsRepository {
  final dateOfBirthKey = 'DateOfBirthKey';

  Future<UserSettings> get() async {
    final preferences = await SharedPreferences.getInstance();

    DateTime? dateOfBirth;

    var dateOfBirthValue = preferences.getString(dateOfBirthKey);

    if (dateOfBirthValue != null) {
      dateOfBirth = DateTime.tryParse(dateOfBirthValue);
    }

    return UserSettings(dateOfBirth);
  }

  save(UserSettings settings) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setString(
        dateOfBirthKey, settings.dateOfBirth!.toIso8601String());
  }
}
