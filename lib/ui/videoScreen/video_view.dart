import 'package:piramal_channel_partner/ui/base/BaseView.dart';
import 'package:piramal_channel_partner/ui/videoScreen/model/video_response_model.dart';

abstract class VideoView extends BaseView {
  void onVideoListFetched(List<DetailsList> detailsList) {}
}
