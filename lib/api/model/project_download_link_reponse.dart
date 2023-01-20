/// returnCode : true
/// message : "Success"
/// downloadlink : "https://prl--PRLAPP--\nc.cs31.content.force.com/sfc/dist/version/download/?oid=00Dp00000001TjB&ids=068p0000002\nBIuI&d=%2Fa%2Fp00000008nRl%2FiEAhvzm4nt80lEMknR3Efqbf8CMXGMWmSxl3Lv.eH\nvc&asPdf=false"

class ProjectDownloadLinkReponse {
  ProjectDownloadLinkReponse({
      bool returnCode, 
      String message, 
      String downloadlink,}){
    _returnCode = returnCode;
    _message = message;
    _downloadlink = downloadlink;
}

  ProjectDownloadLinkReponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _message = json['message'];
    _downloadlink = json['downloadlink'];
  }
  bool _returnCode;
  String _message;
  String _downloadlink;

  bool get returnCode => _returnCode;
  String get message => _message;
  String get downloadlink => _downloadlink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    map['downloadlink'] = _downloadlink;
    return map;
  }

}