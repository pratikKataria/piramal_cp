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
  BookingResponse({
      dynamic towerFinalized, 
      String stageName, 
      String sfdcid, 
      bool revisit, 
      bool returnCode, 
      dynamic projectFinalized, 
      dynamic newRating, 
      String name, 
      String mobilenumber, 
      String message, 
      int createdDays, 
      dynamic apartmentFinalized,}){
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
  }
  dynamic _towerFinalized;
  String _stageName;
  String _sfdcid;
  bool _revisit;
  bool _returnCode;
  dynamic _projectFinalized;
  dynamic _newRating;
  String _name;
  String _mobilenumber;
  String _message;
  int _createdDays;
  dynamic _apartmentFinalized;

  dynamic get towerFinalized => _towerFinalized;
  String get stageName => _stageName;
  String get sfdcid => _sfdcid;
  bool get revisit => _revisit;
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
    return map;
  }

}