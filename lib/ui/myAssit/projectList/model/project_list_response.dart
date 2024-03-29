/// returnCode : 2
/// RelationshipManager : ""
/// ProjectName : "Piramal Mahalaxmi"
/// ProjectId : "a03N000000PixbIIAR"
/// message : "Success"
/// Head_of_Department : ""

class ProjectListResponse2 {
  ProjectListResponse2({
      bool returnCode,
      String relationshipManager, 
      String projectName, 
      String projectId, 
      String message, 
      String headOfDepartment,}){
    _returnCode = returnCode;
    _relationshipManager = relationshipManager;
    _projectName = projectName;
    _projectId = projectId;
    _message = message;
    _headOfDepartment = headOfDepartment;
}

  ProjectListResponse2.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _relationshipManager = json['RelationshipManager'];
    _projectName = json['ProjectName'];
    _projectId = json['ProjectId'];
    _message = json['message'];
    _headOfDepartment = json['Head_of_Department'];
  }
  bool _returnCode;
  String _relationshipManager;
  String _projectName;
  String _projectId;
  String _message;
  String _headOfDepartment;

  bool get returnCode => _returnCode;
  String get relationshipManager => _relationshipManager;
  String get projectName => _projectName;
  String get projectId => _projectId;
  String get message => _message;
  String get headOfDepartment => _headOfDepartment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['RelationshipManager'] = _relationshipManager;
    map['ProjectName'] = _projectName;
    map['ProjectId'] = _projectId;
    map['message'] = _message;
    map['Head_of_Department'] = _headOfDepartment;
    return map;
  }

}