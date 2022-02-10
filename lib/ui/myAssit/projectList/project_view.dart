import 'package:piramal_channel_partner/ui/projectsFlo/projectList/model/project_list_response.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/project_marker_interface.dart';

abstract class ProjectView extends ProjectMarkerInterface {
  void onProjectListFetched(List<ProjectListResponse> projectListResponse);
}
