import 'package:piramal_channel_partner/ui/projectsFlo/projectDetail/model/project_overview_response.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/project_marker_interface.dart';

abstract class ProjectDetailOverviewView implements ProjectMarkerInterface {
  void onProjectOverviewDetailsFetched(ProjectOverviewResponse projectOverviewResponse);
}
