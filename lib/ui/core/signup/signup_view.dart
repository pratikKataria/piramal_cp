import 'package:piramal_channel_partner/ui/core/login/model/token_response.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/relation_manager_list_response.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/signup_response.dart';

import '../core_view.dart';

abstract class SignupView implements CoreView {
  void onTokenGenerated(TokenResponse tokenResponse);
  void onSignupSuccessfully(SignupResponse signupResponse);
  void onRelationManagerListFetched(RelationManagerListResponse relationManagerListResponse);
}
