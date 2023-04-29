/// returnCode : true
/// pageBlockersImagesList : ["https://prl--prlapp.sandbox.file.force.com/sfc/dist/version/download/?oid=00Dp00000001TjB&ids=068p0000002DeJP&d=%2Fa%2Fp00000008zBh%2Fow8fkNM8Ad.E6PSQ1OMKvABSAawvSWF3U9uNuhZKmIY&asPdf=false","https://prl--prlapp.sandbox.file.force.com/sfc/dist/version/download/?oid=00Dp00000001TjB&ids=068p0000002DeJO&d=%2Fa%2Fp00000008zBg%2Fv7_0UzBjuB5cmwkDvgvDFx5Z72x5.fx7oBmgQpWkbos&asPdf=false"]
/// message : "Success"

class CurrentPromotionBlockerResponse {
  CurrentPromotionBlockerResponse({
      bool returnCode, 
      List<String> pageBlockersImagesList, 
      String message,}){
    _returnCode = returnCode;
    _pageBlockersImagesList = pageBlockersImagesList;
    _message = message;
}

  CurrentPromotionBlockerResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _pageBlockersImagesList = json['pageBlockersImagesList'] != null ? json['pageBlockersImagesList'].cast<String>() : [];
    _message = json['message'];
  }
  bool _returnCode;
  List<String> _pageBlockersImagesList;
  String _message;
CurrentPromotionBlockerResponse copyWith({  bool returnCode,
  List<String> pageBlockersImagesList,
  String message,
}) => CurrentPromotionBlockerResponse(  returnCode: returnCode ?? _returnCode,
  pageBlockersImagesList: pageBlockersImagesList ?? _pageBlockersImagesList,
  message: message ?? _message,
);
  bool get returnCode => _returnCode;
  List<String> get pageBlockersImagesList => _pageBlockersImagesList;
  String get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['pageBlockersImagesList'] = _pageBlockersImagesList;
    map['message'] = _message;
    return map;
  }

}