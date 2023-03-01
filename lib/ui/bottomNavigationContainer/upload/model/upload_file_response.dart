/// returnCode : true
/// message : "success"
/// CP_DocumentId : "a34p0000000ihvVAAQ"

class UploadFileResponse {
  UploadFileResponse({
      bool returnCode, 
      String message, 
      String cPDocumentId,}){
    _returnCode = returnCode;
    _message = message;
    _cPDocumentId = cPDocumentId;
}

  UploadFileResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _message = json['message'];
    _cPDocumentId = json['CP_DocumentId'];
  }
  bool _returnCode;
  String _message;
  String _cPDocumentId;
UploadFileResponse copyWith({  bool returnCode,
  String message,
  String cPDocumentId,
}) => UploadFileResponse(  returnCode: returnCode ?? _returnCode,
  message: message ?? _message,
  cPDocumentId: cPDocumentId ?? _cPDocumentId,
);
  bool get returnCode => _returnCode;
  String get message => _message;
  String get cPDocumentId => _cPDocumentId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    map['CP_DocumentId'] = _cPDocumentId;
    return map;
  }

}