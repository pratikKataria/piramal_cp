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

  bool get returnCode => _returnCode;
  String get relationshipManagerName => _relationshipManagerName ?? "Not Available";
  String get relationshipManagerMobile => _relationshipManagerMobile ?? "Not Available";
  String get relationshipManagerLabel => _relationshipManagerLabel ?? "Not Available";
  String get projectName => _projectName ?? "Not Available";
  String get projectID => _projectID ?? "Not Available";
  String get message => _message ?? "Not Available";
  String get headOfDepartmentName => _headOfDepartmentName ?? "Not Available";
  String get headOfDepartmentMobile => _headOfDepartmentMobile ?? "Not Available";
  String get headOfDepartmentLabel => _headOfDepartmentLabel ?? "Not Available";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
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