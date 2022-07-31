

class InvoiceNumberRequest {
  String _brokerId;
  String _otyId;
  String _invoiceNumber;

  InvoiceNumberRequest();

  String get invoiceNumber => _invoiceNumber;
  String get otyId => _otyId;
  String get brokerId => _brokerId;


  set invoiceNumber(String value) {
    _invoiceNumber = value;
  }

  set otyId(String value) {
    _otyId = value;
  }

  set brokerId(String value) {
    _brokerId = value;
  }
}