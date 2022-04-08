import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_settings.dart';

class UserSettingsRepository {
  final _dateOfBirthKey = 'DateOfBirthKey';

  Future<UserSettings> get() async {
    final preferences = await SharedPreferences.getInstance();

    var dateOfBirthValue = preferences.getString(_dateOfBirthKey);

    DateTime? dateOfBirth;

    if (dateOfBirthValue != null) {
      dateOfBirth = DateTime.tryParse(dateOfBirthValue);
    }

    return UserSettings(dateOfBirth);
  }

  void save(UserSettings settings) async {
    final preferences = await SharedPreferences.getInstance();

    // await preferences.setString(
    //     _dateOfBirthKey, settings.dateOfBirth!.toIso8601String());
  }
}
