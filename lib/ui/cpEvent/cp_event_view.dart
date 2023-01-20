import 'package:piramal_channel_partner/ui/cpEvent/model/cp_event_status_update_response.dart';
import 'package:piramal_channel_partner/ui/lead/lead_marker_interface.dart';

import 'model/cp_event_response.dart';

abstract class CPEventView extends LeadMarkerInterface{
  void onEventFetched(List<CpEventResponse> response);
  void onCpEventStatusUpdated(CpEventStatusUpdateResponse response);
}