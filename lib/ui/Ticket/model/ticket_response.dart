import "package:intl/intl.dart";

/// returnCode : true
/// openCasesList : [{"User_Comments":null,"Type":"CP detail update/change","SubType":"Banking detail","Status":"Open","sortDate":"2023-07-29","Position":null,"Pending_with_User":null,"Detail_case_remarks":"Greece","createdDate":"29/7/2023 12:32 AM","close_Date":null,"caseNumber":"00008483","caseId":"500p000000Bp6h3AAB"}]
/// message : "Success"
/// closedCasesList : [{"User_Comments":null,"Type":"Brokerage related","SubType":"Delay in payment","Status":"Closed","sortDate":"2023-07-28","ShowFeedbackForm":false,"Position":null,"Pending_with_User":null,"Detail_case_remarks":"","createdDate":"28/7/2023 05:57 PM","close_Date":null,"caseNumber":"00008478","caseId":"500p000000Bp5VIAAZ"}]
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

/// User_Comments : null
/// Type : "Brokerage related"
/// SubType : "Delay in payment"
/// Status : "Closed"
/// sortDate : "2023-07-28"
/// ShowFeedbackForm : false
/// Position : null
/// Pending_with_User : null
/// Detail_case_remarks : ""
/// createdDate : "28/7/2023 05:57 PM"
/// close_Date : null
/// caseNumber : "00008478"
/// caseId : "500p000000Bp5VIAAZ"

class ClosedCasesList implements Comparable<ClosedCasesList> {
  ClosedCasesList({
    dynamic userComments,
    String type,
    String subType,
    String status,
    String sortDate,
    bool showFeedbackForm,
    dynamic position,
    dynamic pendingWithUser,
    String detailCaseRemarks,
    String createdDate,
    dynamic closeDate,
    String caseNumber,
    String caseId,
  }) {
    _userComments = userComments;
    _type = type;
    _subType = subType;
    _status = status;
    _sortDate = sortDate;
    _showFeedbackForm = showFeedbackForm;
    _position = position;
    _pendingWithUser = pendingWithUser;
    _detailCaseRemarks = detailCaseRemarks;
    _createdDate = createdDate;
    _closeDate = closeDate;
    _caseNumber = caseNumber;
    _caseId = caseId;
  }

  ClosedCasesList.fromJson(dynamic json) {
    _userComments = json['User_Comments'];
    _type = json['Type'];
    _subType = json['SubType'];
    _status = json['Status'];
    _sortDate = json['sortDate'];
    _showFeedbackForm = json['ShowFeedbackForm'];
    _position = json['Position'];
    _pendingWithUser = json['Pending_with_User'];
    _detailCaseRemarks = json['Detail_case_remarks'];
    _createdDate = json['createdDate'];
    _closeDate = json['close_Date'];
    _caseNumber = json['caseNumber'];
    _caseId = json['caseId'];
  }

  dynamic _userComments;
  String _type;
  String _subType;
  String _status;
  String _sortDate;
  bool _showFeedbackForm;
  dynamic _position;
  dynamic _pendingWithUser;
  String _detailCaseRemarks;
  String _createdDate;
  dynamic _closeDate;
  String _caseNumber;
  String _caseId;

  ClosedCasesList copyWith({
    dynamic userComments,
    String type,
    String subType,
    String status,
    String sortDate,
    bool showFeedbackForm,
    dynamic position,
    dynamic pendingWithUser,
    String detailCaseRemarks,
    String createdDate,
    dynamic closeDate,
    String caseNumber,
    String caseId,
  }) =>
      ClosedCasesList(
        userComments: userComments ?? _userComments,
        type: type ?? _type,
        subType: subType ?? _subType,
        status: status ?? _status,
        sortDate: sortDate ?? _sortDate,
        showFeedbackForm: showFeedbackForm ?? _showFeedbackForm,
        position: position ?? _position,
        pendingWithUser: pendingWithUser ?? _pendingWithUser,
        detailCaseRemarks: detailCaseRemarks ?? _detailCaseRemarks,
        createdDate: createdDate ?? _createdDate,
        closeDate: closeDate ?? _closeDate,
        caseNumber: caseNumber ?? _caseNumber,
        caseId: caseId ?? _caseId,
      );

  dynamic get userComments => _userComments;

  String get type => _type;

  String get subType => _subType;

  String get status => _status;

  String get sortDate => _sortDate;

  bool get showFeedbackForm => _showFeedbackForm;

  dynamic get position => _position;

  dynamic get pendingWithUser => _pendingWithUser;

  String get detailCaseRemarks => _detailCaseRemarks;

