import 'package:piramal_channel_partner/ui/base/BaseView.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/notificationSc/model/notification_response.dart';

abstract class NotificationView extends BaseView {
  void onNotificationListFetched(NotificationResponse response);
}
