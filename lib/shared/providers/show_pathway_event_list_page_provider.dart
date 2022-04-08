import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'show_welcome_page_provider.dart';

final showPathwayEventListPageProvider = FutureProvider<bool>((ref) async {
  final showWelcomePage = await ref.watch(showWelcomePageProvider.future);

  return !showWelcomePage;
});
