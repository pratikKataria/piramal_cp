import 'package:piramal_channel_partner/ui/bottomNavigationContainer/home/model/booking_response.dart';

/// returnCode : true
/// paidInvoicesList : [{"TowerFinalized":"South Tower","Status":"Payment Released","StageName":"Booking","sfdcid":"006p000000CDG7pAAH","Revisit":false,"ProjectFinalized":"Piramal Mahalaxmi","NextFollowUp":"","NewRating":"","Name":"Arun-VKN-0C-PM","Mobilenumber":"9167900737","Due_Invoice":true,"CRMApproved":true,"Booking_Date":"2023-04-10","ApartmentFinalized":""}]
/// message : "Success"
/// dueInvoicesList : [{"TowerFinalized":"VYOM","Status":"Eligible to raise Invoice","StageName":"Booking","sfdcid":"006p0000008GSfpAAG","Revisit":false,"ProjectFinalized":"Piramal Vaikunth","NextFollowUp":"","NewRating":"","Name":"Arun-VKN-0C-1003","Mobilenumber":"9167900737","Due_Invoice":true,"CRMApproved":true,"Booking_Date":"2020-04-10","ApartmentFinalized":"1003"}]

class InvoicesResponse {
  InvoicesResponse({
      bool returnCode, 
      List<PaidInvoicesList> paidInvoicesList, 
      String message, 
      List<DueInvoicesList> dueInvoicesList,}){
    _returnCode = returnCode;
    _paidInvoicesList = paidInvoicesList;
    _message = message;
    _dueInvoicesList = dueInvoicesList;
}

  InvoicesResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    if (json['paidInvoicesList'] != null) {
      _paidInvoicesList = [];
      json['paidInvoicesList'].forEach((v) {
        _paidInvoicesList.add(PaidInvoicesList.fromJson(v));
      });
    }
    _message = json['message'];
    if (json['dueInvoicesList'] != null) {
      _dueInvoicesList = [];
      json['dueInvoicesList'].forEach((v) {
        _dueInvoicesList.add(DueInvoicesList.fromJson(v));
      });
    }
  }
  bool _returnCode;
  List<PaidInvoicesList> _paidInvoicesList;
  String _message;
  List<DueInvoicesList> _dueInvoicesList;
