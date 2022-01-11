import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/pathway_event_type.dart';
import '../models/pathway_event_date.dart';

class PathwayEventDetailsScreen extends StatelessWidget {
  final PathwayEventDate pathwayEventDate;

  const PathwayEventDetailsScreen({Key? key, required this.pathwayEventDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('T21 Combined Care Pathway')),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(children: [
                ListTile(
                    leading: getEventIcon(pathwayEventDate.event.type),
                    title: Text(pathwayEventDate.event.title,
                        style: Theme.of(context).textTheme.headline5),
                    subtitle: Text(
                        DateFormat.yMMMMd().format(pathwayEventDate.date))),
                ListTile(
                    leading: const Icon(Icons.help_outline),
                    title: Text(pathwayEventDate.event.generalInfo)),
                ListTile(
                    leading: const Icon(Icons.medical_services_outlined),
                    title: Text(pathwayEventDate.event.medicalInfo)),
                Column(
                  children: pathwayEventDate.event.infoLinks.map((link) {
                    return ListTile(
                        leading: const Icon(Icons.link_outlined),
                        title: InkWell(
                            onTap: () {
                              launch(link.url);
                            },
                            child: Text(link.title,
                                style: const TextStyle(color: Colors.blue))));
                  }).toList(),
                )
              ]),
            )));
  }

  Icon getEventIcon(PathwayEventType eventType) {
    if (eventType == PathwayEventType.birthday) {
      return const Icon(Icons.cake);
    }

    return const Icon(Icons.event);
  }
}
