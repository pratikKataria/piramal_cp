import 'package:piramal_channel_partner/ui/base/BaseView.dart';
import 'package:piramal_channel_partner/ui/currentPromotions/model/current_promo_response.dart';

abstract class CurrentPromoView extends BaseView {
  void onCurrentPromoListFetched(List<CurrentPromoResponse> projectListResponse);
}
