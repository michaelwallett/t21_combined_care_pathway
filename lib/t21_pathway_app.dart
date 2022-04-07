import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'shared/models/pathway_event_date.dart';
import 'pathway_event_details/pathway_event_details_page.dart';
import 'pathway_event_list/pathway_event_list_page.dart';
import 'shared/providers/selected_pathway_event_date_provider.dart';
import 'shared/providers/show_user_settings_provider.dart';
import 'user_settings/user_settings_page.dart';

class T21PathwayApp extends ConsumerStatefulWidget {
  const T21PathwayApp({Key? key}) : super(key: key);

  @override
  _T21PathwayAppState createState() => _T21PathwayAppState();
}

class _T21PathwayAppState extends ConsumerState<T21PathwayApp> {
  @override
  Widget build(BuildContext context) {
    final showUserSettings = ref.watch(showUserSettingsProvider);
    final selectedPathwayEventDate =
        ref.watch(selectedPathwayEventDateProvider);

    return MaterialApp(
        title: 'T21 Combined Care Pathway',
        debugShowCheckedModeBanner: false,
        home: Navigator(
            pages: [
              PathwayEventListPage(
                  _onPathwayEventDateSelected, _onShowUserSettingsSelected),
              if (selectedPathwayEventDate != null)
                PathwayEventDetailsPage(selectedPathwayEventDate),
              if (showUserSettings) UserSettingsPage()
            ],
            onPopPage: (route, result) {
              if (!route.didPop(result)) {
                return false;
              }

              ref.read(selectedPathwayEventDateProvider.notifier).state = null;
              ref.read(showUserSettingsProvider.notifier).state = false;

              return true;
            }));
  }

  void _onPathwayEventDateSelected(PathwayEventDate pathwayEventDate) {
    ref.read(selectedPathwayEventDateProvider.notifier).state =
        pathwayEventDate;
  }

  void _onShowUserSettingsSelected(bool showUserDetails) {
    ref.read(showUserSettingsProvider.notifier).state = showUserDetails;
  }
}
