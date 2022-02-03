/// ValidDays : 46
/// TowerFinalized : null
/// StageName : "Booking"
/// Revisit : false
/// returnCode : 2
/// Rating : "Cold"
/// ProjectFinalized : "Piramal Mahalaxmi"
/// opportunityID : "006p00000092HDiAAM"
/// Name : "Test Approval v1 - Piramal Mahalaxmi"
/// Mobilenumber : "9911223355"
/// message : "SUCCESS"
/// ApartmentFinalized : null

class TodaySvResponse {
  TodaySvResponse({
      int validDays, 
      dynamic towerFinalized, 
      String stageName, 
      bool revisit, 
      int returnCode, 
      String rating, 
      String projectFinalized, 
      String opportunityID, 
      String name, 
      String mobilenumber, 
      String message, 
      dynamic apartmentFinalized,}){
    _validDays = validDays;
    _towerFinalized = towerFinalized;
    _stageName = stageName;
    _revisit = revisit;
    _returnCode = returnCode;
    _rating = rating;
    _projectFinalized = projectFinalized;
    _opportunityID = opportunityID;
    _name = name;
    _mobilenumber = mobilenumber;
    _message = message;
    _apartmentFinalized = apartmentFinalized;
}

  TodaySvResponse.fromJson(dynamic json) {
    _validDays = json['ValidDays'];
    _towerFinalized = json['TowerFinalized'];
    _stageName = json['StageName'];
    _revisit = json['Revisit'];
    _returnCode = json['returnCode'];
    _rating = json['Rating'];
    _projectFinalized = json['ProjectFinalized'];
    _opportunityID = json['opportunityID'];
    _name = json['Name'];
    _mobilenumber = json['Mobilenumber'];
    _message = json['message'];
    _apartmentFinalized = json['ApartmentFinalized'];
  }
  int _validDays;
  dynamic _towerFinalized;
  String _stageName;
  bool _revisit;
  int _returnCode;
  String _rating;
  String _projectFinalized;
  String _opportunityID;
  String _name;
  String _mobilenumber;
  String _message;
  dynamic _apartmentFinalized;

  int get validDays => _validDays;
  dynamic get towerFinalized => _towerFinalized;
  String get stageName => _stageName;
  bool get revisit => _revisit;
  int get returnCode => _returnCode;
  String get rating => _rating;
  String get projectFinalized => _projectFinalized;
  String get opportunityID => _opportunityID;
  String get name => _name;
  String get mobilenumber => _mobilenumber;
  String get message => _message;
  dynamic get apartmentFinalized => _apartmentFinalized;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ValidDays'] = _validDays;
    map['TowerFinalized'] = _towerFinalized;
    map['StageName'] = _stageName;
    map['Revisit'] = _revisit;
    map['returnCode'] = _returnCode;
    map['Rating'] = _rating;
    map['ProjectFinalized'] = _projectFinalized;
    map['opportunityID'] = _opportunityID;
    map['Name'] = _name;
    map['Mobilenumber'] = _mobilenumber;
    map['message'] = _message;
    map['ApartmentFinalized'] = _apartmentFinalized;
    return map;
  }

}