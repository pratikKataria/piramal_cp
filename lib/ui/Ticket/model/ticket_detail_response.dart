/// Status : "Open"
/// returnCode : true
/// Position : ""
/// message : "Success"
/// Description : "test create case 21"
/// createdDate : "21/7/2023 07:20 PM"
/// caseNumber : "00008434"
/// caseFileLink : ""

class TicketDetailResponse {
  TicketDetailResponse({
      String status, 
      bool returnCode, 
      String position, 
      String message, 
      String description, 
      String createdDate, 
      String caseNumber, 
      String caseFileLink,}){
    _status = status;
    _returnCode = returnCode;
    _position = position;
    _message = message;
    _description = description;
    _createdDate = createdDate;
    _caseNumber = caseNumber;
    _caseFileLink = caseFileLink;
}

  TicketDetailResponse.fromJson(dynamic json) {
    _status = json['Status'];
    _returnCode = json['returnCode'];
    _position = json['Position'];
    _message = json['message'];
    _description = json['Description'];
    _createdDate = json['createdDate'];
    _caseNumber = json['caseNumber'];
    _caseFileLink = json['caseFileLink'];
  }
  String _status;
  bool _returnCode;
  String _position;
  String _message;
  String _description;
  String _createdDate;
  String _caseNumber;
  String _caseFileLink;
TicketDetailResponse copyWith({  String status,
  bool returnCode,
  String position,
  String message,
  String description,
  String createdDate,
  String caseNumber,
  String caseFileLink,
}) => TicketDetailResponse(  status: status ?? _status,
  returnCode: returnCode ?? _returnCode,
  position: position ?? _position,
  message: message ?? _message,
  description: description ?? _description,
  createdDate: createdDate ?? _createdDate,
  caseNumber: caseNumber ?? _caseNumber,
  caseFileLink: caseFileLink ?? _caseFileLink,
);
  String get status => _status;
  bool get returnCode => _returnCode;
  String get position => _position;
  String get message => _message;
  String get description => _description;
  String get createdDate => _createdDate;
  String get caseNumber => _caseNumber;
  String get caseFileLink => _caseFileLink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = _status;
    map['returnCode'] = _returnCode;
    map['Position'] = _position;
    map['message'] = _message;
    map['Description'] = _description;
    map['createdDate'] = _createdDate;
    map['caseNumber'] = _caseNumber;
    map['caseFileLink'] = _caseFileLink;
    return map;
  }

}