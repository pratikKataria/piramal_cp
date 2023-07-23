/// statusList : ["Open","Escalated","Re-Open","Closed"]
/// returnCode : true
/// message : "Success"
/// fieldList : [{"values":"Document related,Marketing collateral support,Source Conflict,Complaint against employee,Scheme related,CP detail update/change,Brokerage related,Piramal Advantage,Broker Related,Transfer,Name Addition/ Deletion,Flat Visit,Legal,Escalations,Social Media,Default,Junk,Refund,General,Interest,Documents,Site Visit,Exceptions,Post Handover,Rectification,Handover,Cancellation,Payment,Taxes,Registration,Allotment,Onboarding,null","fieldName":"Case Type"},{"values":"Others,CP App,Escalations,Social Media,Web Portal,Walk-in,Outbound Email,Outbound Call,Mobile Application,Letter,Inbound Email,Inbound Call,null","fieldName":"Case Origin"}]

class TicketPicklistResponse {
  TicketPicklistResponse({
      List<String> statusList, 
      bool returnCode, 
      String message, 
      List<FieldList> fieldList,}){
    _statusList = statusList;
    _returnCode = returnCode;
    _message = message;
    _fieldList = fieldList;
}

  TicketPicklistResponse.fromJson(dynamic json) {
    _statusList = json['statusList'] != null ? json['statusList'].cast<String>() : [];
    _returnCode = json['returnCode'];
    _message = json['message'];
    if (json['fieldList'] != null) {
      _fieldList = [];
      json['fieldList'].forEach((v) {
        _fieldList.add(FieldList.fromJson(v));
      });
    }
  }
  List<String> _statusList;
  bool _returnCode;
  String _message;
  List<FieldList> _fieldList;
TicketPicklistResponse copyWith({  List<String> statusList,
  bool returnCode,
  String message,
  List<FieldList> fieldList,
}) => TicketPicklistResponse(  statusList: statusList ?? _statusList,
  returnCode: returnCode ?? _returnCode,
  message: message ?? _message,
  fieldList: fieldList ?? _fieldList,
);
  List<String> get statusList => _statusList;
  bool get returnCode => _returnCode;
  String get message => _message;
  List<FieldList> get fieldList => _fieldList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusList'] = _statusList;
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    if (_fieldList != null) {
      map['fieldList'] = _fieldList.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// values : "Document related,Marketing collateral support,Source Conflict,Complaint against employee,Scheme related,CP detail update/change,Brokerage related,Piramal Advantage,Broker Related,Transfer,Name Addition/ Deletion,Flat Visit,Legal,Escalations,Social Media,Default,Junk,Refund,General,Interest,Documents,Site Visit,Exceptions,Post Handover,Rectification,Handover,Cancellation,Payment,Taxes,Registration,Allotment,Onboarding,null"
/// fieldName : "Case Type"

class FieldList {
  FieldList({
      String values, 
      String fieldName,}){
    _values = values;
    _fieldName = fieldName;
}

  FieldList.fromJson(dynamic json) {
    _values = json['values'];
    _fieldName = json['fieldName'];
  }
  String _values;
  String _fieldName;
FieldList copyWith({  String values,
  String fieldName,
}) => FieldList(  values: values ?? _values,
  fieldName: fieldName ?? _fieldName,
);
  String get values => _values;
  String get fieldName => _fieldName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['values'] = _values;
    map['fieldName'] = _fieldName;
    return map;
  }

}