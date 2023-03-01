import 'package:piramal_channel_partner/ui/base/BaseView.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/notificationSc/model/notification_read_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/notificationSc/model/notification_response.dart';

import 'model/upload_file_response.dart';

abstract class UploadView extends BaseView {
  void onFileUploaded(UploadFileResponse response);
}
