import 'package:piramal_channel_partner/ui/base/BaseView.dart';
import 'package:piramal_channel_partner/ui/myProfile/model/my_profile_response.dart';

abstract class MyProfileView extends BaseView {
  void onProfileDataFetch(MyProfileResponse myAssistResponse);
  void onProfileUploaded();
}
