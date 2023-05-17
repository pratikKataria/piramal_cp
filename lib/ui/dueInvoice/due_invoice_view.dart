import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/booking_response.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectList/model/project_list_response.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/project_marker_interface.dart';

abstract class DueInvoice extends ProjectMarkerInterface {
  void onProjectListFetched(List<ProjectListResponse> projectListResponse);
  void onBookingListFetched(List<BookingResponse> brList);
}
