import 'package:piramal_channel_partner/ui/base/BaseView.dart';
import 'package:piramal_channel_partner/ui/lead/model/all_lead_response.dart';

abstract class LeadView extends BaseView{
  void onAllLeadFetched(List<AllLeadResponse> brList);
}