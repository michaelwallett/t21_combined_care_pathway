import 'package:age_calculator/age_calculator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/pathway_month.dart';
import '../providers/pathway_events_provider.dart';
import '../providers/user_settings_provider.dart';
import '../models/pathway_event.dart';
import '../models/pathway_event_date.dart';
import '../models/user_settings.dart';

List<PathwayMonth> _getPathwayMonths(
    UserSettings userSettings, List<PathwayEvent> pathwayEvents) {
  DateTime dateOfBirth = userSettings.dateOfBirth ?? DateTime(2021, 2, 8);
  DateTime dateAtAge18 =
      DateTime(dateOfBirth.year + 18, dateOfBirth.month, dateOfBirth.day);

  List<PathwayMonth> pathwayMonths = [];
  List<PathwayEventDate> matchedPathwayEventDates = [];

  var currentDate = dateOfBirth;

  do {
    var currentMonth = currentDate.month;
    var pathwayMonthTitle = DateFormat.yMMMM().format(currentDate);

    do {
      var age = AgeCalculator.age(dateOfBirth, today: currentDate);

      matchedPathwayEventDates.addAll(pathwayEvents.where((pathwayEvent) {
        return pathwayEvent.ageIntervals.any((schedule) {
          return age.years == schedule.years &&
              age.months == schedule.months &&
              age.days == 0;
        });
      }).map((pathwayEvent) => PathwayEventDate(pathwayEvent, currentDate)));

      currentDate = currentDate.add(const Duration(days: 1));
    } while (currentMonth == currentDate.month);

    if (matchedPathwayEventDates.isNotEmpty) {
      pathwayMonths
          .add(PathwayMonth(pathwayMonthTitle, matchedPathwayEventDates));

      matchedPathwayEventDates = [];
    }
  } while (currentDate.isBefore(dateAtAge18));

  return pathwayMonths;
}

final pathwayMonthsProvider = FutureProvider<List<PathwayMonth>>((ref) async {
  final userSettings = await ref.watch(userSettingsProvider.future);
  final pathwayEvents = await ref.watch(pathwayEventsProvider.future);

  return _getPathwayMonths(userSettings, pathwayEvents);
});
