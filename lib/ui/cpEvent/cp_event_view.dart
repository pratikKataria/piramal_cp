import 'package:piramal_channel_partner/ui/lead/lead_marker_interface.dart';

import 'model/cp_event_response.dart';

abstract class CPEventView extends LeadMarkerInterface{
  void onEventFetched(List<CpEventResponse> response);
}