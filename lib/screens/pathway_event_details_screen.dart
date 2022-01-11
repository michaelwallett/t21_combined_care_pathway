import 'package:flutter/material.dart';
import '../models/pathway_event_date.dart';

class PathwayEventDetailsScreen extends StatelessWidget {
  final PathwayEventDate pathwayEventDate;

  const PathwayEventDetailsScreen({Key? key, required this.pathwayEventDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('T21 Combined Care Pathway')),
        body: Text(pathwayEventDate.event.title));
  }
}
