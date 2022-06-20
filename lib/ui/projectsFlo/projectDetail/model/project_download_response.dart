/// TowerName : ""
/// returnCode : true
/// ProjectName : "Piramal Vaikunth"
/// message : ""
/// DownloadLinkAPP : ""

class ProjectDownloadResponse {
  String projectId = "";

  ProjectDownloadResponse({
    String towerName,
    String siteManagerMobile,
    bool returnCode,
    String projectName,
    String message,
    String masterPlanLink,
    String floorplanlink,
    String towerID,
    String brochure,
    String brochureWhatsappLink,
  }) {
    _towerName = towerName;
    _siteManagerMobile = siteManagerMobile;
    _returnCode = returnCode;
    _projectName = projectName;
    _message = message;
    _masterPlanLink = masterPlanLink;
    _floorplanlink = floorplanlink;
    _brochure = brochure;
    _towerID = towerID;
    _brochureWhatsappLink = brochureWhatsappLink;
  }

  ProjectDownloadResponse.fromJson(dynamic json) {
    _towerName = json['TowerName'];
    _siteManagerMobile = json['SiteManagerMobile'];
    _returnCode = json['returnCode'];
    _projectName = json['ProjectName'];
    _message = json['message'];
    _masterPlanLink = json['MasterPlanLink'];
    _floorplanlink = json['floorplanlink'];
    _brochure = json['brochure'];
    _towerID = json['TowerID'];
    _brochureWhatsappLink = json['BrochureWhatsappLink'];
  }

  String _towerName;
  String _siteManagerMobile;
  bool _returnCode;
  String _projectName;
  String _message;
  String _masterPlanLink;
  String _floorplanlink;
  String _brochure;
  String _towerID;
  String _brochureWhatsappLink;

  String get towerName => _towerName;

  String get siteManagerMobile => _siteManagerMobile;

  bool get returnCode => _returnCode;

  String get projectName => _projectName;

  String get message => _message;

  String get masterPlanLink => _masterPlanLink;

  String get floorplanlink => _floorplanlink;

  String get brochure => _brochure;

  String get towerID => _towerID;

  String get brochureWhatsappLink => _brochureWhatsappLink;

  set brochureWhatsappLink(String value) {
    _brochureWhatsappLink = value;
  }

  set towerID(String value) {
    _towerID = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TowerName'] = _towerName;
    map['SiteManagerMobile'] = _siteManagerMobile;
    map['returnCode'] = _returnCode;
    map['ProjectName'] = _projectName;
    map['message'] = _message;
    map['MasterPlanLink'] = _masterPlanLink;
    map['floorplanlink'] = _floorplanlink;
    map['brochure'] = _brochure;
    map['TowerID'] = _towerID;
    map['BrochureWhatsappLink'] = _brochureWhatsappLink;
    return map;
  }
}
