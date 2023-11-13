/// returnCode : true
/// newsAndArticleList : [{"newsAndArticlesMediaList":["https://prl--prlapp.sandbox.file.force.com/sfc/dist/version/download/?oid=00Dp00000001TjB&ids=068F6000002A7pX&d=%2Fa%2FF60000004Xx6%2FKQzMA96c2x665ljioElu1PdDcTCLegGmHUrwpea.2aU&asPdf=false","https://prl--prlapp.sandbox.file.force.com/sfc/dist/version/download/?oid=00Dp00000001TjB&ids=068F6000002A7pS&d=%2Fa%2FF60000004Xx1%2FC8phvRiixtfhUpqByfoSEgF_jCYGgBcgpyT6HGquKnI&asPdf=false"],"newsAndArticleRecordId":"a3CF6000000qKdcMAE","Heading":"CP Article Heading"}]
/// message : "Success"

class NewsAndArticlesResponse {
  NewsAndArticlesResponse({
      bool returnCode, 
      List<NewsAndArticleList> newsAndArticleList, 
      String message,}){
    _returnCode = returnCode;
    _newsAndArticleList = newsAndArticleList;
    _message = message;
}

  NewsAndArticlesResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    if (json['newsAndArticleList'] != null) {
      _newsAndArticleList = [];
      json['newsAndArticleList'].forEach((v) {
        _newsAndArticleList.add(NewsAndArticleList.fromJson(v));
      });
    }
    _message = json['message'];
  }
  bool _returnCode;
  List<NewsAndArticleList> _newsAndArticleList;
  String _message;
NewsAndArticlesResponse copyWith({  bool returnCode,
  List<NewsAndArticleList> newsAndArticleList,
  String message,
}) => NewsAndArticlesResponse(  returnCode: returnCode ?? _returnCode,
  newsAndArticleList: newsAndArticleList ?? _newsAndArticleList,
  message: message ?? _message,
);
  bool get returnCode => _returnCode;
  List<NewsAndArticleList> get newsAndArticleList => _newsAndArticleList;
  String get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    if (_newsAndArticleList != null) {
      map['newsAndArticleList'] = _newsAndArticleList.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    return map;
  }

}

/// newsAndArticlesMediaList : ["https://prl--prlapp.sandbox.file.force.com/sfc/dist/version/download/?oid=00Dp00000001TjB&ids=068F6000002A7pX&d=%2Fa%2FF60000004Xx6%2FKQzMA96c2x665ljioElu1PdDcTCLegGmHUrwpea.2aU&asPdf=false","https://prl--prlapp.sandbox.file.force.com/sfc/dist/version/download/?oid=00Dp00000001TjB&ids=068F6000002A7pS&d=%2Fa%2FF60000004Xx1%2FC8phvRiixtfhUpqByfoSEgF_jCYGgBcgpyT6HGquKnI&asPdf=false"]
/// newsAndArticleRecordId : "a3CF6000000qKdcMAE"
/// Heading : "CP Article Heading"

class NewsAndArticleList {
  NewsAndArticleList({
      List<String> newsAndArticlesMediaList, 
      String newsAndArticleRecordId, 
      String heading,}){
    _newsAndArticlesMediaList = newsAndArticlesMediaList;
    _newsAndArticleRecordId = newsAndArticleRecordId;
    _heading = heading;
}

  NewsAndArticleList.fromJson(dynamic json) {
    _newsAndArticlesMediaList = json['newsAndArticlesMediaList'] != null ? json['newsAndArticlesMediaList'].cast<String>() : [];
    _newsAndArticleRecordId = json['newsAndArticleRecordId'];
    _heading = json['Heading'];
  }
  List<String> _newsAndArticlesMediaList;
  String _newsAndArticleRecordId;
  String _heading;
NewsAndArticleList copyWith({  List<String> newsAndArticlesMediaList,
  String newsAndArticleRecordId,
  String heading,
}) => NewsAndArticleList(  newsAndArticlesMediaList: newsAndArticlesMediaList ?? _newsAndArticlesMediaList,
  newsAndArticleRecordId: newsAndArticleRecordId ?? _newsAndArticleRecordId,
  heading: heading ?? _heading,
);
  List<String> get newsAndArticlesMediaList => _newsAndArticlesMediaList;
  String get newsAndArticleRecordId => _newsAndArticleRecordId;
  String get heading => _heading;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['newsAndArticlesMediaList'] = _newsAndArticlesMediaList;
    map['newsAndArticleRecordId'] = _newsAndArticleRecordId;
    map['Heading'] = _heading;
    return map;
  }

}