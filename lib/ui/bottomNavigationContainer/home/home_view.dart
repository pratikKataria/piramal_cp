

import 'package:piramal_channel_partner/ui/base/BaseView.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/account_status_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/booking_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/cp_banner_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/project_unit_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/schedule_visit_response.dart';
import 'package:piramal_channel_partner/ui/core/login/model/token_response.dart';
import 'package:piramal_channel_partner/ui/cpEvent/model/cp_event_response.dart';

import 'model/current_promotion_blocker_response.dart';

abstract class HomeView extends BaseView{
  void onBookingListFetched(List<BookingResponse> brList);
  void onWalkInListFetched(List<BookingResponse> brList);
  void onTokenRegenerated(TokenResponse tokenResponse);
  void onSiteVisitScheduled(ScheduleVisitResponse visitResponse);
  void onEventFetched(List<BannerDataList> bannerDataList);
  void onProjectUnitResponseFetched(ProjectUnitResponse projectUnitResponse);
  void onTaggingDone();
  void onAccountStatusChecked(AccountStatusResponse projectUnitResponse);
  void onPaymentAcknowledged();
  void noEventPresent();
  void onCurrentPromotionPageBlockerDataFetched(List<PageBlockerList> pageBlockersImagesList);
}