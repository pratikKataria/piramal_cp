/// Name : "Shankaran"
/// CustomerAccountId : "001p000000zIm0jAAC"
/// ProjectInterested : "Piramal Mahalaxmi"
/// Budget : ">9 Cr"
/// Configuration : "3 BHK(L)"
/// Location : "Mumbai"
/// Mobilenumber : "9405988587"
/// Dateofvisit : "2022-03-29"
/// AccountID : "001p000000zIm0jAAC"
/// EmailID : "test@gmail.com"
/// SubUrban : "Andheri"

class CreateLeadRequest {
  CreateLeadRequest({
      String name, 
      String customerAccountId, 
      String projectInterested, 
      String budget, 
      String configuration, 
      String location, 
      String mobilenumber, 
      String dateofvisit, 
      String accountID, 
      String emailID, 
      String subUrban,}){
    _name = name;
    _customerAccountId = customerAccountId;
    _projectInterested = projectInterested;
    _budget = budget;
    _configuration = configuration;
    _location = location;
    _mobilenumber = mobilenumber;
    _dateofvisit = dateofvisit;
    _accountID = accountID;
    _emailID = emailID;
    _subUrban = subUrban;
}

  CreateLeadRequest.fromJson(dynamic json) {
    _name = json['Name'];
    _customerAccountId = json['CustomerAccountId'];
    _projectInterested = json['ProjectInterested'];
    _budget = json['Budget'];
    _configuration = json['Configuration'];
    _location = json['Location'];
    _mobilenumber = json['Mobilenumber'];
    _dateofvisit = json['Dateofvisit'];
    _accountID = json['AccountID'];
    _emailID = json['EmailID'];
    _subUrban = json['SubUrban'];
  }
  String _name;
  String _customerAccountId;
  String _projectInterested;
  String _budget;
  String _configuration;
  String _location;
  String _mobilenumber;
  String _dateofvisit;
  String _accountID;
  String _emailID;
  String _subUrban;

  String get name => _name;
  String get customerAccountId => _customerAccountId;
  String get projectInterested => _projectInterested;
  String get budget => _budget;
  String get configuration => _configuration;
  String get location => _location;
  String get mobilenumber => _mobilenumber;
  String get dateofvisit => _dateofvisit;
  String get accountID => _accountID;
  String get emailID => _emailID;
  String get subUrban => _subUrban;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Name'] = _name;
    map['CustomerAccountId'] = _customerAccountId;
    map['ProjectInterested'] = _projectInterested;
    map['Budget'] = _budget;
    map['Configuration'] = _configuration;
    map['Location'] = _location;
    map['Mobilenumber'] = _mobilenumber;
    map['Dateofvisit'] = _dateofvisit;
    map['AccountID'] = _accountID;
    map['EmailID'] = _emailID;
    map['SubUrban'] = _subUrban;
    return map;
  }

  set subUrban(String value) {
    _subUrban = value;
  }

  set emailID(String value) {
    _emailID = value;
  }

  set accountID(String value) {
    _accountID = value;
  }

  set dateofvisit(String value) {
    _dateofvisit = value;
  }

  set mobilenumber(String value) {
    _mobilenumber = value;
  }

  set location(String value) {
    _location = value;
  }

  set configuration(String value) {
    _configuration = value;
  }

  set budget(String value) {
    _budget = value;
  }

  set projectInterested(String value) {
    _projectInterested = value;
  }

  set customerAccountId(String value) {
    _customerAccountId = value;
  }

  set name(String value) {
    _name = value;
  }
}