/// website : "https://maharera.mahaonline.gov.in/"
/// threeDtoururl : null
/// returnCode : 2
/// recordid : "a03N0000005NHiTIAW"
/// Projectphotos : null
/// ProjectName : "Piramal Vaikunth"
/// projectmap : null
/// ProjectDescription : "Piramal Vaikunth"
/// ProjectCity : "Thane"
/// message : "SUCCESS"

class ProjectOverviewResponse {
  ProjectOverviewResponse({
      String website, 
      dynamic threeDtoururl, 
      int returnCode, 
      String recordid, 
      dynamic projectphotos, 
      String projectName, 
      dynamic projectmap, 
      String projectDescription, 
      String projectCity, 
      String message,}){
    _website = website;
    _threeDtoururl = threeDtoururl;
    _returnCode = returnCode;
    _recordid = recordid;
    _projectphotos = projectphotos;
    _projectName = projectName;
    _projectmap = projectmap;
    _projectDescription = projectDescription;
    _projectCity = projectCity;
    _message = message;
}

  ProjectOverviewResponse.fromJson(dynamic json) {
    _website = json['website'];
    _threeDtoururl = json['threeDtoururl'];
    _returnCode = json['returnCode'];
    _recordid = json['recordid'];
    _projectphotos = json['Projectphotos'];
    _projectName = json['ProjectName'];
    _projectmap = json['projectmap'];
    _projectDescription = json['ProjectDescription'];
    _projectCity = json['ProjectCity'];
    _message = json['message'];
  }
  String _website;
  dynamic _threeDtoururl;
  int _returnCode;
  String _recordid;
  dynamic _projectphotos;
  String _projectName;
  dynamic _projectmap;
  String _projectDescription;
  String _projectCity;
  String _message;

  String get website => _website;
  dynamic get threeDtoururl => _threeDtoururl;
  int get returnCode => _returnCode;
  String get recordid => _recordid;
  dynamic get projectphotos => _projectphotos;
  String get projectName => _projectName;
  dynamic get projectmap => _projectmap;
  String get projectDescription => _projectDescription;
  String get projectCity => _projectCity;
  String get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['website'] = _website;
    map['threeDtoururl'] = _threeDtoururl;
    map['returnCode'] = _returnCode;
    map['recordid'] = _recordid;
    map['Projectphotos'] = _projectphotos;
    map['ProjectName'] = _projectName;
    map['projectmap'] = _projectmap;
    map['ProjectDescription'] = _projectDescription;
    map['ProjectCity'] = _projectCity;
    map['message'] = _message;
    return map;
  }

}