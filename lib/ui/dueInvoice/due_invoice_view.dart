import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/home_view.dart';
import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/booking_response.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectList/model/project_list_response.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/project_marker_interface.dart';

import 'model/invoices_response.dart';

abstract class DueInvoiceView extends HomeView {
  void onProjectListFetched(List<ProjectListResponse> projectListResponse);
  void onBookingListFetched(List<BookingResponse> brList);
  void onInvoicesListFetched(InvoicesResponse brList);
}
