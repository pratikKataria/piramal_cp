import 'package:piramal_channel_partner/ui/customerProfile/customer_profile_view.dart';
import 'package:piramal_channel_partner/ui/customerProfile/walkin/chatresponse.dart';

abstract class WalkinView implements CustomerProfileView {
  onWalkinCommentFetched(List<Chatresponse> projectListResponse);
  onCommentAddError(String error);
  void onCommentAdded();
}
