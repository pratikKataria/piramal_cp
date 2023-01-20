/// TermsAndCondition : "Aniket I accept the terms and condition as declared as follow:1.will abide with the rules and regulation set by the company and will follow all norms and Guideline set by the company."
/// returnCode : true
/// message : "success"
/// InvoiceDownload : true

class InvoiceTermsAndCondition {
  InvoiceTermsAndCondition({
      String termsAndCondition, 
      bool returnCode, 
      String message, 
      bool invoiceDownload,}){
    _termsAndCondition = termsAndCondition;
    _returnCode = returnCode;
    _message = message;
    _invoiceDownload = invoiceDownload;
}

  InvoiceTermsAndCondition.fromJson(dynamic json) {
    _termsAndCondition = json['TermsAndCondition'];
    _returnCode = json['returnCode'];
    _message = json['message'];
    _invoiceDownload = json['InvoiceDownload'];
  }
  String _termsAndCondition;
  bool _returnCode;
  String _message;
  bool _invoiceDownload;

  String get termsAndCondition => _termsAndCondition;
  bool get returnCode => _returnCode;
  String get message => _message;
  bool get invoiceDownload => _invoiceDownload;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TermsAndCondition'] = _termsAndCondition;
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    map['InvoiceDownload'] = _invoiceDownload;
    return map;
  }

}