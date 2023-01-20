/// returnCode : 2
/// recordid : "a03N0000005NHiTIAW"
/// ProjectAmenitiesList : ["",""]
/// ProjectAmenitiesImage : ["",""]
/// message : "SUCCESS"

class ProjectAmenitiesResponse {
  ProjectAmenitiesResponse({
    bool returnCode,
    String recordid,
    String projectAmenitiesList,
    String projectAmenitiesImage,
    String message,
  }) {
    _returnCode = returnCode;
    _recordid = recordid;
    _projectAmenitiesList = projectAmenitiesList;
    _projectAmenitiesImage = projectAmenitiesImage;
    _message = message;
  }

  ProjectAmenitiesResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _recordid = json['recordid'];
    _projectAmenitiesList = json['ProjectAmenitiesList'] != null ? json['ProjectAmenitiesList'] : "";
    _projectAmenitiesImage = json['ProjectAmenitiesImage'] != null ? json['ProjectAmenitiesImage'] : "";
    _message = json['message'];
  }

  bool _returnCode;
  String _recordid;
  String _projectAmenitiesList;
  String _projectAmenitiesImage;
  String _message;

  bool get returnCode => _returnCode;

  String get recordid => _recordid;

  String get projectAmenitiesList => _projectAmenitiesList != null ? _projectAmenitiesList.replaceAll("<br>", "\n") : "";

  String get projectAmenitiesImage => _projectAmenitiesImage;

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
