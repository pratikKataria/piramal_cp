/// SiteHeadMobile : "+91 9960390011"
/// SiteHeadLabel : "Site Head"
/// SiteHead : "Aniket Khillari"
/// returnCode : true
/// RelationshipManagerName : "Devashish Nagapure"
/// RelationshipManagerMobile : "9881560816"
/// RelationshipManagerLabel : "Relationship Manager"
/// ProjectName : "Piramal Vaikunth"
/// ProjectID : "a03N0000005NHiTIAW"
/// message : "Success"
/// HeadOfDepartmentName : "Devashish Nagapure"
/// HeadOfDepartmentMobile : "9881560816"
/// HeadOfDepartmentLabel : "Head of Department (HOD)"

class MyAssistResponse {
  MyAssistResponse({
      String siteHeadMobile, 
      String siteHeadLabel, 
      String siteHead, 
      bool returnCode, 
      String relationshipManagerName, 
      String relationshipManagerMobile, 
      String relationshipManagerLabel, 
      String projectName, 
      String projectID, 
      String message, 
      String headOfDepartmentName, 
      String headOfDepartmentMobile, 
      String headOfDepartmentLabel,}){
    _siteHeadMobile = siteHeadMobile;
    _siteHeadLabel = siteHeadLabel;
    _siteHead = siteHead;
    _returnCode = returnCode;
    _relationshipManagerName = relationshipManagerName;
    _relationshipManagerMobile = relationshipManagerMobile;
    _relationshipManagerLabel = relationshipManagerLabel;
    _projectName = projectName;
    _projectID = projectID;
    _message = message;
    _headOfDepartmentName = headOfDepartmentName;
    _headOfDepartmentMobile = headOfDepartmentMobile;
    _headOfDepartmentLabel = headOfDepartmentLabel;
}

  MyAssistResponse.fromJson(dynamic json) {
    _siteHeadMobile = json['ChannelHeadMobile'];
    _siteHeadLabel = json['ChannelHeadLabel'];
    _siteHead = json['ChannelHeadName'];
    _returnCode = json['returnCode'];
    _relationshipManagerName = json['RelationshipManagerName'];
    _relationshipManagerMobile = json['RelationshipManagerMobile'];
    _relationshipManagerLabel = json['RelationshipManagerLabel'];
    _projectName = json['ProjectName'];
    _projectID = json['ProjectID'];
    _message = json['message'];
    _headOfDepartmentName = json['HeadOfDepartmentName'];
    _headOfDepartmentMobile = json['HeadOfDepartmentMobile'];
    _headOfDepartmentLabel = json['HeadOfDepartmentLabel'];
  }
  String _siteHeadMobile;
  String _siteHeadLabel;
  String _siteHead;
  bool _returnCode;
  String _relationshipManagerName;
  String _relationshipManagerMobile;
  String _relationshipManagerLabel;
  String _projectName;
  String _projectID;
  String _message;
  String _headOfDepartmentName;
  String _headOfDepartmentMobile;
  String _headOfDepartmentLabel;

  String get siteHeadMobile => _siteHeadMobile;
  String get siteHeadLabel => _siteHeadLabel;
  String get siteHead => _siteHead;
  bool get returnCode => _returnCode?? false;
  String get relationshipManagerName => _relationshipManagerName;
  String get relationshipManagerMobile => _relationshipManagerMobile;
  String get relationshipManagerLabel => _relationshipManagerLabel;
  String get projectName => _projectName;
  String get projectID => _projectID;
  String get message => _message;
  String get headOfDepartmentName => _headOfDepartmentName;
  String get headOfDepartmentMobile => _headOfDepartmentMobile;
  String get headOfDepartmentLabel => _headOfDepartmentLabel;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ChannelHeadMobile'] = _siteHeadMobile;
    map['ChannelHeadLabel'] = _siteHeadLabel;
    map['ChannelHeadName'] = _siteHead;
    map['returnCode'] = _returnCode;
    map['RelationshipManagerName'] = _relationshipManagerName;
    map['RelationshipManagerMobile'] = _relationshipManagerMobile;
    map['RelationshipManagerLabel'] = _relationshipManagerLabel;
    map['ProjectName'] = _projectName;
    map['ProjectID'] = _projectID;
    map['message'] = _message;
    map['HeadOfDepartmentName'] = _headOfDepartmentName;
    map['HeadOfDepartmentMobile'] = _headOfDepartmentMobile;
    map['HeadOfDepartmentLabel'] = _headOfDepartmentLabel;
    return map;
  }

}