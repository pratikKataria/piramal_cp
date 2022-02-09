

import 'package:piramal_channel_partner/ui/base/BaseView.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/booking_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/project_unit_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/schedule_visit_response.dart';
import 'package:piramal_channel_partner/ui/core/login/model/token_response.dart';
import 'package:piramal_channel_partner/ui/cpEvent/model/cp_event_response.dart';

abstract class HomeView extends BaseView{
  void onBookingListFetched(List<BookingResponse> brList);
  void onWalkInListFetched(List<BookingResponse> brList);
  void onTokenRegenerated(TokenResponse tokenResponse);
  void onSiteVisitScheduled(ScheduleVisitResponse visitResponse);
  void onEventFetched(List<CpEventResponse> brList) {}
  void onProjectUnitResponseFetched(ProjectUnitResponse projectUnitResponse);
}