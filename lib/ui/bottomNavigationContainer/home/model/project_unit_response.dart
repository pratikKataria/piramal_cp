/// TowerFinalized : "Vidya"
/// TotalAgreementValue : 1000.0
/// sfdcid : "0065j00000cms2RAAQ"
/// returnCode : true
/// PaymentConfirmationByCP : true
/// PaymentByBN : true
/// Payment_to_Broker_by_BN_Status : "Done"
/// Payment_detail : "test_utr_num"
/// Payment_date : "2022-10-22"
/// message : "Success"
/// carpetarea : null
/// BrokerageRecordId : "a2J5j000000wq0jEAA"
/// ApartmentFinalized : "9999"
/// Amount_Paid : 99999.5

class ProjectUnitResponse {
  ProjectUnitResponse({
      String towerFinalized, 
      num totalAgreementValue, 
      String sfdcid, 
      bool returnCode, 
      bool paymentConfirmationByCP, 
      bool paymentByBN, 
      String paymentToBrokerByBNStatus, 
      String paymentDetail, 
      String paymentDate, 
      String message, 
      dynamic carpetarea, 
      String brokerageRecordId, 
      String apartmentFinalized, 
      num amountPaid,}){
    _towerFinalized = towerFinalized;
    _totalAgreementValue = totalAgreementValue;
    _sfdcid = sfdcid;
    _returnCode = returnCode;
    _paymentConfirmationByCP = paymentConfirmationByCP;
    _paymentByBN = paymentByBN;
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
    _paymentByBN = json['PaymentByBN'];
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
  num _totalAgreementValue;
  String _sfdcid;
  bool _returnCode;
  bool _paymentConfirmationByCP;
  bool _paymentByBN;
  String _paymentToBrokerByBNStatus;
  String _paymentDetail;
  String _paymentDate;
  String _message;
  dynamic _carpetarea;
  String _brokerageRecordId;
  String _apartmentFinalized;
  num _amountPaid;
ProjectUnitResponse copyWith({  String towerFinalized,
  num totalAgreementValue,
  String sfdcid,
  bool returnCode,
  bool paymentConfirmationByCP,
  bool paymentByBN,
  String paymentToBrokerByBNStatus,
  String paymentDetail,
  String paymentDate,
  String message,
  dynamic carpetarea,
  String brokerageRecordId,
  String apartmentFinalized,
  num amountPaid,
}) => ProjectUnitResponse(  towerFinalized: towerFinalized ?? _towerFinalized,
  totalAgreementValue: totalAgreementValue ?? _totalAgreementValue,
  sfdcid: sfdcid ?? _sfdcid,
  returnCode: returnCode ?? _returnCode,
  paymentConfirmationByCP: paymentConfirmationByCP ?? _paymentConfirmationByCP,
  paymentByBN: paymentByBN ?? _paymentByBN,
  paymentToBrokerByBNStatus: paymentToBrokerByBNStatus ?? _paymentToBrokerByBNStatus,
  paymentDetail: paymentDetail ?? _paymentDetail,
  paymentDate: paymentDate ?? _paymentDate,
  message: message ?? _message,
  carpetarea: carpetarea ?? _carpetarea,
  brokerageRecordId: brokerageRecordId ?? _brokerageRecordId,
  apartmentFinalized: apartmentFinalized ?? _apartmentFinalized,
  amountPaid: amountPaid ?? _amountPaid,
);
  String get towerFinalized => _towerFinalized;
  num get totalAgreementValue => _totalAgreementValue;
  String get sfdcid => _sfdcid;
  bool get returnCode => _returnCode;
  bool get paymentConfirmationByCP => _paymentConfirmationByCP;
  bool get paymentByBN => _paymentByBN;
  String get paymentToBrokerByBNStatus => _paymentToBrokerByBNStatus;
  String get paymentDetail => _paymentDetail;
  String get paymentDate => _paymentDate;
  String get message => _message;
  dynamic get carpetarea => _carpetarea;
  String get brokerageRecordId => _brokerageRecordId;
  String get apartmentFinalized => _apartmentFinalized;
  num get amountPaid => _amountPaid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TowerFinalized'] = _towerFinalized;
    map['TotalAgreementValue'] = _totalAgreementValue;
    map['sfdcid'] = _sfdcid;
    map['returnCode'] = _returnCode;
    map['PaymentConfirmationByCP'] = _paymentConfirmationByCP;
    map['PaymentByBN'] = _paymentByBN;
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