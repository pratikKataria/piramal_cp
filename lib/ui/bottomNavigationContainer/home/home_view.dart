

import 'package:piramal_channel_partner/api/api_error_view.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/booking_response.dart';

abstract class HomeView extends ApiErrorView{
  void onBookingListFetched(List<BookingResponse> brList);
  void onWalkInListFetched();
}