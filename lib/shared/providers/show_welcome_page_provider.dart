import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'user_settings_provider.dart';

final showWelcomePageProvider = FutureProvider<bool>((ref) async {
  final userSettings = await ref.watch(userSettingsProvider.future);

  return userSettings.dateOfBirth == null;
});
