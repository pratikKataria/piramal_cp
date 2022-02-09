/// TowerName : ""
/// returnCode : true
/// ProjectName : "Piramal Vaikunth"
/// message : ""
/// DownloadLinkAPP : ""

class ProjectDownloadResponse {
  ProjectDownloadResponse({
      String towerName, 
      bool returnCode, 
      String projectName, 
      String message, 
      String downloadLinkAPP,}){
    _towerName = towerName;
    _returnCode = returnCode;
    _projectName = projectName;
    _message = message;
    _downloadLinkAPP = downloadLinkAPP;
}

  ProjectDownloadResponse.fromJson(dynamic json) {
    _towerName = json['TowerName'];
    _returnCode = json['returnCode'];
    _projectName = json['ProjectName'];
    _message = json['message'];
    _downloadLinkAPP = json['DownloadLinkAPP'];
  }
  String _towerName;
  bool _returnCode;
  String _projectName;
  String _message;
  String _downloadLinkAPP;

  String get towerName => _towerName;
  bool get returnCode => _returnCode;
  String get projectName => _projectName;
  String get message => _message;
  String get downloadLinkAPP => _downloadLinkAPP;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TowerName'] = _towerName;
    map['returnCode'] = _returnCode;
    map['ProjectName'] = _projectName;
    map['message'] = _message;
    map['DownloadLinkAPP'] = _downloadLinkAPP;
    return map;
  }

}