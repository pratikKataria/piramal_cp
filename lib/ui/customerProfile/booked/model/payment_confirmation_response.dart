/// returnCode : true
/// PaymentConfirmationByCP : false
/// PaymentByBN : true
/// message : "Payment is confirmed by CP."

class PaymentConfirmationResponse {
  PaymentConfirmationResponse({
      bool returnCode, 
      bool paymentConfirmationByCP, 
      bool paymentByBN, 
      String message,}){
    _returnCode = returnCode;
    _paymentConfirmationByCP = paymentConfirmationByCP;
    _paymentByBN = paymentByBN;
    _message = message;
}

  PaymentConfirmationResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _paymentConfirmationByCP = json['PaymentConfirmationByCP'];
    _paymentByBN = json['PaymentByBN'];
    _message = json['message'];
  }
  bool _returnCode;
  bool _paymentConfirmationByCP;
  bool _paymentByBN;
  String _message;

  bool get returnCode => _returnCode;
  bool get paymentConfirmationByCP => _paymentConfirmationByCP;
  bool get paymentByBN => _paymentByBN;
  String get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['PaymentConfirmationByCP'] = _paymentConfirmationByCP;
    map['PaymentByBN'] = _paymentByBN;
    map['message'] = _message;
    return map;
  }

}