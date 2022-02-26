import 'package:piramal_channel_partner/ui/core/core_view.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/document_upload_response.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/signup_response.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/terms_and_condition_response.dart';

abstract class UploadDocumentView implements CoreView {
  void onDocumentUploaded(DocumentUploadResponse documentUploadResponse);
  void onTypeOfFirmFetched(List<String> brList);
  void onSignupSuccessfully(SignupResponse signupResponse);
  void onTermsAndConditionFetched(TermsAndConditionResponse termsAndConditionResponse);
}
