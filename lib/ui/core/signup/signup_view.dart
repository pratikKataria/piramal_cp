import 'package:piramal_channel_partner/ui/core/signup/model/relation_manager_list_response.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/signup_response.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/terms_and_condition_response.dart';

import '../core_view.dart';

abstract class SignupView implements CoreView {
  void onSignupSuccessfully(SignupResponse signupResponse);
  void onRelationManagerListFetched(List<RelationManagerListResponse> brList);
  void onOtpSent(int otp, int provider);
  void onTermsAndConditionFetched(TermsAndConditionResponse termsAndConditionResponse);
}
