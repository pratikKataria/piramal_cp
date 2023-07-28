/// returnCode : true
/// openCasesList : [{"User_Comments":"Test Milestone 1","Type":"Brokerage related","SubType":"Delay in payment;GST/tax related;Others","Status":"Open","Position":null,"Pending_with_User":null,"Detail_case_remarks":"test create case","createdDate":"21/7/2023 08:08 PM","close_Date":null,"Category":"Email","caseNumber":"00008437","caseId":"500p000000BoVZKAA3"},{"User_Comments":"Test Milestone 1","Type":"Brokerage related","SubType":null,"Status":"Open","Position":null,"Pending_with_User":null,"Detail_case_remarks":null,"createdDate":"21/7/2023 04:35 PM","close_Date":null,"Category":"Email;WhatsApp App","caseNumber":"00008431","caseId":"500p000000BoUr8AAF"},{"User_Comments":"Test Milestone 1","Type":"Brokerage related","SubType":null,"Status":"Open","Position":null,"Pending_with_User":null,"Detail_case_remarks":null,"createdDate":"21/7/2023 08:24 PM","close_Date":null,"Category":null,"caseNumber":"00008438","caseId":"500p000000BoVcFAAV"},{"User_Comments":null,"Type":"Brokerage related","SubType":null,"Status":"Open","Position":null,"Pending_with_User":null,"Detail_case_remarks":"test create case","createdDate":"21/7/2023 06:18 PM","close_Date":null,"Category":"Email","caseNumber":"00008432","caseId":"500p000000BoVCMAA3"},{"User_Comments":null,"Type":"Brokerage related","SubType":null,"Status":"Open","Position":null,"Pending_with_User":null,"Detail_case_remarks":"test create case","createdDate":"21/7/2023 06:18 PM","close_Date":null,"Category":"Email","caseNumber":"00008433","caseId":"500p000000BoVCkAAN"},{"User_Comments":"Test Milestone 1","Type":"Brokerage related","SubType":"Delay in payment;GST/tax related;Others","Status":"Open","Position":null,"Pending_with_User":null,"Detail_case_remarks":"test create case","createdDate":"21/7/2023 02:06 PM","close_Date":null,"Category":"Email","caseNumber":"00008430","caseId":"500p000000BoUISAA3"},{"User_Comments":"Test Milestone 1","Type":"Brokerage related","SubType":"Delay in payment;Others","Status":"Open","Position":null,"Pending_with_User":null,"Detail_case_remarks":"test create case 21 test","createdDate":"21/7/2023 07:54 PM","close_Date":null,"Category":"Email","caseNumber":"00008436","caseId":"500p000000BoVWCAA3"},{"User_Comments":null,"Type":"Brokerage related","SubType":"Delay in payment;Others","Status":"Open","Position":null,"Pending_with_User":null,"Detail_case_remarks":"test create case 21","createdDate":"21/7/2023 07:30 PM","close_Date":null,"Category":"Email","caseNumber":"00008435","caseId":"500p000000BoVS9AAN"},{"User_Comments":"Test Milestone 1","Type":"Brokerage related","SubType":"Others","Status":"Open","Position":null,"Pending_with_User":null,"Detail_case_remarks":"test create case 21","createdDate":"21/7/2023 07:20 PM","close_Date":null,"Category":"Email","caseNumber":"00008434","caseId":"500p000000BoVPkAAN"}]
/// message : "Success"
/// closedCasesList : [{"User_Comments":"Test Milestone 1","Type":"Brokerage related","SubType":"Others","Status":"Open","Position":null,"Pending_with_User":null,"Detail_case_remarks":"test create case 21","createdDate":"21/7/2023 07:20 PM","close_Date":null,"Category":"Email","caseNumber":"00008434","caseId":"500p000000BoVPkAAN"}]
import 'package:intl/intl.dart'; // Import the intl library for DateFormat

class TicketResponse {
  TicketResponse({
    bool returnCode,
    List<OpenCasesList> openCasesList,
    String message,
    List<ClosedCasesList> closedCasesList,
  }) {
    _returnCode = returnCode;
    _openCasesList = openCasesList;
    _message = message;
    _closedCasesList = closedCasesList;
  }

  TicketResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    if (json['openCasesList'] != null) {
      _openCasesList = [];
      json['openCasesList'].forEach((v) {
        _openCasesList.add(OpenCasesList.fromJson(v));
      });
    }
    _message = json['message'];
    if (json['closedCasesList'] != null) {
      _closedCasesList = [];
      json['closedCasesList'].forEach((v) {
        _closedCasesList.add(ClosedCasesList.fromJson(v));
      });
    }
  }

  bool _returnCode;
  List<OpenCasesList> _openCasesList;
  String _message;
  List<ClosedCasesList> _closedCasesList;

  TicketResponse copyWith({
    bool returnCode,
    List<OpenCasesList> openCasesList,
    String message,
    List<ClosedCasesList> closedCasesList,
  }) =>
      TicketResponse(
        returnCode: returnCode ?? _returnCode,
        openCasesList: openCasesList ?? _openCasesList,
        message: message ?? _message,
        closedCasesList: closedCasesList ?? _closedCasesList,
      );

  bool get returnCode => _returnCode;

  List<OpenCasesList> get openCasesList => _openCasesList;

  String get message => _message;

  List<ClosedCasesList> get closedCasesList => _closedCasesList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    if (_openCasesList != null) {
      map['openCasesList'] = _openCasesList.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    if (_closedCasesList != null) {
      map['closedCasesList'] = _closedCasesList.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// User_Comments : "Test Milestone 1"
/// Type : "Brokerage related"
/// SubType : "Others"
/// Status : "Open"
/// Position : null
/// Pending_with_User : null
/// Detail_case_remarks : "test create case 21"
/// createdDate : "21/7/2023 07:20 PM"
/// close_Date : null
/// Category : "Email"
/// caseNumber : "00008434"
/// caseId : "500p000000BoVPkAAN"

class ClosedCasesList extends Comparable<ClosedCasesList> {
  ClosedCasesList({
    String userComments,
    String type,
    String subType,
    String status,
    dynamic position,
    dynamic pendingWithUser,
    String detailCaseRemarks,
    String createdDate,
    dynamic closeDate,
    String category,
    String caseNumber,
    String caseId,
  }) {
    _userComments = userComments;
    _type = type;
    _subType = subType;
    _status = status;
    _position = position;
    _pendingWithUser = pendingWithUser;
    _detailCaseRemarks = detailCaseRemarks;
    _createdDate = createdDate;
    _closeDate = closeDate;
    _category = category;
    _caseNumber = caseNumber;
    _caseId = caseId;
  }

  ClosedCasesList.fromJson(dynamic json) {
    _userComments = json['User_Comments'];
    _type = json['Type'];
    _subType = json['SubType'];
    _status = json['Status'];
    _position = json['Position'];
    _pendingWithUser = json['Pending_with_User'];
    _detailCaseRemarks = json['Detail_case_remarks'];
    _createdDate = json['createdDate'];
    _closeDate = json['close_Date'];
    _category = json['Category'];
    _caseNumber = json['caseNumber'];
    _caseId = json['caseId'];
  }

  String _userComments;
  String _type;
  String _subType;
  String _status;
  dynamic _position;
  dynamic _pendingWithUser;
  String _detailCaseRemarks;
  String _createdDate;
  dynamic _closeDate;
  String _category;
  String _caseNumber;
  String _caseId;

  ClosedCasesList copyWith({
    String userComments,
    String type,
    String subType,
    String status,
    dynamic position,
    dynamic pendingWithUser,
    String detailCaseRemarks,
    String createdDate,
    dynamic closeDate,
    String category,
    String caseNumber,
    String caseId,
  }) =>
      ClosedCasesList(
        userComments: userComments ?? _userComments,
        type: type ?? _type,
        subType: subType ?? _subType,
        status: status ?? _status,
        position: position ?? _position,
        pendingWithUser: pendingWithUser ?? _pendingWithUser,
        detailCaseRemarks: detailCaseRemarks ?? _detailCaseRemarks,
        createdDate: createdDate ?? _createdDate,
        closeDate: closeDate ?? _closeDate,
        category: category ?? _category,
        caseNumber: caseNumber ?? _caseNumber,
        caseId: caseId ?? _caseId,
      );

  String get userComments => _userComments;

  String get type => _type;

  String get subType => _subType;

  String get status => _status;

  dynamic get position => _position;

  dynamic get pendingWithUser => _pendingWithUser;

  String get detailCaseRemarks => _detailCaseRemarks;

  String get createdDate => _createdDate;

  dynamic get closeDate => _closeDate;

  String get category => _category;

  String get caseNumber => _caseNumber;

  String get caseId => _caseId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['User_Comments'] = _userComments;
    map['Type'] = _type;
    map['SubType'] = _subType;
    map['Status'] = _status;
    map['Position'] = _position;
    map['Pending_with_User'] = _pendingWithUser;
    map['Detail_case_remarks'] = _detailCaseRemarks;
    map['createdDate'] = _createdDate;
    map['close_Date'] = _closeDate;
    map['Category'] = _category;
    map['caseNumber'] = _caseNumber;
    map['caseId'] = _caseId;
    return map;
  }

  @override
  int compareTo(ClosedCasesList other) {
    // Parse the createdDate strings to DateTime objects for comparison
    DateTime thisDate = _parseDateString(createdDate);
    DateTime otherDate = _parseDateString(other.createdDate);

    return thisDate.compareTo(otherDate);
  }

  DateTime _parseDateString(String dateString) {
    // Parse the date string in the format "dd/MM/yyyy hh:mm a" to DateTime
    // String formattedDate = dateString.replaceAll(" PM", "PM").replaceAll(" AM", "AM");
    final format = DateFormat('dd/MM/yyyy hh:mm a');
    return format.parse(dateString);
  }
}

/// User_Comments : "Test Milestone 1"
/// Type : "Brokerage related"
/// SubType : "Delay in payment;GST/tax related;Others"
/// Status : "Open"
/// Position : null
/// Pending_with_User : null
/// Detail_case_remarks : "test create case"
/// createdDate : "21/7/2023 08:08 PM"
/// close_Date : null
/// Category : "Email"
/// caseNumber : "00008437"
/// caseId : "500p000000BoVZKAA3"

class OpenCasesList extends Comparable<OpenCasesList> {
  OpenCasesList({
    String userComments,
    String type,
    String subType,
    String status,
    dynamic position,
    dynamic pendingWithUser,
    String detailCaseRemarks,
    String createdDate,
    dynamic closeDate,
    String category,
    String caseNumber,
    String caseId,
  }) {
    _userComments = userComments;
    _type = type;
    _subType = subType;
    _status = status;
    _position = position;
    _pendingWithUser = pendingWithUser;
    _detailCaseRemarks = detailCaseRemarks;
    _createdDate = createdDate;
    _closeDate = closeDate;
    _category = category;
    _caseNumber = caseNumber;
    _caseId = caseId;
  }

  OpenCasesList.fromJson(dynamic json) {
    _userComments = json['User_Comments'];
    _type = json['Type'];
    _subType = json['SubType'];
    _status = json['Status'];
    _position = json['Position'];
    _pendingWithUser = json['Pending_with_User'];
    _detailCaseRemarks = json['Detail_case_remarks'];
    _createdDate = json['createdDate'];
    _closeDate = json['close_Date'];
    _category = json['Category'];
    _caseNumber = json['caseNumber'];
    _caseId = json['caseId'];
  }

  String _userComments;
  String _type;
  String _subType;
  String _status;
  dynamic _position;
  dynamic _pendingWithUser;
  String _detailCaseRemarks;
  String _createdDate;
  dynamic _closeDate;
  String _category;
  String _caseNumber;
  String _caseId;

  OpenCasesList copyWith({
    String userComments,
    String type,
    String subType,
    String status,
    dynamic position,
    dynamic pendingWithUser,
    String detailCaseRemarks,
    String createdDate,
    dynamic closeDate,
    String category,
    String caseNumber,
    String caseId,
  }) =>
      OpenCasesList(
        userComments: userComments ?? _userComments,
        type: type ?? _type,
        subType: subType ?? _subType,
        status: status ?? _status,
        position: position ?? _position,
        pendingWithUser: pendingWithUser ?? _pendingWithUser,
        detailCaseRemarks: detailCaseRemarks ?? _detailCaseRemarks,
        createdDate: createdDate ?? _createdDate,
        closeDate: closeDate ?? _closeDate,
        category: category ?? _category,
        caseNumber: caseNumber ?? _caseNumber,
        caseId: caseId ?? _caseId,
      );

  @override
  int compareTo(OpenCasesList other) {
    // Parse the createdDate strings to DateTime objects for comparison
    DateTime thisDate = _parseDateString(createdDate);
    DateTime otherDate = _parseDateString(other.createdDate);

    return thisDate.compareTo(otherDate);
  }

  DateTime _parseDateString(String dateString) {
    // Parse the date string in the format "dd/MM/yyyy hh:mm a" to DateTime
    // String formattedDate = dateString.replaceAll(" PM", "PM").replaceAll(" AM", "AM");
    final format = DateFormat('dd/MM/yyyy hh:mm a');
    return format.parse(dateString);
  }

  String get userComments => _userComments;

  String get type => _type;

  String get subType => _subType;

  String get status => _status;

  dynamic get position => _position;

  dynamic get pendingWithUser => _pendingWithUser;

  String get detailCaseRemarks => _detailCaseRemarks;

  String get createdDate => _createdDate;

  dynamic get closeDate => _closeDate;

  String get category => _category;

  String get caseNumber => _caseNumber;

  String get caseId => _caseId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['User_Comments'] = _userComments;
    map['Type'] = _type;
    map['SubType'] = _subType;
    map['Status'] = _status;
    map['Position'] = _position;
    map['Pending_with_User'] = _pendingWithUser;
    map['Detail_case_remarks'] = _detailCaseRemarks;
    map['createdDate'] = _createdDate;
    map['close_Date'] = _closeDate;
    map['Category'] = _category;
    map['caseNumber'] = _caseNumber;
    map['caseId'] = _caseId;
    return map;
  }
}
