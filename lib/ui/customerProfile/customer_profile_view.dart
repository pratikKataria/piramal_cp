import 'package:piramal_channel_partner/ui/base/BaseView.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/project_unit_response.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/schedule_visit_response.dart';
import 'package:piramal_channel_partner/ui/customerProfile/booked/model/invoice_response.dart';

abstract class CustomerProfileView extends BaseView {
  void onSiteVisitScheduled(ScheduleVisitResponse visitResponse);
  void onProjectUnitResponseFetched(ProjectUnitResponse projectUnitResponse);
  void onInvoiceDetailFetched(InvoiceResponse projectUnitResponse);
}
