/// returnCode : true
/// message : "Success"
/// conUpdateList : [{"Description":"Construction Update 2","constructionUpdatesList":["https://prl--prlapp.sandbox.file.force.com/sfc/dist/version/download/?oid=00Dp00000001TjB&ids=068p0000002DhwD&d=%2Fa%2Fp00000008zbF%2Ft2dctPWMYY5CnDPOHtgWFYqMaZAxBKD5wcJM1QZ4Ud4&asPdf=false","https://prl--prlapp.sandbox.file.force.com/sfc/dist/version/download/?oid=00Dp00000001TjB&ids=068p0000002Dhw8&d=%2Fa%2Fp00000008zbA%2FN8KPLlNauPv0rTZdst9UKabeUBHZEOGyckiyX_N6Rl8&asPdf=false"]},{"Description":"Construction Update 1","constructionUpdatesList":["https://prl--prlapp.sandbox.file.force.com/sfc/dist/version/download/?oid=00Dp00000001TjB&ids=068p0000002Dhw3&d=%2Fa%2Fp00000008zb5%2Fms_BCIw9.oAOiqmvWgNm7qYFxrkxqf91s4OPMb3Ia0E&asPdf=false","https://prl--prlapp.sandbox.file.force.com/sfc/dist/version/download/?oid=00Dp00000001TjB&ids=068p0000002Dhvy&d=%2Fa%2Fp00000008zb0%2FZ9PtzBFw6AgePRrFx16fne1zSnh51P.AtGTm6LOdjmQ&asPdf=false","https://prl--prlapp.sandbox.file.force.com/sfc/dist/version/download/?oid=00Dp00000001TjB&ids=068p0000002Dhvt&d=%2Fa%2Fp00000008zav%2FQ2ZfGj6c_JiljdQj0hedmv956j68QW4bfprgaZfmRIU&asPdf=false"]}]

class ConstructionUpdateResponse {
  ConstructionUpdateResponse({
      bool returnCode, 
      String message, 
      List<ConUpdateList> conUpdateList,}){
    _returnCode = returnCode;
    _message = message;
    _conUpdateList = conUpdateList;
}

  ConstructionUpdateResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _message = json['message'];
    if (json['conUpdateList'] != null) {
      _conUpdateList = [];
      json['conUpdateList'].forEach((v) {
        _conUpdateList.add(ConUpdateList.fromJson(v));
      });
    }
  }
  bool _returnCode;
  String _message;
  List<ConUpdateList> _conUpdateList;
ConstructionUpdateResponse copyWith({  bool returnCode,
  String message,
  List<ConUpdateList> conUpdateList,
}) => ConstructionUpdateResponse(  returnCode: returnCode ?? _returnCode,
  message: message ?? _message,
  conUpdateList: conUpdateList ?? _conUpdateList,
);
  bool get returnCode => _returnCode;
  String get message => _message;
  List<ConUpdateList> get conUpdateList => _conUpdateList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    if (_conUpdateList != null) {
      map['conUpdateList'] = _conUpdateList.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// Description : "Construction Update 2"
/// constructionUpdatesList : ["https://prl--prlapp.sandbox.file.force.com/sfc/dist/version/download/?oid=00Dp00000001TjB&ids=068p0000002DhwD&d=%2Fa%2Fp00000008zbF%2Ft2dctPWMYY5CnDPOHtgWFYqMaZAxBKD5wcJM1QZ4Ud4&asPdf=false","https://prl--prlapp.sandbox.file.force.com/sfc/dist/version/download/?oid=00Dp00000001TjB&ids=068p0000002Dhw8&d=%2Fa%2Fp00000008zbA%2FN8KPLlNauPv0rTZdst9UKabeUBHZEOGyckiyX_N6Rl8&asPdf=false"]

class ConUpdateList {
  ConUpdateList({
      String description, 
      List<String> constructionUpdatesList,}){
    _description = description;
    _constructionUpdatesList = constructionUpdatesList;
}

  ConUpdateList.fromJson(dynamic json) {
    _description = json['Description'];
    _constructionUpdatesList = json['constructionUpdatesList'] != null ? json['constructionUpdatesList'].cast<String>() : [];
  }
  String _description;
  List<String> _constructionUpdatesList;
ConUpdateList copyWith({  String description,
  List<String> constructionUpdatesList,
}) => ConUpdateList(  description: description ?? _description,
  constructionUpdatesList: constructionUpdatesList ?? _constructionUpdatesList,
);
  String get description => _description;
  List<String> get constructionUpdatesList => _constructionUpdatesList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Description'] = _description;
    map['constructionUpdatesList'] = _constructionUpdatesList;
    return map;
  }

}