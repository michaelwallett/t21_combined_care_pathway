import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/pathway_event.dart';
import '../mappers/pathway_event_mapper.dart';

final pathwayEventsProvider = FutureProvider<List<PathwayEvent>>((ref) async {
  var pathwayEventsJson =
      await rootBundle.loadString('assets/pathway_events.json');

  return PathwayEventMapper().fromJson(pathwayEventsJson);
});
