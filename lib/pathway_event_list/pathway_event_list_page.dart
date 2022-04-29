import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import '../router.gr.dart';
import '../shared/providers/pathway_months_provider.dart';
import '../shared/models/pathway_event_type.dart';
import '../shared/models/pathway_month.dart';

class PathwayEventListPage extends HookConsumerWidget {
  const PathwayEventListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pathwayMonthsAsyncValue = ref.watch(pathwayMonthsProvider);

    return pathwayMonthsAsyncValue.when(
        data: (pathwayMonths) {
          return Scaffold(
              appBar: AppBar(title: const Text('T21 Pathway')),
              drawer: Drawer(
                  child: ListView(children: [
                const DrawerHeader(
                    decoration: BoxDecoration(color: Colors.blue),
                    child: Text('T21 Pathway',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ))),
                ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: () {
                      context.router.popAndPush(UserSettingsRoute());
                    })
              ])),
              body: _getList(pathwayMonths, ref));
        },
        loading: () => const CircularProgressIndicator(),
        error: (err, _) => const Text('Oops'));
  }

  ListView _getList(List<PathwayMonth> pathwayMonths, WidgetRef ref) {
    return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: pathwayMonths.length,
        itemBuilder: (BuildContext context, int index) {
          var pathwayMonth = pathwayMonths[index];

          return Column(children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(pathwayMonth.title,
                  style: Theme.of(context).textTheme.headline6),
            ),
            Column(
                children: pathwayMonth.eventDates.map((pathwayEventDate) {
              return Card(
                child: Column(
                  children: [
                    ListTile(
                        leading: _getEventIcon(pathwayEventDate.event.type),
                        title: Text(pathwayEventDate.event.title),
                        subtitle: Text(
                            DateFormat.yMMMMd().format(pathwayEventDate.date)),
                        trailing: IconButton(
                            onPressed: () {
                              context.pushRoute(PathwayEventDetailsRoute(
                                  pathwayEventDate: pathwayEventDate));
                            },
                            icon: const Icon(Icons.info_outline)))
                  ],
                ),
              );
            }).toList())
          ]);
        });
  }

  Icon _getEventIcon(PathwayEventType eventType) {
    if (eventType == PathwayEventType.birthday) {
      return const Icon(Icons.cake);
    }

    return const Icon(Icons.event);
  }
}
