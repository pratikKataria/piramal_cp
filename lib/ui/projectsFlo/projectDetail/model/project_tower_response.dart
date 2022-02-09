/// TowerName : "Vairat"
/// Tower_Website : ""
/// Tower_Image : ""
/// returnCode : true
/// ProjectName : "Piramal Vaikunth"
/// message : "SUCCESS"

class ProjectTowerResponse {
  ProjectTowerResponse({
      String towerName, 
      String towerWebsite, 
      String towerImage, 
      bool returnCode, 
      String projectName, 
      String message,}){
    _towerName = towerName;
    _towerWebsite = towerWebsite;
    _towerImage = towerImage;
    _returnCode = returnCode;
    _projectName = projectName;
    _message = message;
}

  ProjectTowerResponse.fromJson(dynamic json) {
    _towerName = json['TowerName'];
    _towerWebsite = json['Tower_Website'];
    _towerImage = json['Tower_Image'];
    _returnCode = json['returnCode'];
    _projectName = json['ProjectName'];
    _message = json['message'];
  }
  String _towerName;
  String _towerWebsite;
  String _towerImage;
  bool _returnCode;
  String _projectName;
  String _message;

  String get towerName => _towerName;
  String get towerWebsite => _towerWebsite;
  String get towerImage => _towerImage;
  bool get returnCode => _returnCode;
  String get projectName => _projectName;
  String get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TowerName'] = _towerName;
    map['Tower_Website'] = _towerWebsite;
    map['Tower_Image'] = _towerImage;
    map['returnCode'] = _returnCode;
    map['ProjectName'] = _projectName;
    map['message'] = _message;
    return map;
  }

}