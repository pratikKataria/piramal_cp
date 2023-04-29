/// returnCode : true
/// message : "Success"
/// constructionUpdatesList : ["https://prl--prlapp.sandbox.file.force.com/sfc/dist/version/download/?oid=00Dp00000001TjB&ids=068p0000002DeDz&d=%2Fa%2Fp00000008zAx%2FqMr.YhsBCoq5LOYmg40x2UzboHv2Wd6TVn3iUJ2mkLA&asPdf=false","https://prl--prlapp.sandbox.file.force.com/sfc/dist/version/download/?oid=00Dp00000001TjB&ids=068p0000002D15G&d=%2Fa%2Fp00000008u3t%2F1sRMevD8mj.h13Htpq_jWzMs1nSBpfbqwsKW39wf4Wc&asPdf=false"]

class ConstructionUpdateResponse {
  ConstructionUpdateResponse({
      bool returnCode, 
      String message, 
      List<String> constructionUpdatesList,}){
    _returnCode = returnCode;
    _message = message;
    _constructionUpdatesList = constructionUpdatesList;
}

  ConstructionUpdateResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _message = json['message'];
    _constructionUpdatesList = json['constructionUpdatesList'] != null ? json['constructionUpdatesList'].cast<String>() : [];
  }
  bool _returnCode;
  String _message;
  List<String> _constructionUpdatesList;
ConstructionUpdateResponse copyWith({  bool returnCode,
  String message,
  List<String> constructionUpdatesList,
}) => ConstructionUpdateResponse(  returnCode: returnCode ?? _returnCode,
  message: message ?? _message,
  constructionUpdatesList: constructionUpdatesList ?? _constructionUpdatesList,
);
  bool get returnCode => _returnCode;
  String get message => _message;
  List<String> get constructionUpdatesList => _constructionUpdatesList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    map['constructionUpdatesList'] = _constructionUpdatesList;
    return map;
  }

}