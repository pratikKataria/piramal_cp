import 'package:piramal_channel_partner/ui/Ticket/model/ticket_detail_response.dart';
import 'package:piramal_channel_partner/ui/Ticket/ticket_view.dart';

abstract class TicketDetailView extends TicketView {
   void onTicketDetailsFetched(List<TicketDetailResponse> brList );

}
