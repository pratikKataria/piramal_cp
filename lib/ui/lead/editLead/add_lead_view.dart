import 'package:piramal_channel_partner/ui/lead/lead_marker_interface.dart';

import 'model/pick_list_response.dart';

abstract class AddLeadView extends LeadMarkerInterface {
  void onLeadCreated();
  void onPickListFetched(List<PickListResponse> pickListResponse);
}
