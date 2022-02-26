import 'package:piramal_channel_partner/ui/projectsFlo/projectDetail/model/project_download_response.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectDetail/pageViews/project_detail_amenities_view.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectDetail/pageViews/project_detail_overview_view.dart';

import 'model/project_overview_images_response.dart';
import 'model/project_tower_response.dart';

abstract class ProjectDetailView implements ProjectDetailOverviewView, ProjectDetailAmenitiesView {
  void onProjectTowerListFetched(List<ProjectTowerResponse> projectListResponse);
  void onProjectDownloadListFetched(List<ProjectDownloadResponse> projectDownloadResponse);
  void onProjectImagesFetched(List<ProjectOverviewImagesResponse> brList);
}
