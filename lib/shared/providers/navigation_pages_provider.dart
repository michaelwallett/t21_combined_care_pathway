import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/navigation_pages.dart';
import 'selected_pathway_event_date_provider.dart';
import 'show_pathway_event_list_page_provider.dart';
import 'show_welcome_page_provider.dart';
import 'show_user_settings_page_provider.dart';

final navigationPagesProvider = FutureProvider<NavigationPages>((ref) async {
  final showWelcomePage = await ref.watch(showWelcomePageProvider.future);
  final showPathwayEventListPage =
      await ref.watch(showPathwayEventListPageProvider.future);
  final showUserSettingsPage = ref.watch(showUserSettingsPageProvider);
  final selectedPathwayEventDate = ref.watch(selectedPathwayEventDateProvider);

  return NavigationPages(showWelcomePage, showPathwayEventListPage,
      showUserSettingsPage, selectedPathwayEventDate);
});
