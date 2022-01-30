

import 'package:piramal_channel_partner/ui/base/BaseView.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/booking_response.dart';
import 'package:piramal_channel_partner/ui/core/login/model/token_response.dart';

abstract class HomeView extends BaseView{
  void onBookingListFetched(List<BookingResponse> brList);
  void onWalkInListFetched(List<BookingResponse> brList);
  void onTokenRegenerated(TokenResponse tokenResponse);
}