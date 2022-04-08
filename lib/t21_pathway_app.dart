import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:t21_combined_care_pathway/splash/splash_page.dart';
import 'package:t21_combined_care_pathway/welcome/welcome_page.dart';
import 'pathway_event_details/pathway_event_details_page.dart';
import 'pathway_event_list/pathway_event_list_page.dart';
import 'shared/providers/show_welcome_page_provider.dart';
import 'user_settings/user_settings_page.dart';
import 'shared/providers/selected_pathway_event_date_provider.dart';
import 'shared/providers/show_user_settings_page_provider.dart';

class T21PathwayApp extends HookConsumerWidget {
  const T21PathwayApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showUserSettingsPage = ref.watch(showUserSettingsPageProvider);
    final showWelcomePageAsyncValue = ref.watch(showWelcomePageProvider);
    final selectedPathwayEventDate =
        ref.watch(selectedPathwayEventDateProvider);

    return MaterialApp(
        title: 'T21 Pathway',
        debugShowCheckedModeBanner: false,
        home: SafeArea(
            child: showWelcomePageAsyncValue.when(
                data: (showWelcomePage) {
                  return Navigator(
                      pages: [
                        SplashPage(),
                        if (showWelcomePage) WelcomePage(),
                        if (!showWelcomePage) PathwayEventListPage(),
                        if (showUserSettingsPage) UserSettingsPage(),
                        if (selectedPathwayEventDate != null)
                          PathwayEventDetailsPage(selectedPathwayEventDate)
                      ],
                      onPopPage: (route, result) {
                        if (!route.didPop(result)) {
                          return false;
                        }

                        ref
                            .read(selectedPathwayEventDateProvider.notifier)
                            .state = null;
                        ref.read(showUserSettingsPageProvider.notifier).state =
                            false;

                        return true;
                      });
                },
                loading: () => const CircularProgressIndicator(),
                error: (err, _) => const Text('Oops'))));
  }
}
