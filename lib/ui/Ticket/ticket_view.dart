import 'package:piramal_channel_partner/ui/Ticket/model/case_subtype_response.dart';
import 'package:piramal_channel_partner/ui/Ticket/model/ticket_detail_response.dart';
import 'package:piramal_channel_partner/ui/Ticket/model/ticket_picklist_response.dart';
import 'package:piramal_channel_partner/ui/base/BaseView.dart';

import 'model/create_ticket_response.dart';
import 'model/reopen_response.dart';
import 'model/ticket_category_response.dart';
import 'model/ticket_response.dart';

abstract class TicketView extends BaseView {
  void onTicketFetched(TicketResponse rmDetailResponse);

  void onTicketCreated(CreateTicketResponse rmDetailResponse);

  void onTicketCategoryFetched(TicketCategoryResponse rmDetailResponse);

  void onSubCategoryFetched(TicketCategoryResponse rmDetailResponse);

  void onTicketReopened(ReopenResponse rmDetailResponse);

  void onTicketPicklistFetched(TicketPicklistResponse rmDetailResponse);

  void caseSubTypeResponse(CaseSubtypeResponse rmDetailResponse);

}
