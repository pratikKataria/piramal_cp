/// returnCode : true
/// message : "Success"
/// downloadlink : "https://prl--PRLAPP--c.cs31.content.force.com/sfc/dist/version/download/?oid=00Dp00000001TjB&ids=068p0000002BZ8K&d=%2Fa%2Fp00000008o6E%2FUS6AZUrKVXlniSFEF3kXMS9KliJGQ.hPTWC_dfFJ8vo&asPdf=false"

class ProjectOverviewBottomImages {
  ProjectOverviewBottomImages({
      bool returnCode, 
      String message, 
      String downloadlink,}){
    _returnCode = returnCode;
    _message = message;
    _downloadlink = downloadlink;
}

  ProjectOverviewBottomImages.fromJson(dynamic json) {
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