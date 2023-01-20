/// returnCode : true
/// message : "SUCCESS"
/// BrochureDownloadLink : "https://prl--prlapp.sandbox.my.salesforce-sites.com/VfPage?RecordId=a03N0000005NHiT&customerAccountId=001p000000zxu63&token=00Dp00000001TjB!ARYAQKz5avpSOZkBE6JiGhabNfPGXbC2dkGvc5PlbzE.MhxXvyqmDVN.WFPUv2ljipET8lS1ks94G0vDS26CddZ5geLt2ugA"

class LwcDownloadResponse {
  LwcDownloadResponse({
      bool returnCode, 
      String message, 
      String brochureDownloadLink,}){
    _returnCode = returnCode;
    _message = message;
    _brochureDownloadLink = brochureDownloadLink;
}

  LwcDownloadResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _message = json['message'];
    _brochureDownloadLink = json['BrochureDownloadLink'];
  }
  bool _returnCode;
  String _message;
  String _brochureDownloadLink;
LwcDownloadResponse copyWith({  bool returnCode,
  String message,
  String brochureDownloadLink,
}) => LwcDownloadResponse(  returnCode: returnCode ?? _returnCode,
  message: message ?? _message,
  brochureDownloadLink: brochureDownloadLink ?? _brochureDownloadLink,
);
  bool get returnCode => _returnCode;
  String get message => _message;
  String get brochureDownloadLink => _brochureDownloadLink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    map['BrochureDownloadLink'] = _brochureDownloadLink;
    return map;
  }

}