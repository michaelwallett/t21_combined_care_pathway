import 'package:auto_route/auto_route.dart';
import 'user_settings/user_settings_page.dart';
import 'welcome/welcome_page.dart';
import 'pathway_event_list/pathway_event_list_page.dart';
import 'pathway_event_details/pathway_event_details_page.dart';

@MaterialAutoRouter(replaceInRouteName: 'Page,Route', routes: <AutoRoute>[
  AutoRoute(page: WelcomePage, initial: true),
  AutoRoute(page: PathwayEventListPage, path: '/events'),
  CustomRoute(
      page: PathwayEventDetailsPage,
      transitionsBuilder: TransitionsBuilders.slideLeft),
  AutoRoute(page: UserSettingsPage, path: '/settings')
])
class $AppRouter {}
