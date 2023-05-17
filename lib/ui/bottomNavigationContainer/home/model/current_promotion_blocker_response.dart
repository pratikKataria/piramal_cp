/// returnCode : true
/// pageBlockerList : [{"website":"www.google.com","imageURL":"https://prl--prlapp.sandbox.file.force.com/sfc/dist/version/download/?oid=00Dp00000001TjB&ids=068p0000002DgjI&d=%2Fa%2Fp00000008zTk%2FVY3MiMU3VU1lvV7fk2qZJAwsEr4vU2ndfHgoYXOWjiY&asPdf=false"}]
/// message : "Success"

class CurrentPromotionBlockerResponse {
  CurrentPromotionBlockerResponse({
      bool returnCode, 
      List<PageBlockerList> pageBlockerList, 
      String message,}){
    _returnCode = returnCode;
    _pageBlockerList = pageBlockerList;
    _message = message;
}

  CurrentPromotionBlockerResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    if (json['pageBlockerList'] != null) {
      _pageBlockerList = [];
      json['pageBlockerList'].forEach((v) {
        _pageBlockerList.add(PageBlockerList.fromJson(v));
      });
    }
    _message = json['message'];
  }
  bool _returnCode;
  List<PageBlockerList> _pageBlockerList;
  String _message;
CurrentPromotionBlockerResponse copyWith({  bool returnCode,
  List<PageBlockerList> pageBlockerList,
  String message,
}) => CurrentPromotionBlockerResponse(  returnCode: returnCode ?? _returnCode,
  pageBlockerList: pageBlockerList ?? _pageBlockerList,
  message: message ?? _message,
);
  bool get returnCode => _returnCode;
  List<PageBlockerList> get pageBlockerList => _pageBlockerList;
  String get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    if (_pageBlockerList != null) {
      map['pageBlockerList'] = _pageBlockerList.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    return map;
  }

}

/// website : "www.google.com"
/// imageURL : "https://prl--prlapp.sandbox.file.force.com/sfc/dist/version/download/?oid=00Dp00000001TjB&ids=068p0000002DgjI&d=%2Fa%2Fp00000008zTk%2FVY3MiMU3VU1lvV7fk2qZJAwsEr4vU2ndfHgoYXOWjiY&asPdf=false"

class PageBlockerList {
  PageBlockerList({
      String website, 
      String imageURL,}){
    _website = website;
    _imageURL = imageURL;
}

  PageBlockerList.fromJson(dynamic json) {
    _website = json['website'];
    _imageURL = json['imageURL'];
  }
  String _website;
  String _imageURL;
PageBlockerList copyWith({  String website,
  String imageURL,
}) => PageBlockerList(  website: website ?? _website,
  imageURL: imageURL ?? _imageURL,
);
  String get website => _website;
  String get imageURL => _imageURL;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['website'] = _website;
    map['imageURL'] = _imageURL;
    return map;
  }

}