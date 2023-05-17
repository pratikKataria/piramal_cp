import 'package:piramal_channel_partner/api/api_error_view.dart';
import 'package:piramal_channel_partner/ui/base/BaseView.dart';
import 'package:piramal_channel_partner/ui/constructionUpdates/model/construction_update_response.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectList/model/project_list_response.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/project_marker_interface.dart';

abstract class ConstructionUpdateView extends BaseView{
  void onConstructionImagesFetched(List<ConUpdateList> conUpdateList);
}
