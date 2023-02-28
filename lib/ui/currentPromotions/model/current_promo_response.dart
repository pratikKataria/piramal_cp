/// Title : "test"
/// ShortDescription : "test"
/// sfdcid : "a2mp0000001JHAtAAO"
/// returnCode : true
/// ProjectImageList : ["https://prl--prlapp.sandbox.file.force.com/sfc/dist/version/download/?oid=00Dp00000001TjB&ids=068p0000002DDG3&d=%2Fa%2Fp00000008ySn%2Fju_a8qrFq.zkyAwHYXVxo_IbOuOXkiT.HkQKomYXytU&asPdf=false","https://prl--prlapp.sandbox.file.force.com/sfc/dist/version/download/?oid=00Dp00000001TjB&ids=068p0000002DDFy&d=%2Fa%2Fp00000008ySi%2FDO23R2gqUJFIvqJtuobZjRo9ipWlX5YfUesu.7iFvnQ&asPdf=false"]
/// Project : "Piramal Mahalaxmi"
/// Name : "test current1"
/// Mobilenumber : "9999999911"
/// message : "Success"
/// Location : "Mumbai"
/// Download : ""

class CurrentPromoResponse {
  CurrentPromoResponse({
      String title, 
      String shortDescription, 
      String sfdcid, 
      bool returnCode, 
      List<String> projectImageList, 
      String project, 
      String name, 
      String mobilenumber, 
      String message, 
      String location, 
      String download,}){
    _title = title;
    _shortDescription = shortDescription;
    _sfdcid = sfdcid;
    _returnCode = returnCode;
    _projectImageList = projectImageList;
    _project = project;
    _name = name;
    _mobilenumber = mobilenumber;
    _message = message;
    _location = location;
    _download = download;
}

  CurrentPromoResponse.fromJson(dynamic json) {
    _title = json['Title'];
    _shortDescription = json['ShortDescription'];
    _sfdcid = json['sfdcid'];
    _returnCode = json['returnCode'];
    _projectImageList = json['ProjectImageList'] != null ? json['ProjectImageList'].cast<String>() : [];
    _project = json['Project'];
    _name = json['Name'];
    _mobilenumber = json['Mobilenumber'];
    _message = json['message'];
    _location = json['Location'];
    _download = json['Download'];
  }
  String _title;
  String _shortDescription;
  String _sfdcid;
  bool _returnCode;
  List<String> _projectImageList;
  String _project;
  String _name;
  String _mobilenumber;
  String _message;
  String _location;
  String _download;
CurrentPromoResponse copyWith({  String title,
  String shortDescription,
  String sfdcid,
  bool returnCode,
  List<String> projectImageList,
  String project,
  String name,
  String mobilenumber,
  String message,
  String location,
  String download,
}) => CurrentPromoResponse(  title: title ?? _title,
  shortDescription: shortDescription ?? _shortDescription,
  sfdcid: sfdcid ?? _sfdcid,
  returnCode: returnCode ?? _returnCode,
  projectImageList: projectImageList ?? _projectImageList,
  project: project ?? _project,
  name: name ?? _name,
  mobilenumber: mobilenumber ?? _mobilenumber,
  message: message ?? _message,
  location: location ?? _location,
  download: download ?? _download,
);
  String get title => _title;
  String get shortDescription => _shortDescription;
  String get sfdcid => _sfdcid;
  bool get returnCode => _returnCode;
  List<String> get projectImageList => _projectImageList;
  String get project => _project;
  String get name => _name;
  String get mobilenumber => _mobilenumber;
  String get message => _message;
  String get location => _location;
  String get download => _download;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Title'] = _title;
    map['ShortDescription'] = _shortDescription;
    map['sfdcid'] = _sfdcid;
    map['returnCode'] = _returnCode;
    map['ProjectImageList'] = _projectImageList;
    map['Project'] = _project;
    map['Name'] = _name;
    map['Mobilenumber'] = _mobilenumber;
    map['message'] = _message;
    map['Location'] = _location;
    map['Download'] = _download;
    return map;
  }

}