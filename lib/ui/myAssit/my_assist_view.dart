import 'package:piramal_channel_partner/ui/base/BaseView.dart';
import 'package:piramal_channel_partner/ui/myAssit/model/my_assist_response.dart';

abstract class MyAssistView extends BaseView {
  void onAssistDataFetched(List<MyAssistResponse> myAssistResponse);
}
