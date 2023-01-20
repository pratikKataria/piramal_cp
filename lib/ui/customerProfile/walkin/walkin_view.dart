import 'package:piramal_channel_partner/ui/customerProfile/customer_profile_view.dart';
import 'package:piramal_channel_partner/ui/customerProfile/walkin/model/chatresponse.dart';

abstract class WalkinView implements CustomerProfileView {
  void onWalkinCommentFetched(List<Chatresponse> projectListResponse);
  void onCommentAddError(String error);
  void onCommentAdded();
  void onNoVisitFound();
}
