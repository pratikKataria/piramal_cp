/// SitevisitName : "asdtyuik - Piramal Revanta"
/// SiteVisitID : "a1Cp00000024WHAEA2"
/// returnCode : true
/// message : "Success"
/// feedback : null
/// DateOfVisit : "2021-11-10T09:34:31.000Z"
/// CM : [{"feedback":"Testing For Aniket","CommentByCP":false}]

class Chatresponse {
  Chatresponse({
      String sitevisitName, 
      String siteVisitID, 
      bool returnCode, 
      String message, 
      dynamic feedback, 
      String dateOfVisit, 
      List<CM> cm,}){
    _sitevisitName = sitevisitName;
    _siteVisitID = siteVisitID;
    _returnCode = returnCode;
    _message = message;
    _feedback = feedback;
    _dateOfVisit = dateOfVisit;
    _cm = cm;
}

  Chatresponse.fromJson(dynamic json) {
    _sitevisitName = json['SitevisitName'];
    _siteVisitID = json['SiteVisitID'];
    _returnCode = json['returnCode'];
    _message = json['message'];
    _feedback = json['feedback'];
    _dateOfVisit = json['DateOfVisit'];
    if (json['CM'] != null) {
      _cm = [];
      json['CM'].forEach((v) {
        _cm.add(CM.fromJson(v));
      });
    }
  }
  String _sitevisitName;
  String _siteVisitID;
  bool _returnCode;
  String _message;
  dynamic _feedback;
  String _dateOfVisit;
  List<CM> _cm;

  String get sitevisitName => _sitevisitName;
  String get siteVisitID => _siteVisitID;
  bool get returnCode => _returnCode;
  String get message => _message;
  dynamic get feedback => _feedback;
  String get dateOfVisit => _dateOfVisit;
  List<CM> get cm => _cm;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['SitevisitName'] = _sitevisitName;
    map['SiteVisitID'] = _siteVisitID;
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    map['feedback'] = _feedback;
    map['DateOfVisit'] = _dateOfVisit;
    if (_cm != null) {
      map['CM'] = _cm.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// feedback : "Testing For Aniket"
/// CommentByCP : false

class CM {
  CM({
      String feedback, 
      bool commentByCP,}){
    _feedback = feedback;
    _commentByCP = commentByCP;
}

  CM.fromJson(dynamic json) {
    _feedback = json['feedback'];
    _commentByCP = json['CommentByCP'];
  }
  String _feedback;
  bool _commentByCP;

  String get feedback => _feedback;
  bool get commentByCP => _commentByCP;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['feedback'] = _feedback;
    map['CommentByCP'] = _commentByCP;
    return map;
  }

}