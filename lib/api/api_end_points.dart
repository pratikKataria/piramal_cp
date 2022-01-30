/// 🔥 MVP Architecture🔥
/// 🍴 Focused on Clean Architecture
/// Created by 🔱 Pratik Kataria 🔱 on 12-08-2021.
class EndPoints {
  static const String BASE_URL = 'https://prl--prlapp.my.salesforce.com/services/apexrest';

  static const String ACCESS_TOKEN = 'https://test.salesforce.com/services/oauth2/token';
  static const String EMAIL_LOGIN = BASE_URL + "/CP_Mobile_App/EmailLoginCP";
  static const String MOBILE_LOGIN = BASE_URL + "/CP_Mobile_App/MobileLogincp";
  static const String SEND_OTP = BASE_URL + "/CP_Mobile_App/EmailOTPCP";
  static const String VERIFY_EMAIL = BASE_URL + "/CP_Mobile_App/EmailLoginCP";

  static const String GET_BOOKING = BASE_URL + "/CP_Mobile_App/OpportunityDetails";
  static const String GET_WALK_IN = BASE_URL + "/CP_Mobile_App/WalkinOpportunityDetails";
  static const String SCHEDULE_VISIT = BASE_URL + "/CP_Mobile_App/Createactivityschedulesv";
  static const String UNIT_DETAIL = BASE_URL + "/CP_Mobile_App/CustomerUnitdetails";

}
