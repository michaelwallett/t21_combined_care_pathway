import 'package:t21_combined_care_pathway/shared/models/pathway_event_date.dart';

class NavigationPages {
  bool showWelcomePage;
  bool showPathwayEventListPage;
  bool showUserSettingsPage;
  PathwayEventDate? selectedPathwayEventDate;

  NavigationPages(this.showWelcomePage, this.showPathwayEventListPage,
      this.showUserSettingsPage, this.selectedPathwayEventDate);
}
