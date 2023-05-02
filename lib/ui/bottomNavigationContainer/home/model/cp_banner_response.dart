/// returnCode : true
/// message : "Success"
/// bannerDataList : [{"Screen_Name":"CP Event","Banner_Type":"1","Banner_Name":"Test CP Event 3 March"},{"Screen_Name":"CP Event","Banner_Type":"1","Banner_Name":"Test CP Event PM"},{"Screen_Name":"Current Promotion","Banner_Type":"2","Banner_Name":"Current Promotion 23"},{"Screen_Name":"Current Promotion","Banner_Type":"2","Banner_Name":"Current Promo 18April"}]

class CpBannerResponse {
  CpBannerResponse({
      bool returnCode, 
      String message, 
      List<BannerDataList> bannerDataList,}){
    _returnCode = returnCode;
    _message = message;
    _bannerDataList = bannerDataList;
}

  CpBannerResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _message = json['message'];
    if (json['bannerDataList'] != null) {
      _bannerDataList = [];
      json['bannerDataList'].forEach((v) {
        _bannerDataList.add(BannerDataList.fromJson(v));
      });
    }
  }
  bool _returnCode;
  String _message;
  List<BannerDataList> _bannerDataList;
CpBannerResponse copyWith({  bool returnCode,
  String message,
  List<BannerDataList> bannerDataList,
}) => CpBannerResponse(  returnCode: returnCode ?? _returnCode,
  message: message ?? _message,
  bannerDataList: bannerDataList ?? _bannerDataList,
);
  bool get returnCode => _returnCode;
  String get message => _message;
  List<BannerDataList> get bannerDataList => _bannerDataList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    if (_bannerDataList != null) {
      map['bannerDataList'] = _bannerDataList.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// Screen_Name : "CP Event"
/// Banner_Type : "1"
/// Banner_Name : "Test CP Event 3 March"

class BannerDataList {
  BannerDataList({
      String screenName, 
      String bannerType, 
      String bannerName,}){
    _screenName = screenName;
    _bannerType = bannerType;
    _bannerName = bannerName;
}

  BannerDataList.fromJson(dynamic json) {
    _screenName = json['Screen_Name'];
    _bannerType = json['Banner_Type'];
    _bannerName = json['Banner_Name'];
  }
  String _screenName;
  String _bannerType;
  String _bannerName;
BannerDataList copyWith({  String screenName,
  String bannerType,
  String bannerName,
}) => BannerDataList(  screenName: screenName ?? _screenName,
  bannerType: bannerType ?? _bannerType,
  bannerName: bannerName ?? _bannerName,
);
  String get screenName => _screenName;
  String get bannerType => _bannerType;
  String get bannerName => _bannerName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Screen_Name'] = _screenName;
    map['Banner_Type'] = _bannerType;
    map['Banner_Name'] = _bannerName;
    return map;
  }

}