/// 🔥 MVP Architecture🔥
/// 🍴 Focused on Clean Architecture
/// Created by 🔱 Pratik Kataria 🔱 on 12-08-2021.
class EndPoints {
  static const String BASE_URL = 'https://prl--PRLAPP.my.salesforce.com/services/apexrest';

  static const String ACCESS_TOKEN = 'https://test.salesforce.com/services/oauth2/token';
  static const String GET_ACCOUNT_STATUS = BASE_URL + "/CP_Mobile_App/NewCpApplicationStatus";
  static const String POST_DEVICE_TOKEN = BASE_URL + "/CP_Mobile_App/deviceTokenCPAPP";
  static const String EMAIL_LOGIN = BASE_URL + "/CP_Mobile_App/EmailLoginCP";
  static const String MOBILE_LOGIN = BASE_URL + "/CP_Mobile_App/MobileLogincp";
  static const String SEND_OTP = BASE_URL + "/CP_Mobile_App/EmailOTPCP";
  static const String SEND_OTP_V1 = BASE_URL + "/CP_Mobile_App/CreateEmailOTPCP";
  static const String VERIFY_EMAIL = BASE_URL + "/CP_Mobile_App/EmailLoginCP";
  static const String VERIFY_MOBILE = BASE_URL + "/CP_Mobile_App/MobileLogincp";
  static const String SEND_MOBILE_OTP = "https://bulkpush.mytoday.com/BulkSms/SingleMsgApi?";
  static const String GET_BOOKING = BASE_URL + "/CP_Mobile_App/OpportunityDetails";
  static const String GET_WALK_IN = BASE_URL + "/CP_Mobile_App/WalkinOpportunityDetails";
  static const String SCHEDULE_VISIT = BASE_URL + "/CP_Mobile_App/ScheduleSiteVisits";
  static const String UNIT_DETAIL = BASE_URL + "/CP_Mobile_App/CustomerUnitdetails";
  static const String ALL_LEAD_LIST = BASE_URL + "/CP_Mobile_App/Allleaddetails";
  static const String DELETE_LEAD = BASE_URL + "/CP_Mobile_App/DeleteCplead";
  static const String CREATE_LEAD = BASE_URL + "/CP_Mobile_App/CPLeadDetails";
  static const String CP_EVENT_LIST = BASE_URL + "/CP_Mobile_App/CPEvents";
  static const String CP_EVENT_AVAILABILITY = BASE_URL + "/CP_Mobile_App/CPEventsAvailability";
  static const String ALL_PROJECT_LIST = BASE_URL + "/CP_Mobile_App/Projects";
  static const String CURRENT_PROMOTIONS = BASE_URL + "/CP_Mobile_App/CurrentPromotions";/*Details*/
  static const String PROJECT_AMENITIES = BASE_URL + "/CP_Mobile_App/ProjectAmenities";
  static const String PROJECT_OVERVIEW = BASE_URL + "/CP_Mobile_App/ProjectOverview";
  static const String PROJECT_TOWER = BASE_URL + "/CP_Mobile_App/ProjectTowers";
  static const String PROJECT_GALLERY = BASE_URL + "/CP_Mobile_App/ProjectGallery";
  static const String PROJECT_UNIT_DETAILS = BASE_URL + "/CP_Mobile_App/CustomerUnitdetails";
  static const String GET_R_MANAGER_LIST = BASE_URL + "/CP_Mobile_App/RManagerList";
  static const String SIGN_UP = BASE_URL + "/CP_Mobile_App/CPEmpanelmentSignup";
  static const String CP_EMP_DOC_UPLOAD = BASE_URL + "/CP_Mobile_App/CPEmpalDocUpload";
  static const String MY_ASSIST = BASE_URL + "/CP_Mobile_App/MyAssist";
  static const String MY_PROFILE = BASE_URL + "/CP_Mobile_App/ProfileDetails";
  static const String TODAY_SV = BASE_URL + "/CP_Mobile_App/TodaysScheduleSite";
  static const String GET_PICK_LIST = BASE_URL + "/CP_Mobile_App/CPPicklistVal";
  static const String GET_INVOICE = BASE_URL + "/CP_Mobile_App/Invoice";
  static const String COMPLETE_TAGGING = BASE_URL + "/CP_Mobile_App/CompleteTagging";
  static const String GET_COMMENTS = BASE_URL + "/CP_Mobile_App/Allfeedback";
  static const String ADD_COMMENTS = BASE_URL + "/CP_Mobile_App/createcpcomments";
  static const String PROFILE_PIC_UPLOAD = BASE_URL + "/CP_Mobile_App/ProfilePicUpdate";
  static const String TERMS_AND_CONDITION = BASE_URL + "/CP_Mobile_App/TermsAndConditions";
  static const String PROJECT_IMAGES = BASE_URL + "/CP_Mobile_App/ProjectPic";
  static const String GET_PROJECT_DOWNLOAD_LINK = BASE_URL + "/CP_Mobile_App/Download";
  static const String NOTIFICATION_LIST = BASE_URL + "/CP_Mobile_App/CPNotificationList";
  static const String READ_NOTIFICATION = BASE_URL + "/CP_Mobile_App/CPNotificationList";
}
