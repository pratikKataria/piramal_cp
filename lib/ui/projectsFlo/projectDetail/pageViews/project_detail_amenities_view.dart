import 'package:piramal_channel_partner/ui/projectsFlo/projectDetail/model/project_amenities_response.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/project_marker_interface.dart';

abstract class ProjectDetailAmenitiesView implements ProjectMarkerInterface {
  void onProjectAmenitiesFetched(ProjectAmenitiesResponse projectAmenitiesResponse);
}
