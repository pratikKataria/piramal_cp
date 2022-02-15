/// ValidDays : -90
/// TowerFinalized : ""
/// taskid : "00Tp000000HpO5AEAV"
/// subject : "Schedule Site Visit"
/// StageName : "WalkIn"
/// Revisit : false
/// returnCode : true
/// Rating : ""
/// proposedDateOFVisit : "2022-02-15T18:30:00.000Z"
/// ProjectFinalized : "Piramal Mahalaxmi"
/// opportunityName : ""
/// opportunityID : "006p000000AyCqLAAV"
/// Name : "Opportunity3"
/// Mobilenumber : "9881560816"
/// message : "SUCCESS"
/// CompleteTaggingStatus : true
/// ApartmentFinalized : ""

class TodaySvResponse {
  TodaySvResponse({
      int validDays, 
      String towerFinalized, 
      String taskid, 
      String subject, 
      String stageName, 
      bool revisit, 
      bool returnCode, 
      String rating, 
      String proposedDateOFVisit, 
      String projectFinalized, 
      String opportunityName, 
      String opportunityID, 
      String name, 
      String mobilenumber, 
      String message, 
      bool completeTaggingStatus, 
      String apartmentFinalized,}){
    _validDays = validDays;
    _towerFinalized = towerFinalized;
    _taskid = taskid;
    _subject = subject;
    _stageName = stageName;
    _revisit = revisit;
    _returnCode = returnCode;
    _rating = rating;
    _proposedDateOFVisit = proposedDateOFVisit;
    _projectFinalized = projectFinalized;
    _opportunityName = opportunityName;
    _opportunityID = opportunityID;
    _name = name;
    _mobilenumber = mobilenumber;
    _message = message;
    _completeTaggingStatus = completeTaggingStatus;
    _apartmentFinalized = apartmentFinalized;
}

  TodaySvResponse.fromJson(dynamic json) {
    _validDays = json['ValidDays'];
    _towerFinalized = json['TowerFinalized'];
    _taskid = json['taskid'];
    _subject = json['subject'];
    _stageName = json['StageName'];
    _revisit = json['Revisit'];
    _returnCode = json['returnCode'];
    _rating = json['Rating'];
    _proposedDateOFVisit = json['proposedDateOFVisit'];
    _projectFinalized = json['ProjectFinalized'];
    _opportunityName = json['opportunityName'];
    _opportunityID = json['opportunityID'];
    _name = json['Name'];
    _mobilenumber = json['Mobilenumber'];
    _message = json['message'];
    _completeTaggingStatus = json['CompleteTagging'];
    _apartmentFinalized = json['ApartmentFinalized'];
  }
  int _validDays;
  String _towerFinalized;
  String _taskid;
  String _subject;
  String _stageName;
  bool _revisit;
  bool _returnCode;
  String _rating;
  String _proposedDateOFVisit;
  String _projectFinalized;
  String _opportunityName;
  String _opportunityID;
  String _name;
  String _mobilenumber;
  String _message;
  bool _completeTaggingStatus;
  String _apartmentFinalized;

  int get validDays => _validDays;
  String get towerFinalized => _towerFinalized;
  String get taskid => _taskid;
  String get subject => _subject;
  String get stageName => _stageName;
  bool get revisit => _revisit;
  bool get returnCode => _returnCode;
  String get rating => _rating;
  String get proposedDateOFVisit => _proposedDateOFVisit;
  String get projectFinalized => _projectFinalized;
  String get opportunityName => _opportunityName;
  String get opportunityID => _opportunityID;
  String get name => _name;
  String get mobilenumber => _mobilenumber;
  String get message => _message;
  bool get completeTaggingStatus => _completeTaggingStatus;
  String get apartmentFinalized => _apartmentFinalized;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ValidDays'] = _validDays;
    map['TowerFinalized'] = _towerFinalized;
    map['taskid'] = _taskid;
    map['subject'] = _subject;
    map['StageName'] = _stageName;
    map['Revisit'] = _revisit;
    map['returnCode'] = _returnCode;
    map['Rating'] = _rating;
    map['proposedDateOFVisit'] = _proposedDateOFVisit;
    map['ProjectFinalized'] = _projectFinalized;
    map['opportunityName'] = _opportunityName;
    map['opportunityID'] = _opportunityID;
    map['Name'] = _name;
    map['Mobilenumber'] = _mobilenumber;
    map['message'] = _message;
    map['CompleteTagging'] = _completeTaggingStatus;
    map['ApartmentFinalized'] = _apartmentFinalized;
    return map;
  }

}