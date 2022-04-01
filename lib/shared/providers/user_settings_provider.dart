import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/user_settings.dart';
import '../repositories/user_settings_repository.dart';

class UserSettingsNotifier extends StateNotifier<AsyncValue<UserSettings>> {
  final Ref ref;

  UserSettingsNotifier(this.ref) : super(const AsyncValue.loading()) {
    _fetchUserSettings();
  }

  void updateDateOfBirth(DateTime? dateOfBirth) {
    state = AsyncValue.data(UserSettings(dateOfBirth));
  }

  void save() async {
    state.whenData(
        (userSettings) => UserSettingsRepository().save(userSettings));
  }

  Future<void> _fetchUserSettings() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard((() => UserSettingsRepository().get()));
  }
}

final userSettingsProvider =
    StateNotifierProvider<UserSettingsNotifier, AsyncValue<UserSettings>>(
        (ref) {
  return UserSettingsNotifier(ref);
});
