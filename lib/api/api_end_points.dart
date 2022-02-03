/// 🔥 MVP Architecture🔥
/// 🍴 Focused on Clean Architecture
/// Created by 🔱 Pratik Kataria 🔱 on 12-08-2021.
class EndPoints {
  static const String BASE_URL = 'https://prl--PRLAPP.my.salesforce.com/services/apexrest';

  static const String ACCESS_TOKEN = 'https://test.salesforce.com/services/oauth2/token';
  static const String EMAIL_LOGIN = BASE_URL + "/CP_Mobile_App/EmailLoginCP";
  static const String MOBILE_LOGIN = BASE_URL + "/CP_Mobile_App/MobileLogincp";
  static const String SEND_OTP = BASE_URL + "/CP_Mobile_App/EmailOTPCP";
  static const String VERIFY_EMAIL = BASE_URL + "/CP_Mobile_App/EmailLoginCP";
  static const String VERIFY_MOBILE = BASE_URL + "/CP_Mobile_App/MobileLogincp";
  static const String SEND_MOBILE_OTP = "https://bulkpush.mytoday.com/BulkSms/SingleMsgApi?";

  static const String GET_BOOKING = BASE_URL + "/CP_Mobile_App/OpportunityDetails";
  static const String GET_WALK_IN = BASE_URL + "/CP_Mobile_App/WalkinOpportunityDetails";
  static const String SCHEDULE_VISIT = BASE_URL + "/CP_Mobile_App/Createactivityschedulesv";
  static const String UNIT_DETAIL = BASE_URL + "/CP_Mobile_App/CustomerUnitdetails";
  static const String ALL_LEAD_LIST = BASE_URL + "/CP_Mobile_App/Allleaddetails";
  static const String DELETE_LEAD = BASE_URL + "/CP_Mobile_App/DeleteCplead";
  static const String CREATE_LEAD = BASE_URL + "/CP_Mobile_App/CPLeadDetails";
  static const String CP_EVENT_LIST = BASE_URL + "/CP_Mobile_App/CPEvents";
  static const String CP_EVENT_AVAILABILITY = BASE_URL + "/CP_Mobile_App/CPEventsAvailability";
  static const String ALL_PROJECT_LIST = BASE_URL + "/CP_Mobile_App/Projects";
  static const String CURRENT_PROMOTIONS = BASE_URL + "/CP_Mobile_App/CurrentPromotionsDetails";

  static const String MY_ASSIST = BASE_URL + "/CP_Mobile_App/MyAssist";
  static const String MY_PROFILE = BASE_URL + "/CP_Mobile_App/ProfileDetails";
  static const String TODAY_SV = BASE_URL + "/CP_Mobile_App/TodaysScheduleSite";
}
