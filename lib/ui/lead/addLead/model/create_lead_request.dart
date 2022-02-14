/// Name : "Test Mobile App"
/// ProjectInterested : "Piramal Aranya"
/// Budget : "1.0 Cr - 1.5 Cr"
/// Configuration : "1 BHK"
/// Location : "Mumbai"
/// Mobilenumber : "9960390011"
/// Dateofvisit : "2022-12-2"
/// CustomerAccountId : "001p000000y1SqW"

class CreateLeadRequest {
  CreateLeadRequest({
    String name,
    String projectInterested,
    String budget,
    String configuration,
    String location,
    String mobilenumber,
    String dateofvisit,
    String customerAccountId,
    String accountId,
  }) {
    _name = name;
    _projectInterested = projectInterested;
    _budget = budget;
    _configuration = configuration;
    _location = location;
    _mobilenumber = mobilenumber;
    _dateofvisit = dateofvisit;
    _customerAccountId = customerAccountId;
    _accountId = accountId;
  }

  CreateLeadRequest.fromJson(dynamic json) {
    _name = json['Name'];
    _projectInterested = json['ProjectInterested'];
    _budget = json['Budget'];
    _configuration = json['Configuration'];
    _location = json['Location'];
    _mobilenumber = json['Mobilenumber'];
    _dateofvisit = json['Dateofvisit'];
    _customerAccountId = json['CustomerAccountId'];
    _accountId = json['AccountID'];
  }

  String _name;
  String _projectInterested;
  String _budget;
  String _configuration;
  String _location;
  String _mobilenumber;
  String _dateofvisit;
  String _customerAccountId;
  String _accountId;

  String get name => _name;

  String get projectInterested => _projectInterested;

  String get budget => _budget;

  String get configuration => _configuration;

  String get location => _location;

  String get mobilenumber => _mobilenumber;

  String get dateofvisit => _dateofvisit;

  String get customerAccountId => _customerAccountId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Name'] = _name;
    map['ProjectInterested'] = _projectInterested;
    map['Budget'] = _budget;
    map['Configuration'] = _configuration;
    map['Location'] = _location;
    map['Mobilenumber'] = _mobilenumber;
    map['Dateofvisit'] = _dateofvisit;
    map['CustomerAccountId'] = _customerAccountId;
    map['RecordID'] = _accountId;
    return map;
  }

  set customerAccountId(String value) {
    _customerAccountId = value;
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

  set name(String value) {
    _name = value;
  }

  String get accountId => _accountId;

  set accountId(String value) {
    _accountId = value;
  }
}
