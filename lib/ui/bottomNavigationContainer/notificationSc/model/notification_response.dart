/// returnCode : 2
/// message : "Success"
/// NotificationList : [{"Type":"Current Promotion","Title":"a32p0000000fDhN","Published_date":"2022-03-14","NotificationID":"a32p0000000fDhNAAU","Is_Read":false,"Body":"","AccountId":"001p000000zIm0jAAC"}]

class NotificationResponse {
  NotificationResponse({
      int returnCode, 
      String message, 
      List<NotificationList> notificationList,}){
    _returnCode = returnCode;
    _message = message;
    _notificationList = notificationList;
}

  NotificationResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _message = json['message'];
    if (json['NotificationList'] != null) {
      _notificationList = [];
      json['NotificationList'].forEach((v) {
        _notificationList.add(NotificationList.fromJson(v));
      });
    }
  }
  int _returnCode;
  String _message;
  List<NotificationList> _notificationList;

  int get returnCode => _returnCode;
  String get message => _message;
  List<NotificationList> get notificationList => _notificationList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    if (_notificationList != null) {
      map['NotificationList'] = _notificationList.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// Type : "Current Promotion"
/// Title : "a32p0000000fDhN"
/// Published_date : "2022-03-14"
/// NotificationID : "a32p0000000fDhNAAU"
/// Is_Read : false
/// Body : ""
/// AccountId : "001p000000zIm0jAAC"

class NotificationList {
  NotificationList({
      String type, 
      String title, 
      String publishedDate, 
      String notificationID, 
      bool isRead, 
      String body, 
      String accountId,}){
    _type = type;
    _title = title;
    _publishedDate = publishedDate;
    _notificationID = notificationID;
    _isRead = isRead;
    _body = body;
    _accountId = accountId;
}

  NotificationList.fromJson(dynamic json) {
    _type = json['Type'];
    _title = json['Title'];
    _publishedDate = json['Published_date'];
    _notificationID = json['NotificationID'];
    _isRead = json['Is_Read'];
    _body = json['Body'];
    _accountId = json['AccountId'];
  }
  String _type;
  String _title;
  String _publishedDate;
  String _notificationID;
  bool _isRead;
  String _body;
  String _accountId;

  String get type => _type;
  String get title => _title;
  String get publishedDate => _publishedDate;
  String get notificationID => _notificationID;
  bool get isRead => _isRead;
  String get body => _body;
  String get accountId => _accountId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Type'] = _type;
    map['Title'] = _title;
    map['Published_date'] = _publishedDate;
    map['NotificationID'] = _notificationID;
    map['Is_Read'] = _isRead;
    map['Body'] = _body;
    map['AccountId'] = _accountId;
    return map;
  }

}