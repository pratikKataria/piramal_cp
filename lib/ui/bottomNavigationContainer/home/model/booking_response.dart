/// TowerFinalized : null
/// StageName : "Booking"
/// sfdcid : "006p00000092NBeAAM"
/// Revisit : false
/// returnCode : true
/// ProjectFinalized : null
/// NewRating : null
/// Name : "test 2 testing"
/// Mobilenumber : "9911223355"
/// message : "Success"
/// CreatedDays : 37
/// ApartmentFinalized : null

class BookingResponse {
  String taskId = "";
  bool dueInvoice = false;

  BookingResponse({
    dynamic towerFinalized,
    String stageName,
    String sfdcid,
    bool revisit,
    bool completeTagging,
    bool returnCode,
    dynamic projectFinalized,
    dynamic newRating,
    String name,
    String mobilenumber,
    String message,
    String nextFollowUp,
    int createdDays,
    String projectInterested,
    dynamic apartmentFinalized,
    bool crmApproved,
  }) {
    _towerFinalized = towerFinalized;
    _stageName = stageName;
    _sfdcid = sfdcid;
    _revisit = revisit;
    _returnCode = returnCode;
    _projectFinalized = projectFinalized;
    _newRating = newRating;
    _name = name;
    _mobilenumber = mobilenumber;
    _message = message;
    _createdDays = createdDays;
    _apartmentFinalized = apartmentFinalized;
    _projectInterested = projectInterested;
    _nextFollowUp = nextFollowUp;
    _completeTagging = completeTagging;
    _CRMApproved = crmApproved;
  }

  BookingResponse.fromJson(dynamic json) {
    _towerFinalized = json['TowerFinalized'];
    _stageName = json['StageName'];
    _sfdcid = json['sfdcid'];
    _revisit = json['Revisit'];
    _returnCode = json['returnCode'];
    _projectFinalized = json['ProjectFinalized'];
    _newRating = json['NewRating'];
    _name = json['Name'];
    _mobilenumber = json['Mobilenumber'];
    _message = json['message'];
    _createdDays = json['CreatedDays'];
    _apartmentFinalized = json['ApartmentFinalized'];
    _projectInterested = json['ProjectInterested'];
    _nextFollowUp = json['NextFollowUp'];
    _completeTagging = json['CompleteTagging'];
    _CRMApproved = json['CRMApproved'];
    dueInvoice = json['Due_Invoice'];
  }

  String _nextFollowUp;
  dynamic _towerFinalized;
  String _stageName;
  String _sfdcid;
  String _projectInterested;
  bool _revisit = false;
  bool _returnCode;
  dynamic _projectFinalized;
  dynamic _newRating;
  String _name;
  String _mobilenumber;
  String _message;
  int _createdDays;
  dynamic _apartmentFinalized;
  bool _completeTagging;
  bool _CRMApproved;


  bool get CRMApproved => _CRMApproved;

  set CRMApproved(bool value) {
    _CRMApproved = value;
  }

  String get nextFollowUp => _nextFollowUp;

  set nextFollowUp(String value) {
    _nextFollowUp = value;
  }

  dynamic get towerFinalized => _towerFinalized;

  String get stageName => _stageName;

  String get sfdcid => _sfdcid;

  bool get revisit => _revisit ?? false;

  bool get returnCode => _returnCode;

  dynamic get projectFinalized => _projectFinalized;

  dynamic get newRating => _newRating;

  String get name => _name;

  String get mobilenumber => _mobilenumber;

  String get message => _message;

  int get createdDays => _createdDays;

  dynamic get apartmentFinalized => _apartmentFinalized;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TowerFinalized'] = _towerFinalized;
    map['StageName'] = _stageName;
    map['sfdcid'] = _sfdcid;
    map['Revisit'] = _revisit;
    map['returnCode'] = _returnCode;
    map['ProjectFinalized'] = _projectFinalized;
    map['NewRating'] = _newRating;
    map['Name'] = _name;
    map['Mobilenumber'] = _mobilenumber;
    map['message'] = _message;
    map['CreatedDays'] = _createdDays;
    map['ApartmentFinalized'] = _apartmentFinalized;
    map['ProjectInterested'] = _projectInterested;
    map['NextFollowUp'] = _nextFollowUp;
    map['CompleteTagging'] = _completeTagging;
    map['CRMApproved'] = _CRMApproved;
    map['Due_Invoice'] = dueInvoice;
    return map;
  }

  set apartmentFinalized(dynamic value) {
    _apartmentFinalized = value;
  }

  set createdDays(int value) {
    _createdDays = value;
  }

  set message(String value) {
    _message = value;
  }

  set mobilenumber(String value) {
    _mobilenumber = value;
  }

  set name(String value) {
    _name = value;
  }

  set newRating(dynamic value) {
    _newRating = value;
  }

  set projectFinalized(dynamic value) {
    _projectFinalized = value;
  }

  set returnCode(bool value) {
    _returnCode = value;
  }

  set revisit(bool value) {
    _revisit = value;
  }

  set sfdcid(String value) {
    _sfdcid = value;
  }

  set stageName(String value) {
    _stageName = value;
  }

  set towerFinalized(dynamic value) {
    _towerFinalized = value;
  }

  bool get completeTagging => _completeTagging;

  set completeTagging(bool value) {
    _completeTagging = value;
  }

  String get projectInterested => _projectInterested;
}