InvoicesResponse copyWith({  bool returnCode,
  List<PaidInvoicesList> paidInvoicesList,
  String message,
  List<DueInvoicesList> dueInvoicesList,
}) => InvoicesResponse(  returnCode: returnCode ?? _returnCode,
  paidInvoicesList: paidInvoicesList ?? _paidInvoicesList,
  message: message ?? _message,
  dueInvoicesList: dueInvoicesList ?? _dueInvoicesList,
);
  bool get returnCode => _returnCode;
  List<PaidInvoicesList> get paidInvoicesList => _paidInvoicesList;
  String get message => _message;
  List<DueInvoicesList> get dueInvoicesList => _dueInvoicesList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    if (_paidInvoicesList != null) {
      map['paidInvoicesList'] = _paidInvoicesList.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    if (_dueInvoicesList != null) {
      map['dueInvoicesList'] = _dueInvoicesList.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// TowerFinalized : "VYOM"
/// Status : "Eligible to raise Invoice"
/// StageName : "Booking"
/// sfdcid : "006p0000008GSfpAAG"
/// Revisit : false
/// ProjectFinalized : "Piramal Vaikunth"
/// NextFollowUp : ""
/// NewRating : ""
/// Name : "Arun-VKN-0C-1003"
/// Mobilenumber : "9167900737"
/// Due_Invoice : true
/// CRMApproved : true
/// Booking_Date : "2020-04-10"
/// ApartmentFinalized : "1003"

class DueInvoicesList {
  DueInvoicesList({
      String towerFinalized, 
      String status, 
      String stageName, 
      String sfdcid, 
      bool revisit, 
      String projectFinalized, 
      String nextFollowUp, 
      String newRating, 
      String name, 
      String mobilenumber, 
      bool dueInvoice, 
      bool cRMApproved, 
      String bookingDate, 
      String apartmentFinalized,}){
    _towerFinalized = towerFinalized;
    _status = status;
    _stageName = stageName;
    _sfdcid = sfdcid;
    _revisit = revisit;
    _projectFinalized = projectFinalized;
    _nextFollowUp = nextFollowUp;
    _newRating = newRating;
    _name = name;
    _mobilenumber = mobilenumber;
    _dueInvoice = dueInvoice;
    _cRMApproved = cRMApproved;
    _bookingDate = bookingDate;
    _apartmentFinalized = apartmentFinalized;
}

  DueInvoicesList.fromJson(dynamic json) {
    _towerFinalized = json['TowerFinalized'];
    _status = json['Status'];
    _stageName = json['StageName'];
    _sfdcid = json['sfdcid'];
    _revisit = json['Revisit'];
    _projectFinalized = json['ProjectFinalized'];
    _nextFollowUp = json['NextFollowUp'];
    _newRating = json['NewRating'];
    _name = json['Name'];
    _mobilenumber = json['Mobilenumber'];
    _dueInvoice = json['Due_Invoice'];
    _cRMApproved = json['CRMApproved'];
    _bookingDate = json['Booking_Date'];
    _apartmentFinalized = json['ApartmentFinalized'];
  }
  String _towerFinalized;
  String _status;
  String _stageName;
  String _sfdcid;
  bool _revisit;
  String _projectFinalized;
  String _nextFollowUp;
  String _newRating;
  String _name;
  String _mobilenumber;
  bool _dueInvoice;
  bool _cRMApproved;
  String _bookingDate;
  String _apartmentFinalized;
DueInvoicesList copyWith({  String towerFinalized,
  String status,
  String stageName,
  String sfdcid,
  bool revisit,
  String projectFinalized,
  String nextFollowUp,
  String newRating,
  String name,
  String mobilenumber,
  bool dueInvoice,
  bool cRMApproved,
  String bookingDate,
  String apartmentFinalized,
}) => DueInvoicesList(  towerFinalized: towerFinalized ?? _towerFinalized,
  status: status ?? _status,
  stageName: stageName ?? _stageName,
  sfdcid: sfdcid ?? _sfdcid,
  revisit: revisit ?? _revisit,
  projectFinalized: projectFinalized ?? _projectFinalized,
  nextFollowUp: nextFollowUp ?? _nextFollowUp,
  newRating: newRating ?? _newRating,
  name: name ?? _name,
  mobilenumber: mobilenumber ?? _mobilenumber,
  dueInvoice: dueInvoice ?? _dueInvoice,
  cRMApproved: cRMApproved ?? _cRMApproved,
  bookingDate: bookingDate ?? _bookingDate,
  apartmentFinalized: apartmentFinalized ?? _apartmentFinalized,
);
  String get towerFinalized => _towerFinalized;
  String get status => _status;
  String get stageName => _stageName;
  String get sfdcid => _sfdcid;
  bool get revisit => _revisit;
  String get projectFinalized => _projectFinalized;
  String get nextFollowUp => _nextFollowUp;
  String get newRating => _newRating;
  String get name => _name;
  String get mobilenumber => _mobilenumber;
  bool get dueInvoice => _dueInvoice;
  bool get cRMApproved => _cRMApproved;
  String get bookingDate => _bookingDate;
  String get apartmentFinalized => _apartmentFinalized;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TowerFinalized'] = _towerFinalized;
    map['Status'] = _status;
    map['StageName'] = _stageName;
    map['sfdcid'] = _sfdcid;
    map['Revisit'] = _revisit;
    map['ProjectFinalized'] = _projectFinalized;
    map['NextFollowUp'] = _nextFollowUp;
    map['NewRating'] = _newRating;
    map['Name'] = _name;
    map['Mobilenumber'] = _mobilenumber;
    map['Due_Invoice'] = _dueInvoice;
    map['CRMApproved'] = _cRMApproved;
    map['Booking_Date'] = _bookingDate;
    map['ApartmentFinalized'] = _apartmentFinalized;
    return map;
  }

}

/// TowerFinalized : "South Tower"
/// Status : "Payment Released"
/// StageName : "Booking"
/// sfdcid : "006p000000CDG7pAAH"
/// Revisit : false
/// ProjectFinalized : "Piramal Mahalaxmi"
/// NextFollowUp : ""
/// NewRating : ""
/// Name : "Arun-VKN-0C-PM"
/// Mobilenumber : "9167900737"
/// Due_Invoice : true
/// CRMApproved : true
/// Booking_Date : "2023-04-10"
/// ApartmentFinalized : ""

class PaidInvoicesList extends BookingResponse {
  PaidInvoicesList({
      String towerFinalized, 
      String status, 
      String stageName, 
      String sfdcid, 
      bool revisit, 
      String projectFinalized, 
      String nextFollowUp, 
      String newRating, 
      String name, 
      String mobilenumber, 
      bool dueInvoice, 
      bool cRMApproved, 
      String bookingDate, 
      String apartmentFinalized,}){
    _towerFinalized = towerFinalized;
    _status = status;
    _stageName = stageName;
    _sfdcid = sfdcid;
    _revisit = revisit;
    _projectFinalized = projectFinalized;
    _nextFollowUp = nextFollowUp;
    _newRating = newRating;
    _name = name;
    _mobilenumber = mobilenumber;
    _dueInvoice = dueInvoice;
    _cRMApproved = cRMApproved;
    _bookingDate = bookingDate;
    _apartmentFinalized = apartmentFinalized;
}

  PaidInvoicesList.fromJson(dynamic json) {
    _towerFinalized = json['TowerFinalized'];
    _status = json['Status'];
    _stageName = json['StageName'];
    _sfdcid = json['sfdcid'];
    _revisit = json['Revisit'];
    _projectFinalized = json['ProjectFinalized'];
    _nextFollowUp = json['NextFollowUp'];
    _newRating = json['NewRating'];
    _name = json['Name'];
    _mobilenumber = json['Mobilenumber'];
    _dueInvoice = json['Due_Invoice'];
    _cRMApproved = json['CRMApproved'];
    _bookingDate = json['Booking_Date'];
    _apartmentFinalized = json['ApartmentFinalized'];
  }
  String _towerFinalized;
  String _status;
  String _stageName;
  String _sfdcid;
  bool _revisit;
  String _projectFinalized;
  String _nextFollowUp;
  String _newRating;
  String _name;
  String _mobilenumber;
  bool _dueInvoice;
  bool _cRMApproved;
  String _bookingDate;
  String _apartmentFinalized;
PaidInvoicesList copyWith({  String towerFinalized,
  String status,
  String stageName,
  String sfdcid,
  bool revisit,
  String projectFinalized,
  String nextFollowUp,
  String newRating,
  String name,
  String mobilenumber,
  bool dueInvoice,
  bool cRMApproved,
  String bookingDate,
  String apartmentFinalized,
}) => PaidInvoicesList(  towerFinalized: towerFinalized ?? _towerFinalized,
  status: status ?? _status,
  stageName: stageName ?? _stageName,
  sfdcid: sfdcid ?? _sfdcid,
  revisit: revisit ?? _revisit,
  projectFinalized: projectFinalized ?? _projectFinalized,
  nextFollowUp: nextFollowUp ?? _nextFollowUp,
  newRating: newRating ?? _newRating,
  name: name ?? _name,
  mobilenumber: mobilenumber ?? _mobilenumber,
  dueInvoice: dueInvoice ?? _dueInvoice,
  cRMApproved: cRMApproved ?? _cRMApproved,
  bookingDate: bookingDate ?? _bookingDate,
  apartmentFinalized: apartmentFinalized ?? _apartmentFinalized,
);
  String get towerFinalized => _towerFinalized;
  String get status => _status;
  String get stageName => _stageName;
  String get sfdcid => _sfdcid;
  bool get revisit => _revisit;
  String get projectFinalized => _projectFinalized;
  String get nextFollowUp => _nextFollowUp;
  String get newRating => _newRating;
  String get name => _name;
  String get mobilenumber => _mobilenumber;
  bool get dueInvoice => _dueInvoice;
  bool get cRMApproved => _cRMApproved;
  String get bookingDate => _bookingDate;
  String get apartmentFinalized => _apartmentFinalized;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TowerFinalized'] = _towerFinalized;
    map['Status'] = _status;
    map['StageName'] = _stageName;
    map['sfdcid'] = _sfdcid;
    map['Revisit'] = _revisit;
    map['ProjectFinalized'] = _projectFinalized;
    map['NextFollowUp'] = _nextFollowUp;
    map['NewRating'] = _newRating;
    map['Name'] = _name;
    map['Mobilenumber'] = _mobilenumber;
    map['Due_Invoice'] = _dueInvoice;
    map['CRMApproved'] = _cRMApproved;
    map['Booking_Date'] = _bookingDate;
    map['ApartmentFinalized'] = _apartmentFinalized;
    return map;
  }

}