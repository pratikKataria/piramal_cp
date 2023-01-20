import 'package:piramal_channel_partner/ui/core/login/model/login_response.dart';
import 'package:piramal_channel_partner/ui/core/login/model/token_response.dart';

import '../core_view.dart';

abstract class LoginView implements CoreView  {
  void onOtpSent(int otp);
  void onVerificationSuccess(LoginResponse loginResponse);
  void onTokenGenerated2(TokenResponse tokenResponse);
  void onVerificationFailed();
}
