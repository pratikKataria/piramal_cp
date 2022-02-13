/// Name : "BrokerAccounttest1"
/// PrimaryContactPerson : "Sudhir khadke"
/// PrimaryMobNo : "9402536365"
/// Email : "zxcv@gmail.com"
/// RelationshipManager : "Viral Nandu"
/// Pan : "ABCDE6789B"
/// ReraID : "6789"
/// Typeoffirm : "Private Ltd Co."

class SignupRequest {
  SignupRequest({
      String name, 
      String primaryContactPerson, 
      String primaryMobNo, 
      String email, 
      String relationshipManager, 
      String pan, 
      String reraID, 
      String typeoffirm,}){
    _name = name;
    _primaryContactPerson = primaryContactPerson;
    _primaryMobNo = primaryMobNo;
    _email = email;
    _relationshipManager = relationshipManager;
    _pan = pan;
    _reraID = reraID;
    _typeoffirm = typeoffirm;
}

  SignupRequest.fromJson(dynamic json) {
    _name = json['Name'];
    _primaryContactPerson = json['PrimaryContactPerson'];
    _primaryMobNo = json['PrimaryMobNo'];
    _email = json['Email'];
    _relationshipManager = json['RelationshipManager'];
    _pan = json['Pan'];
    _reraID = json['ReraID'];
    _typeoffirm = json['Typeoffirm'];
  }
  String _name;
  String _primaryContactPerson;
  String _primaryMobNo;
  String _email;
  String _relationshipManager;
  String _pan;
  String _reraID;
  String _typeoffirm;

  String get name => _name;
  String get primaryContactPerson => _primaryContactPerson;
  String get primaryMobNo => _primaryMobNo;
  String get email => _email;
  String get relationshipManager => _relationshipManager;
  String get pan => _pan;
  String get reraID => _reraID;
  String get typeoffirm => _typeoffirm;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Name'] = _name;
    map['PrimaryContactPerson'] = _primaryContactPerson;
    map['PrimaryMobNo'] = _primaryMobNo;
    map['Email'] = _email;
    map['RelationshipManager'] = _relationshipManager;
    map['Pan'] = _pan;
    map['ReraID'] = _reraID;
    map['Typeoffirm'] = "Private Ltd Co.";
    return map;
  }

  set typeoffirm(String value) {
    _typeoffirm = value;
  }

  set reraID(String value) {
    _reraID = value;
  }

  set pan(String value) {
    _pan = value;
  }

  set relationshipManager(String value) {
    _relationshipManager = value;
  }

  set email(String value) {
    _email = value;
  }

  set primaryMobNo(String value) {
    _primaryMobNo = value;
  }

  set primaryContactPerson(String value) {
    _primaryContactPerson = value;
  }

  set name(String value) {
    _name = value;
  }
}