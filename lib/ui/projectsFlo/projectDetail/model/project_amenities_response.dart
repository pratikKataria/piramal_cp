/// returnCode : 2
/// recordid : "a03N0000005NHiTIAW"
/// ProjectAmenitiesList : ["",""]
/// ProjectAmenitiesImage : ["",""]
/// message : "SUCCESS"

class ProjectAmenitiesResponse {
  ProjectAmenitiesResponse({
      int returnCode, 
      String recordid, 
      List<String> projectAmenitiesList, 
      List<String> projectAmenitiesImage, 
      String message,}){
    _returnCode = returnCode;
    _recordid = recordid;
    _projectAmenitiesList = projectAmenitiesList;
    _projectAmenitiesImage = projectAmenitiesImage;
    _message = message;
}

  ProjectAmenitiesResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _recordid = json['recordid'];
    _projectAmenitiesList = json['ProjectAmenitiesList'] != null ? json['ProjectAmenitiesList'].cast<String>() : [];
    _projectAmenitiesImage = json['ProjectAmenitiesImage'] != null ? json['ProjectAmenitiesImage'].cast<String>() : [];
    _message = json['message'];
  }
  int _returnCode;
  String _recordid;
  List<String> _projectAmenitiesList;
  List<String> _projectAmenitiesImage;
  String _message;

  int get returnCode => _returnCode;
  String get recordid => _recordid;
  List<String> get projectAmenitiesList => _projectAmenitiesList;
  List<String> get projectAmenitiesImage => _projectAmenitiesImage;
  String get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['recordid'] = _recordid;
    map['ProjectAmenitiesList'] = _projectAmenitiesList;
    map['ProjectAmenitiesImage'] = _projectAmenitiesImage;
    map['message'] = _message;
    return map;
  }

}