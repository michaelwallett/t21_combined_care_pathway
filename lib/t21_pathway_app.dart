import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'pathway_event_details/pathway_event_details_page.dart';
import 'pathway_event_list/pathway_event_list_page.dart';
import 'user_settings/user_settings_page.dart';
import 'shared/providers/selected_pathway_event_date_provider.dart';
import 'shared/providers/show_user_settings_provider.dart';

class T21PathwayApp extends HookConsumerWidget {
  const T21PathwayApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showUserSettings = ref.watch(showUserSettingsProvider);
    final selectedPathwayEventDate =
        ref.watch(selectedPathwayEventDateProvider);

    return MaterialApp(
        title: 'T21 Combined Care Pathway',
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Navigator(
              pages: [
                PathwayEventListPage(),
                if (selectedPathwayEventDate != null)
                  PathwayEventDetailsPage(selectedPathwayEventDate),
                if (showUserSettings) UserSettingsPage()
              ],
              onPopPage: (route, result) {
                if (!route.didPop(result)) {
                  return false;
                }

                ref.read(selectedPathwayEventDateProvider.notifier).state =
                    null;
                ref.read(showUserSettingsProvider.notifier).state = false;

                return true;
              }),
        ));
  }
}
