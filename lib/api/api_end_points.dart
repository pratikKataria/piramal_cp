import 'package:piramal_channel_partner/env/environment_values.dart';

/// 🔥 MVP Architecture🔥
/// 🍴 Focused on Clean Architecture
/// Created by 🔱 Pratik Kataria 🔱 on 12-08-2021.
class EndPoints {
  static final String BASE_URL = EnvironmentValues.getBaseURL;
  static final String ACCESS_TOKEN = EnvironmentValues.getAccessTokenURL;

  /*Prod*/
  static final String GET_ACCOUNT_STATUS = BASE_URL + "/CP_Mobile_App/NewCpApplicationStatus";
  static final String POST_DEVICE_TOKEN = BASE_URL + "/CP_Mobile_App/deviceTokenCPAPP";
  static final String EMAIL_LOGIN = BASE_URL + "/CP_Mobile_App/EmailLoginCP";
  static final String MOBILE_LOGIN = BASE_URL + "/CP_Mobile_App/MobileLogincp";
  static final String SEND_OTP = BASE_URL + "/CP_Mobile_App/EmailOTPCP";
  static final String SEND_OTP_V1 = BASE_URL + "/CP_Mobile_App/CreateEmailOTPCP";
  static final String SEND_OTP_V2 = BASE_URL + "/CP_Mobile_App/SignUpEmailOTPCP";
  static final String VERIFY_EMAIL = BASE_URL + "/CP_Mobile_App/EmailLoginCP";
  static final String VERIFY_MOBILE = BASE_URL + "/CP_Mobile_App/MobileLogincp";
  static final String SEND_MOBILE_OTP = "https://bulkpush.mytoday.com/BulkSms/SingleMsgApi?";
  static final String GET_BOOKING = BASE_URL + "/CP_Mobile_App/OpportunityDetails";
  static final String DueInvoices = BASE_URL + "/CP_Mobile_App/Due_Invoice_Opportunities";
  static final String GET_WALK_IN = BASE_URL + "/CP_Mobile_App/WalkinOpportunityDetails";
  static final String SCHEDULE_VISIT = BASE_URL + "/CP_Mobile_App/ScheduleSiteVisits";
  static final String UNIT_DETAIL = BASE_URL + "/CP_Mobile_App/CustomerUnitdetails";
  static final String PAYMENT_CONFIRMATION = BASE_URL + "/CP_Mobile_App/PaymentConfirmationByCP";
  static final String ALL_LEAD_LIST = BASE_URL + "/CP_Mobile_App/Allleaddetails";
  static final String DELETE_LEAD = BASE_URL + "/CP_Mobile_App/DeleteCplead";
  static final String CREATE_LEAD = BASE_URL + "/CP_Mobile_App/CPLeadDetails";
  static final String CP_EVENT_LIST = BASE_URL + "/CP_Mobile_App/CPEvents";
  static final String CP_EVENT_AVAILABILITY = BASE_URL + "/CP_Mobile_App/CPEventsAvailability";
  static final String ALL_PROJECT_LIST = BASE_URL + "/CP_Mobile_App/Projects";
  static final String CURRENT_PROMOTIONS = BASE_URL + "/CP_Mobile_App/CurrentPromotionsDetails";
  static final String PROJECT_AMENITIES = BASE_URL + "/CP_Mobile_App/ProjectAmenities";
  static final String PROJECT_OVERVIEW = BASE_URL + "/CP_Mobile_App/ProjectOverview";
  static final String PROJECT_TOWER = BASE_URL + "/CP_Mobile_App/ProjectTowers";
  static final String PROJECT_GALLERY = BASE_URL + "/CP_Mobile_App/ProjectGallery";
  static final String PROJECT_UNIT_DETAILS = BASE_URL + "/CP_Mobile_App/CustomerUnitdetails";
  static final String GET_R_MANAGER_LIST = BASE_URL + "/CP_Mobile_App/RManagerList";
  static final String SIGN_UP = BASE_URL + "/CP_Mobile_App/CPEmpanelmentSignup";
  static final String CP_EMP_DOC_UPLOAD = BASE_URL + "/CP_Mobile_App/CPEmpalDocUpload";
  static final String MY_ASSIST = BASE_URL + "/CP_Mobile_App/MyAssist";
  static final String MY_PROFILE = BASE_URL + "/CP_Mobile_App/ProfileDetails";
  static final String TODAY_SV = BASE_URL + "/CP_Mobile_App/TodaysScheduleSite";
  static final String GET_PICK_LIST = BASE_URL + "/CP_Mobile_App/CPPicklistVal";
  static final String GET_INVOICE = BASE_URL + "/CP_Mobile_App/Invoice";
  static final String COMPLETE_TAGGING = BASE_URL + "/CP_Mobile_App/CompleteTagging";
  static final String GET_COMMENTS = BASE_URL + "/CP_Mobile_App/Allfeedback";
  static final String ADD_COMMENTS = BASE_URL + "/CP_Mobile_App/createcpcomments";
  static final String PROFILE_PIC_UPLOAD = BASE_URL + "/CP_Mobile_App/ProfilePicUpdate";
  static final String TERMS_AND_CONDITION = BASE_URL + "/CP_Mobile_App/TermsAndConditions";
  static final String PROJECT_IMAGES = BASE_URL + "/CP_Mobile_App/ProjectPic";
  static final String GET_PROJECT_DOWNLOAD_LINK = BASE_URL + "/CP_Mobile_App/Download";
  static final String NOTIFICATION_LIST = BASE_URL + "/CP_Mobile_App/CPNotificationList";
  static final String READ_NOTIFICATION = BASE_URL + "/CP_Mobile_App/CPNotificationMarkRead";
  static final String GET_CONFIGURATION_BY_PROJECT = BASE_URL + "/CP_Mobile_App/DependentPickListCPLead";
  static final String PROJECT_OVERVIEW_IMAGES = BASE_URL + "/CP_Mobile_App/DownloadImage";
  static final String SIGNUP_VALIDATION_CHECK = BASE_URL + "/CP_Mobile_App/SignUpValidation";
  static final String TYPE_OF_FIRM = BASE_URL + "/CP_Mobile_App/DependentPickListTypeOfFirm";
  static final String POST_DOCUMENTS_SIGNUP = BASE_URL + "/CP_Mobile_App/CPDocumentUpload";
  static final String POST_PENDING_DOCUMENTS = BASE_URL + "/CP_Mobile_App/AccountDocumentUpload";
  static final String POST_GENERATE_INVOICE = BASE_URL + "/CP_Mobile_App/GenerateInvoice";
  static final String POST_INVOICE_TERMS_AND_CONDITION = BASE_URL + "/CP_Mobile_App/InvoiceDownloadtermsAndConditions";
  static final String POST_SAVE_INVOICE_NO = BASE_URL + "/CP_Mobile_App/InvoiceNumber";
  static final String DOWNLOAD_LWC = BASE_URL + "/CP_Mobile_App/brochureDownloadLWC";
  static final String UPLOAD = BASE_URL + "/CP_Mobile_App/addCPDocuments";
  static final String CP_APP_CONSTRUCTION_UPDATES = BASE_URL + "/CP_Mobile_App/CP_App_Construction_Updates";
  static final String CP_APP_OFFER_VIDEOS = BASE_URL + "/CP_Mobile_App/CP_App_Offer_Videos";
  static final String CP_CURRENT_PROMO_BLOCKER = BASE_URL + "/CP_Mobile_App/CP_App_Page_Bloclkers";
  static final String CP_APP_BANNER = BASE_URL + "/CP_Mobile_App/CP_App_Banner";

  //Ticket Module
  static final String GET_TICKETS = BASE_URL + "/CP_Mobile_App/getCPCasesList";
  static final String POST_CREATE_TICKET = BASE_URL + "/CP_Mobile_App/createCaseCPApp";
  static final String POST_SUB_CATEGORY = BASE_URL + "/CP_Mobile_App/caseCategoryCPApp";
  static final String CP_TICKET_PICKLIST = BASE_URL + "/CP_Mobile_App/CPAppPicklistValues";
  static final String CP_TICKET_CASE_SUB_TYPE = BASE_URL + "/CP_Mobile_App/caseSubTypesCPApp";
  static final String CP_TICKET_CASE_DETAILS = BASE_URL + "/CP_Mobile_App/getCaseDetails";
  static final String POST_CATEGORY = BASE_URL + "/MyticketAllCategory";
  static final String POST_REOPEN_TICKET = BASE_URL + "/CP_Mobile_App/reOpenCPAppCase";
  static final String SUBMIT_FEEDBACK = BASE_URL + "/CP_Mobile_App/cpCaseFeedback";


}
