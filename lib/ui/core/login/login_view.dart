import 'package:piramal_channel_partner/ui/core/login/model/login_response.dart';
import 'package:piramal_channel_partner/ui/core/login/model/token_response.dart';

import '../core_view.dart';

abstract class LoginView implements CoreView {
  onTokenGenerated(TokenResponse tokenResponse);
  onOtpSent(int otp);
  onEmailVerified(LoginResponse loginResponse);
}
