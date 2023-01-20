import 'package:piramal_channel_partner/ui/lead/lead_marker_interface.dart';
import 'package:piramal_channel_partner/ui/lead/model/all_lead_response.dart';

abstract class LeadView extends LeadMarkerInterface{
  void onAllLeadFetched(List<AllLeadResponse> brList);
  void onLeadDeleted(AllLeadResponse response);
}