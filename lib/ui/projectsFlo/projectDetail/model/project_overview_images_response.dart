/// returnCode : true
/// ProjectPic : "/9j/4AAQSkZJRgABAQEA---------------------"
/// message : "success"

class ProjectOverviewImagesResponse {
  ProjectOverviewImagesResponse({
      bool returnCode, 
      String projectPic, 
      String message,}){
    _returnCode = returnCode;
    _projectPic = projectPic;
    _message = message;
}

  ProjectOverviewImagesResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _projectPic = json['ProjectPic'];
    _message = json['message'];
  }
  bool _returnCode;
  String _projectPic;
  String _message;

  bool get returnCode => _returnCode;
  String get projectPic => _projectPic;
  String get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['ProjectPic'] = _projectPic;
    map['message'] = _message;
    return map;
  }

}