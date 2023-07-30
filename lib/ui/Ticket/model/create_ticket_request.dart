/// CustomerAccountId : "001p000000yQ4QO"
/// caseType : "Brokerage related"
/// caseSubType : "Delay in payment"
/// Source : "Others"
/// Category : "Email"
/// Description : "test create case"
/// fileType : "pdf"
/// attachFile : ""

class CreateTicketRequest {
  String requestType;
  bool selected = false;
  CreateTicketRequest({
      String customerAccountId, 
      String caseType, 
      String caseSubType, 
      String source, 
      String category, 
      String description, 
      String fileType, 
      String attachFile,}){
    _customerAccountId = customerAccountId;
    _caseType = caseType;
    _caseSubType = caseSubType;
    _source = source;
    _category = category;
    _description = description;
    _fileType = fileType;
    _attachFile = attachFile;
}

  CreateTicketRequest.fromJson(dynamic json) {
    _customerAccountId = json['CustomerAccountId'];
    _caseType = json['caseType'];
    _caseSubType = json['caseSubType'];
    _source = json['Source'];
    _category = json['Category'];
    _description = json['Description'];
    _fileType = json['fileType'];
    _attachFile = json['attachFile'];
  }
  String _customerAccountId;
  String _caseType;
  String _caseSubType;
  String _source;
  String _category;
  String _description;
  String _fileType;
  String _attachFile;
CreateTicketRequest copyWith({  String customerAccountId,
  String caseType,
  String caseSubType,
  String source,
  String category,
  String description,
  String fileType,
  String attachFile,
}) => CreateTicketRequest(  customerAccountId: customerAccountId ?? _customerAccountId,
  caseType: caseType ?? _caseType,
  caseSubType: caseSubType ?? _caseSubType,
  source: source ?? _source,
  category: category ?? _category,
  description: description ?? _description,
  fileType: fileType ?? _fileType,
  attachFile: attachFile ?? _attachFile,
);
  String get customerAccountId => _customerAccountId;
  String get caseType => _caseType;
  String get caseSubType => _caseSubType;
  String get source => _source;
  String get category => _category;
  String get description => _description;
  String get fileType => _fileType;
  String get attachFile => _attachFile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CustomerAccountId'] = _customerAccountId;
    map['caseType'] = _caseType;
    map['caseSubType'] = _caseSubType;
    map['Source'] = _source;
    map['Category'] = _category;
    map['Description'] = _description;
    map['fileType'] = _fileType;
    map['attachFile'] = _attachFile;
    return map;
  }

  set attachFile(String value) {
    _attachFile = value;
  }

  set fileType(String value) {
    _fileType = value;
  }

  set description(String value) {
    _description = value;
  }

  set category(String value) {
    _category = value;
  }

  set source(String value) {
    _source = value;
  }

  set caseSubType(String value) {
    _caseSubType = value;
  }

  set caseType(String value) {
    _caseType = value;
  }

  set customerAccountId(String value) {
    _customerAccountId = value;
  }
}