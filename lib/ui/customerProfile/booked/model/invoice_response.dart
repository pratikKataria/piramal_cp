/// Status : "Invoice Approved"
/// returnCode : true
/// Name : "sample"
/// message : "Success"
/// FileID : "069p00000027WF0AAM"
/// File : "JVBERi0xLjMNCiXi48/TDQoNCjEgMCBvYmoNCjw8DQovVHlwZSAvQ2F\n0YWxvZw0KL091dGxpbmVzIDIgMCBSDQovUGFnZXMgMyAwIFINCj4+DQplbmRv\nYmoNCg0KMiAwIG9iag0KPDwNCi9UeXBlIC9PdXRsaW5lcw0KL0NvdW50IDANCj4\n+DQplbmRvYmoNCg0KMyAwIG9iag0KPDwNCi9UeXBlIC9QYWdlcw0KL0NvdW50I\nDINCi9LaWRzIFsgNCAwIFIgNiAwIFIgXSANCj4+DQplbmRvYmoNCg0KNCAwIG9ia\ng0KPDwNCi9UeXBlIC9QYWdlDQovUGFyZW50IDMgMCBSDQovUmVzb3VyY2VzI\nDw8DQovRm9udCA8PA0KL0YxIDkgMCBSIA0KPj4NCi9Qcm9jU2V0IDggMCBSDQo\n+Pg0KL01lZGlhQm94IFswIDAgNjEyLjAwMDAgNzkyLjAwMDBdDQovQ29udGVudH\nMgNSAwIFINCj4+DQplbmRvYmoNCg0KNSAwIG9iag0KPDwgL0xlbmd0aCAxMDc0I\nD4+DQpzdHJlYW0NCjIgSg0KQlQNCjAgMCAwIHJnDQovRjEgMDAyNyBUZg0KNTc\nuMzc1MCA3MjIuMjgwMCBUZA0KKCBBIFNpbXBsZSBQREYgRmlsZSApIFRqDQpF\nVA0KQlQNCi9GMSAwMDEwIFRmDQo2OS4yNTAwIDY4OC42MDgwIFRkDQooIFR\noaXMgaXMgYSBzbWFsbCBkZW1vbnN0cmF0aW9uIC5wZGYgZmlsZSAtICkgVGoNC\nkVUDQpCVA0KL0YxIDAwMTAgVGYNCjY5LjI1MDAgNjY0LjcwNDAgVGQNCigga\nnVzdCBmb3IgdXNlIGluIHRoZSBWaXJ0dWFsIE1lY2hhbmljcyB0dXRvcmlhbHMuIE1v\ncmUgdGV4dC4gQW5kIG1vcmUgKSBUag0KRVQNCkJUDQovRjEgMDAxMCBUZg0\nKNjkuMjUwMCA"

class InvoiceResponse {
  InvoiceResponse({
    String status,
    bool returnCode,
    String name,
    String message,
    String fileID,
    String BrokerageID,
    String file,
  }) {
    _status = status;
    _returnCode = returnCode;
    _name = name;
    _message = message;
    _fileID = fileID;
    _file = file;
    _brokerageID = BrokerageID;
  }

  InvoiceResponse.fromJson(dynamic json) {
    _status = json['Status'];
    _returnCode = json['returnCode'];
    _name = json['Name'];
    _message = json['message'];
    _fileID = json['FileID'];
    _file = json['InvoiceDownloadlink'];
    _brokerageID = json['BrokerageID'];
  }

  String _status;
  bool _returnCode;
  String _name;
  String _message;
  String _fileID;
  String _file;
  String _brokerageID;

  String get status => _status;

  bool get returnCode => _returnCode;

  String get name => _name;

  String get message => _message;

  String get fileID => _fileID;

  String get file => _file;

  String get brokerageID => _brokerageID;

  set brokerageID(String value) {
    _brokerageID = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = _status;
    map['returnCode'] = _returnCode;
    map['Name'] = _name;
    map['message'] = _message;
    map['FileID'] = _fileID;
    map['InvoiceDownloadlink'] = _file;
    map['BrokerageID'] = _brokerageID;
    return map;
  }
}
