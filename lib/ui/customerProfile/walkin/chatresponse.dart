/// SitevisitName : "asdtyuik - Piramal Revanta"
/// SiteVisitID : "a1Cp00000024WHAEA2"
/// returnCode : true
/// message : "Success"
/// DateOfVisit : "2021-11-10T09:34:31.000Z"
/// AllFeedbacks : "2022-02-12: this is a new comment from sm\r\n2022-02-12: this a comment by broker (CP)\r\n2022-02-12: Testing For comments test 3\r\n2022-02-01: Testing For comments test 2\r\n2022-02-01: Testing For Aniket test 1"

class Chatresponse {
  Chatresponse({
      String sitevisitName, 
      String siteVisitID, 
      bool returnCode, 
      String message, 
      String dateOfVisit, 
      String allFeedbacks,}){
    _sitevisitName = sitevisitName;
    _siteVisitID = siteVisitID;
    _returnCode = returnCode;
    _message = message;
    _dateOfVisit = dateOfVisit;
    _allFeedbacks = allFeedbacks;
}

  Chatresponse.fromJson(dynamic json) {
    _sitevisitName = json['SitevisitName'];
    _siteVisitID = json['SiteVisitID'];
    _returnCode = json['returnCode'];
    _message = json['message'];
    _dateOfVisit = json['DateOfVisit'];
    _allFeedbacks = json['AllFeedbacks'];
  }
  String _sitevisitName;
  String _siteVisitID;
  bool _returnCode;
  String _message;
  String _dateOfVisit;
  String _allFeedbacks;

  String get sitevisitName => _sitevisitName;
  String get siteVisitID => _siteVisitID;
  bool get returnCode => _returnCode;
  String get message => _message;
  String get dateOfVisit => _dateOfVisit;
  String get allFeedbacks => _allFeedbacks;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['SitevisitName'] = _sitevisitName;
    map['SiteVisitID'] = _siteVisitID;
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    map['DateOfVisit'] = _dateOfVisit;
    map['AllFeedbacks'] = _allFeedbacks;
    return map;
  }

}