  String get createdDate => _createdDate;

  dynamic get closeDate => _closeDate;

  String get caseNumber => _caseNumber;

  String get caseId => _caseId;

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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['User_Comments'] = _userComments;
    map['Type'] = _type;
    map['SubType'] = _subType;
    map['Status'] = _status;
    map['sortDate'] = _sortDate;
    map['ShowFeedbackForm'] = _showFeedbackForm;
    map['Position'] = _position;
    map['Pending_with_User'] = _pendingWithUser;
    map['Detail_case_remarks'] = _detailCaseRemarks;
    map['createdDate'] = _createdDate;
    map['close_Date'] = _closeDate;
    map['caseNumber'] = _caseNumber;
    map['caseId'] = _caseId;
    return map;
  }
}

/// User_Comments : null
/// Type : "CP detail update/change"
/// SubType : "Banking detail"
/// Status : "Open"
/// sortDate : "2023-07-29"
/// Position : null
/// Pending_with_User : null
/// Detail_case_remarks : "Greece"
/// createdDate : "29/7/2023 12:32 AM"
/// close_Date : null
/// caseNumber : "00008483"
/// caseId : "500p000000Bp6h3AAB"

class OpenCasesList extends Comparable<OpenCasesList> {
  OpenCasesList({
    dynamic userComments,
    String type,
    String subType,
    String status,
    String sortDate,
    dynamic position,
    dynamic pendingWithUser,
    String detailCaseRemarks,
    String createdDate,
    dynamic closeDate,
    String caseNumber,
    String caseId,
  }) {
    _userComments = userComments;
    _type = type;
    _subType = subType;
    _status = status;
    _sortDate = sortDate;
    _position = position;
    _pendingWithUser = pendingWithUser;
    _detailCaseRemarks = detailCaseRemarks;
    _createdDate = createdDate;
    _closeDate = closeDate;
    _caseNumber = caseNumber;
    _caseId = caseId;
  }

  OpenCasesList.fromJson(dynamic json) {
    _userComments = json['User_Comments'];
    _type = json['Type'];
    _subType = json['SubType'];
    _status = json['Status'];
    _sortDate = json['sortDate'];
    _position = json['Position'];
    _pendingWithUser = json['Pending_with_User'];
    _detailCaseRemarks = json['Detail_case_remarks'];
    _createdDate = json['createdDate'];
    _closeDate = json['close_Date'];
    _caseNumber = json['caseNumber'];
    _caseId = json['caseId'];
  }

  dynamic _userComments;
  String _type;
  String _subType;
  String _status;
  String _sortDate;
  dynamic _position;
  dynamic _pendingWithUser;
  String _detailCaseRemarks;
  String _createdDate;
  dynamic _closeDate;
  String _caseNumber;
  String _caseId;

  OpenCasesList copyWith({
    dynamic userComments,
    String type,
    String subType,
    String status,
    String sortDate,
    dynamic position,
    dynamic pendingWithUser,
    String detailCaseRemarks,
    String createdDate,
    dynamic closeDate,
    String caseNumber,
    String caseId,
  }) =>
      OpenCasesList(
        userComments: userComments ?? _userComments,
        type: type ?? _type,
        subType: subType ?? _subType,
        status: status ?? _status,
        sortDate: sortDate ?? _sortDate,
        position: position ?? _position,
        pendingWithUser: pendingWithUser ?? _pendingWithUser,
        detailCaseRemarks: detailCaseRemarks ?? _detailCaseRemarks,
        createdDate: createdDate ?? _createdDate,
        closeDate: closeDate ?? _closeDate,
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

  dynamic get userComments => _userComments;

  String get type => _type;

  String get subType => _subType;

  String get status => _status;

  String get sortDate => _sortDate;

  dynamic get position => _position;

  dynamic get pendingWithUser => _pendingWithUser;

  String get detailCaseRemarks => _detailCaseRemarks;

  String get createdDate => _createdDate;

  dynamic get closeDate => _closeDate;

  String get caseNumber => _caseNumber;

  String get caseId => _caseId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['User_Comments'] = _userComments;
    map['Type'] = _type;
    map['SubType'] = _subType;
    map['Status'] = _status;
    map['sortDate'] = _sortDate;
    map['Position'] = _position;
    map['Pending_with_User'] = _pendingWithUser;
    map['Detail_case_remarks'] = _detailCaseRemarks;
    map['createdDate'] = _createdDate;
    map['close_Date'] = _closeDate;
    map['caseNumber'] = _caseNumber;
    map['caseId'] = _caseId;
    return map;
  }
}
