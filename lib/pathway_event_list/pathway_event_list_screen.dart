import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import '../shared/providers/selected_pathway_event_date_provider.dart';
import '../shared/providers/pathway_months_provider.dart';
import '../shared/models/pathway_event_type.dart';
import '../shared/models/pathway_month.dart';
import '../shared/providers/show_user_settings_provider.dart';

class PathwayEventListScreen extends HookConsumerWidget {
  const PathwayEventListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pathwayMonthsAsyncValue = ref.watch(pathwayMonthsProvider);

    return pathwayMonthsAsyncValue.when(
        data: (pathwayMonths) {
          return Scaffold(
              appBar: AppBar(title: const Text('T21 Pathway')),
              drawer: Drawer(
                  child: ListView(
                children: [
                  const DrawerHeader(
                      decoration: BoxDecoration(color: Colors.blue),
                      child: Text('T21 Combined Care Pathway',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ))),
                  ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text('Settings'),
                      onTap: () {
                        Navigator.pop(context);

                        ref.read(showUserSettingsProvider.notifier).state =
                            true;
                      }),
                ],
              )),
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
                              ref
                                  .read(
                                      selectedPathwayEventDateProvider.notifier)
                                  .state = pathwayEventDate;
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
