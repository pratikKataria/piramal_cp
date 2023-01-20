import 'package:piramal_channel_partner/ui/base/BaseView.dart';
import 'package:piramal_channel_partner/ui/base/model/LwcDownloadResponse.dart';

abstract class LwcView extends BaseView {
  onLwcLinkFetched(LwcDownloadResponse response);
}
