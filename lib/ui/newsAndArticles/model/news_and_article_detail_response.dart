/// returnCode : true
/// Published_Date : "10/11/2023"
/// newsAndArticlesMediaList : ["https://prl--prlapp.sandbox.file.force.com/sfc/dist/version/download/?oid=00Dp00000001TjB&ids=068F6000002A7pX&d=%2Fa%2FF60000004Xx6%2FKQzMA96c2x665ljioElu1PdDcTCLegGmHUrwpea.2aU&asPdf=false","https://prl--prlapp.sandbox.file.force.com/sfc/dist/version/download/?oid=00Dp00000001TjB&ids=068F6000002A7pS&d=%2Fa%2FF60000004Xx1%2FC8phvRiixtfhUpqByfoSEgF_jCYGgBcgpyT6HGquKnI&asPdf=false"]
/// message : "Success"
/// Heading : "CP Article Heading"
/// Description : "Channel partners act as an extension of a company's sales and marketing efforts, and managing these relationships successfully allows businesses to reach new markets and customers they may not have been able to get to on their own."

class NewsAndArticleDetailResponse {
  NewsAndArticleDetailResponse({
      bool returnCode, 
      String publishedDate, 
      List<String> newsAndArticlesMediaList, 
      String message, 
      String heading, 
      String description,}){
    _returnCode = returnCode;
    _publishedDate = publishedDate;
    _newsAndArticlesMediaList = newsAndArticlesMediaList;
    _message = message;
    _heading = heading;
    _description = description;
}

  NewsAndArticleDetailResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _publishedDate = json['Published_Date'];
    _newsAndArticlesMediaList = json['newsAndArticlesMediaList'] != null ? json['newsAndArticlesMediaList'].cast<String>() : [];
    _message = json['message'];
    _heading = json['Heading'];
    _description = json['Description'];
  }
  bool _returnCode;
  String _publishedDate;
  List<String> _newsAndArticlesMediaList;
  String _message;
  String _heading;
  String _description;
NewsAndArticleDetailResponse copyWith({  bool returnCode,
  String publishedDate,
  List<String> newsAndArticlesMediaList,
  String message,
  String heading,
  String description,
}) => NewsAndArticleDetailResponse(  returnCode: returnCode ?? _returnCode,
  publishedDate: publishedDate ?? _publishedDate,
  newsAndArticlesMediaList: newsAndArticlesMediaList ?? _newsAndArticlesMediaList,
  message: message ?? _message,
  heading: heading ?? _heading,
  description: description ?? _description,
);
  bool get returnCode => _returnCode;
  String get publishedDate => _publishedDate;
  List<String> get newsAndArticlesMediaList => _newsAndArticlesMediaList;
  String get message => _message;
  String get heading => _heading;
  String get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['Published_Date'] = _publishedDate;
    map['newsAndArticlesMediaList'] = _newsAndArticlesMediaList;
    map['message'] = _message;
    map['Heading'] = _heading;
    map['Description'] = _description;
    return map;
  }

}