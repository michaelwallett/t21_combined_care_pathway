// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;

import 'pathway_event_details/pathway_event_details_page.dart' as _i3;
import 'pathway_event_list/pathway_event_list_page.dart' as _i2;
import 'shared/models/pathway_event_date.dart' as _i7;
import 'user_settings/user_settings_page.dart' as _i4;
import 'welcome/welcome_page.dart' as _i1;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    WelcomeRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.WelcomePage());
    },
    PathwayEventListRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.PathwayEventListPage());
    },
    PathwayEventDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<PathwayEventDetailsRouteArgs>();
      return _i5.CustomPage<dynamic>(
          routeData: routeData,
          child: _i3.PathwayEventDetailsPage(
              key: args.key, pathwayEventDate: args.pathwayEventDate),
          transitionsBuilder: _i5.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    UserSettingsRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.UserSettingsPage());
    }
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(WelcomeRoute.name, path: '/'),
        _i5.RouteConfig(PathwayEventListRoute.name, path: '/events'),
        _i5.RouteConfig(PathwayEventDetailsRoute.name,
            path: '/pathway-event-details-page'),
        _i5.RouteConfig(UserSettingsRoute.name, path: '/settings')
      ];
}

/// generated route for
/// [_i1.WelcomePage]
class WelcomeRoute extends _i5.PageRouteInfo<void> {
  const WelcomeRoute() : super(WelcomeRoute.name, path: '/');

  static const String name = 'WelcomeRoute';
}

/// generated route for
/// [_i2.PathwayEventListPage]
class PathwayEventListRoute extends _i5.PageRouteInfo<void> {
  const PathwayEventListRoute()
      : super(PathwayEventListRoute.name, path: '/events');

  static const String name = 'PathwayEventListRoute';
}

/// generated route for
/// [_i3.PathwayEventDetailsPage]
class PathwayEventDetailsRoute
    extends _i5.PageRouteInfo<PathwayEventDetailsRouteArgs> {
  PathwayEventDetailsRoute(
      {_i6.Key? key, required _i7.PathwayEventDate pathwayEventDate})
      : super(PathwayEventDetailsRoute.name,
            path: '/pathway-event-details-page',
            args: PathwayEventDetailsRouteArgs(
                key: key, pathwayEventDate: pathwayEventDate));

  static const String name = 'PathwayEventDetailsRoute';
}

class PathwayEventDetailsRouteArgs {
  const PathwayEventDetailsRouteArgs(
      {this.key, required this.pathwayEventDate});

  final _i6.Key? key;

  final _i7.PathwayEventDate pathwayEventDate;

  @override
  String toString() {
    return 'PathwayEventDetailsRouteArgs{key: $key, pathwayEventDate: $pathwayEventDate}';
  }
}

/// generated route for
/// [_i4.UserSettingsPage]
class UserSettingsRoute extends _i5.PageRouteInfo<void> {
  const UserSettingsRoute() : super(UserSettingsRoute.name, path: '/settings');

  static const String name = 'UserSettingsRoute';
}
