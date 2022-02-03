

import 'package:piramal_channel_partner/ui/base/BaseView.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/todayFu/model/today_sv_response.dart';

abstract class TodayView extends BaseView{
  void onSvListFetched(List<TodaySvResponse> brList);
}