/// TowerFinalized : "Vind"
/// TotalAgreementValue : 2000.00
/// sfdcid : "006p000000BG5SAAA1"
/// returnCode : true
/// PaymentConfirmationByCP : true
/// Payment_to_Broker_by_BN_Status : "Done"
/// Payment_detail : "UTR"
/// Payment_date : "2022-09-15"
/// message : "Success"
/// carpetarea : 10000.00
/// BrokerageRecordId : "a2vp0000000QDdvAAG"
/// ApartmentFinalized : "103"
/// Amount_Paid : 40.00

class ProjectUnitResponse {
  ProjectUnitResponse({
      String towerFinalized, 
      double totalAgreementValue, 
      String sfdcid, 
      bool returnCode, 
      bool paymentConfirmationByCP, 
      String paymentToBrokerByBNStatus, 
      String paymentDetail, 
      String paymentDate, 
      String message, 
      double carpetarea, 
      String brokerageRecordId, 
      String apartmentFinalized, 
      double amountPaid,}){
    _towerFinalized = towerFinalized;
    _totalAgreementValue = totalAgreementValue;
    _sfdcid = sfdcid;
    _returnCode = returnCode;
    _paymentConfirmationByCP = paymentConfirmationByCP;
    _paymentToBrokerByBNStatus = paymentToBrokerByBNStatus;
    _paymentDetail = paymentDetail;
    _paymentDate = paymentDate;
    _message = message;
    _carpetarea = carpetarea;
    _brokerageRecordId = brokerageRecordId;
    _apartmentFinalized = apartmentFinalized;
    _amountPaid = amountPaid;
}

  ProjectUnitResponse.fromJson(dynamic json) {
    _towerFinalized = json['TowerFinalized'];
    _totalAgreementValue = json['TotalAgreementValue'];
    _sfdcid = json['sfdcid'];
    _returnCode = json['returnCode'];
    _paymentConfirmationByCP = json['PaymentConfirmationByCP'];
    _paymentToBrokerByBNStatus = json['Payment_to_Broker_by_BN_Status'];
    _paymentDetail = json['Payment_detail'];
    _paymentDate = json['Payment_date'];
    _message = json['message'];
    _carpetarea = json['carpetarea'];
    _brokerageRecordId = json['BrokerageRecordId'];
    _apartmentFinalized = json['ApartmentFinalized'];
    _amountPaid = json['Amount_Paid'];
  }
  String _towerFinalized;
  double _totalAgreementValue;
  String _sfdcid;
  bool _returnCode;
  bool _paymentConfirmationByCP;
  String _paymentToBrokerByBNStatus;
  String _paymentDetail;
  String _paymentDate;
  String _message;
  double _carpetarea;
  String _brokerageRecordId;
  String _apartmentFinalized;
  double _amountPaid;

  String get towerFinalized => _towerFinalized;
  double get totalAgreementValue => _totalAgreementValue;
  String get sfdcid => _sfdcid;
  bool get returnCode => _returnCode;
  bool get paymentConfirmationByCP => _paymentConfirmationByCP;
  String get paymentToBrokerByBNStatus => _paymentToBrokerByBNStatus;
  String get paymentDetail => _paymentDetail;
  String get paymentDate => _paymentDate;
  String get message => _message;
  double get carpetarea => _carpetarea;
  String get brokerageRecordId => _brokerageRecordId;
  String get apartmentFinalized => _apartmentFinalized;
  double get amountPaid => _amountPaid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TowerFinalized'] = _towerFinalized;
    map['TotalAgreementValue'] = _totalAgreementValue;
    map['sfdcid'] = _sfdcid;
    map['returnCode'] = _returnCode;
    map['PaymentConfirmationByCP'] = _paymentConfirmationByCP;
    map['Payment_to_Broker_by_BN_Status'] = _paymentToBrokerByBNStatus;
    map['Payment_detail'] = _paymentDetail;
    map['Payment_date'] = _paymentDate;
    map['message'] = _message;
    map['carpetarea'] = _carpetarea;
    map['BrokerageRecordId'] = _brokerageRecordId;
    map['ApartmentFinalized'] = _apartmentFinalized;
    map['Amount_Paid'] = _amountPaid;
    return map;
  }

}