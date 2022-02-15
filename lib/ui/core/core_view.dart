
import 'package:piramal_channel_partner/ui/base/BaseView.dart';

import 'login/model/token_response.dart';

abstract class CoreView extends BaseView {
  void onTokenGenerated(TokenResponse tokenResponse);
}
