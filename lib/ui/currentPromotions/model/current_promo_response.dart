/// Title : "Test Project"
/// ShortDescription : "Pune"
/// sfdcid : "a2mp0000001Iw7OAAS"
/// returnCode : 2
/// Project : "Piramal Revanta"
/// Name : "test Promo"
/// Mobilenumber : "9999111111"
/// message : "Success"
/// Location : "Pune"
/// Image : "<img alt=\"User-added image\" src=\"https://prl--PRLAPP--c.cs31.content.force.com/servlet/rtaImage?eid=a2mp0000001Iw7O&amp;feoid=00Np00000052VaN&amp;refid=0EMp0000000AIjy\" style=\"height: 500px; width: 500px;\"></img>"
/// Download : ""

class CurrentPromoResponse {
  CurrentPromoResponse({
      String title, 
      String shortDescription, 
      String sfdcid, 
      bool returnCode,
      String project, 
      String name, 
      String mobilenumber, 
      String message, 
      String location, 
      String image, 
      String download,}){
    _title = title;
    _shortDescription = shortDescription;
    _sfdcid = sfdcid;
    _returnCode = returnCode;
    _project = project;
    _name = name;
    _mobilenumber = mobilenumber;
    _message = message;
    _location = location;
    _image = image;
    _download = download;
}

  CurrentPromoResponse.fromJson(dynamic json) {
    _title = json['Title'];
    _shortDescription = json['ShortDescription'];
    _sfdcid = json['sfdcid'];
    _returnCode = json['returnCode'];
    _project = json['Project'];
    _name = json['Name'];
    _mobilenumber = json['Mobilenumber'];
    _message = json['message'];
    _location = json['Location'];
    _image = json['Image'];
    _download = json['Download'];
  }
  String _title;
  String _shortDescription;
  String _sfdcid;
  bool _returnCode;
  String _project;
  String _name;
  String _mobilenumber;
  String _message;
  String _location;
  String _image;
  String _download;

  String get title => _title;
  String get shortDescription => _shortDescription;
  String get sfdcid => _sfdcid;
  bool get returnCode => _returnCode;
  String get project => _project;
  String get name => _name;
  String get mobilenumber => _mobilenumber;
  String get message => _message;
  String get location => _location;
  String get image => _image;
  String get download => _download;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Title'] = _title;
    map['ShortDescription'] = _shortDescription;
    map['sfdcid'] = _sfdcid;
    map['returnCode'] = _returnCode;
    map['Project'] = _project;
    map['Name'] = _name;
    map['Mobilenumber'] = _mobilenumber;
    map['message'] = _message;
    map['Location'] = _location;
    map['Image'] = _image;
    map['Download'] = _download;
    return map;
  }

}