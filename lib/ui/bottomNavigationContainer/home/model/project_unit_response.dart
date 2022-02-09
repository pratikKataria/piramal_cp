/// TowerFinalized : "Revanta T2"
/// TotalAgreementValue : 1000.00
/// sfdcid : "006N000000DuA69IAF"
/// returnCode : 2
/// message : "Success"
/// carpetarea : 306.55
/// ApartmentFinalized : "401"

class ProjectUnitResponse {
  ProjectUnitResponse({
    String towerFinalized,
    double totalAgreementValue,
    String sfdcid,
    bool returnCode,
    String message,
    double carpetarea,
    String apartmentFinalized,
  }) {
    _towerFinalized = towerFinalized;
    _totalAgreementValue = totalAgreementValue;
    _sfdcid = sfdcid;
    _returnCode = returnCode;
    _message = message;
    _carpetarea = carpetarea;
    _apartmentFinalized = apartmentFinalized;
  }

  ProjectUnitResponse.fromJson(dynamic json) {
    _towerFinalized = json['TowerFinalized'];
    _totalAgreementValue = json['TotalAgreementValue'];
    _sfdcid = json['sfdcid'];
    _returnCode = json['returnCode'];
    _message = json['message'];
    _carpetarea = json['carpetarea'];
    _apartmentFinalized = json['ApartmentFinalized'];
  }

  String _towerFinalized;
  double _totalAgreementValue;
  String _sfdcid;
  bool _returnCode;
  String _message;
  double _carpetarea;
  String _apartmentFinalized;

  String get towerFinalized => _towerFinalized;

  double get totalAgreementValue => _totalAgreementValue;

  String get sfdcid => _sfdcid;

  bool get returnCode => _returnCode;

  String get message => _message;

  double get carpetarea => _carpetarea;

  String get apartmentFinalized => _apartmentFinalized;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TowerFinalized'] = _towerFinalized;
    map['TotalAgreementValue'] = _totalAgreementValue;
    map['sfdcid'] = _sfdcid;
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    map['carpetarea'] = _carpetarea;
    map['ApartmentFinalized'] = _apartmentFinalized;
    return map;
  }
}
