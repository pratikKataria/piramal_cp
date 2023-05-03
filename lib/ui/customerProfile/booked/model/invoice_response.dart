/// StatusChangeDate : ""
/// Status : "Less than 9.9%"
/// returnCode : true
/// Position : 0
/// message : "Success"
/// CurrentStatus : "Eligible to raise Invoice"
/// BrokerageID : "a2vp0000000Q15aAAC"
/// BookingApprovalDate : ""
///  "InvoiceNumberGenerated": true,
//   "GenerateInvoice": true,
class InvoiceResponse {
  String BookingApprovalDate = "";
  String _statusChangeDate;
  String _status;
  bool _returnCode;
  int _position;
  String _message;
  String _currentStatus;
  String _brokerageID;
  String _bookingApprovalDate;
  bool _invoiceNumberGenerated;
  bool _generatedInvoice;
  bool _showInvoiceNumber;

  bool get showInvoiceNumber => _showInvoiceNumber;
  String get statusChangeDate => _statusChangeDate;
  String get status => _status;
  bool get returnCode => _returnCode;
  int get position => _position;
  String get message => _message;
  String get currentStatus => _currentStatus;
  String get brokerageID => _brokerageID;
  String get bookingApprovalDate => _bookingApprovalDate;
  bool get generatedInvoice => _generatedInvoice;
  bool get invoiceNumberGenerated => _invoiceNumberGenerated;



  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StatusChangeDate'] = _statusChangeDate;
    map['Status'] = _status;
    map['returnCode'] = _returnCode;
    map['Position'] = _position;
    map['message'] = _message;
    map['CurrentStatus'] = _currentStatus;
    map['BrokerageID'] = _brokerageID;
    map['BookingApprovalDate'] = _bookingApprovalDate;
    map['InvoiceNumberGenerated'] = _invoiceNumberGenerated;
    map['GenerateInvoice'] = _generatedInvoice;
    map['ShowInvoiceNumber'] = _showInvoiceNumber;
    map['BookingApprovalDate'] = BookingApprovalDate;

    return map;
  }

  InvoiceResponse.fromJson(dynamic json) {
    _statusChangeDate = json['StatusChangeDate'];
    _status = json['Status'];
    _returnCode = json['returnCode'];
    _position = json['Position'];
    _message = json['message'];
    _currentStatus = json['CurrentStatus'];
    _brokerageID = json['BrokerageID'];
    _bookingApprovalDate = json['BookingApprovalDate'];
    _invoiceNumberGenerated = json['InvoiceNumberGenerated'];
    _generatedInvoice = json['GenerateInvoice'];
    _showInvoiceNumber = json['ShowInvoiceNumber'];
    BookingApprovalDate = json['BookingApprovalDates'];
  }
}
