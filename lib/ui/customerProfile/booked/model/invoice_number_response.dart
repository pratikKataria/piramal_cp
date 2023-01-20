/// returnCode : false
/// message : "Invoice Number already entered."
/// InvoiceNumber : "IN0000016"
/// InvoiceGenerated : true

class InvoiceNumberResponse {
  InvoiceNumberResponse({
      bool returnCode, 
      String message, 
      String invoiceNumber, 
      bool invoiceGenerated,}){
    _returnCode = returnCode;
    _message = message;
    _invoiceNumber = invoiceNumber;
    _invoiceGenerated = invoiceGenerated;
}

  bool _returnCode;
  String _message;
  String _invoiceNumber;
  bool _invoiceGenerated;

  bool get returnCode => _returnCode;
  String get message => _message;
  String get invoiceNumber => _invoiceNumber;
  bool get invoiceGenerated => _invoiceGenerated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    map['InvoiceNumber'] = _invoiceNumber;
    map['InvoiceGenerated'] = _invoiceGenerated;
    return map;
  }

  InvoiceNumberResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _message = json['message'];
    _invoiceNumber = json['InvoiceNumber'];
    _invoiceGenerated = json['InvoiceGenerated'];
  }

}