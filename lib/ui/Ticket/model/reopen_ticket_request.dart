/// CaseId : "500p000000BoUISAA3"
/// Reason : "test reopen"
/// fileType : "pdf"
/// attachFile : ""

class ReopenTicketRequest {
  ReopenTicketRequest({
      String caseId, 
      String reason, 
      String fileType, 
      String attachFile,}){
    _caseId = caseId;
    _reason = reason;
    _fileType = fileType;
    _attachFile = attachFile;
}

  ReopenTicketRequest.fromJson(dynamic json) {
    _caseId = json['CaseId'];
    _reason = json['Reason'];
    _fileType = json['fileType'];
    _attachFile = json['attachFile'];
  }
  String _caseId;
  String _reason;
  String _fileType;
  String _attachFile;
ReopenTicketRequest copyWith({  String caseId,
  String reason,
  String fileType,
  String attachFile,
}) => ReopenTicketRequest(  caseId: caseId ?? _caseId,
  reason: reason ?? _reason,
  fileType: fileType ?? _fileType,
  attachFile: attachFile ?? _attachFile,
);
  String get caseId => _caseId;
  String get reason => _reason;
  String get fileType => _fileType;
  String get attachFile => _attachFile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CaseId'] = _caseId;
    map['Reason'] = _reason;
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

  set reason(String value) {
    _reason = value;
  }

  set caseId(String value) {
    _caseId = value;
  }
}