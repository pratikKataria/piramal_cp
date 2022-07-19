/// returnCode : true
/// message : "Invoice Generated"
/// GenerateInvoice : true

class GenerateInvoiceResponse {
  GenerateInvoiceResponse({
      bool returnCode, 
      String message, 
      bool generateInvoice,}){
    _returnCode = returnCode;
    _message = message;
    _generateInvoice = generateInvoice;
}

  GenerateInvoiceResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _message = json['message'];
    _generateInvoice = json['GenerateInvoice'];
  }
  bool _returnCode;
  String _message;
  bool _generateInvoice;

  bool get returnCode => _returnCode;
  String get message => _message;
  bool get generateInvoice => _generateInvoice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    map['GenerateInvoice'] = _generateInvoice;
    return map;
  }
}