/// returnCode : true
/// message : "Success"
/// detailsList : [{"Video_URL":"https://www.youtube.com/watch?v=oNFGC7S4cw0","Video_Heading":"PA Project Video"},{"Video_URL":"https://www.youtube.com/watch?v=bXeW2QtVeUs","Video_Heading":"PM Offer Video"}]

class VideoResponseModel {
  VideoResponseModel({
      bool returnCode, 
      String message, 
      List<DetailsList> detailsList,}){
    _returnCode = returnCode;
    _message = message;
    _detailsList = detailsList;
}

  VideoResponseModel.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _message = json['message'];
    if (json['detailsList'] != null) {
      _detailsList = [];
      json['detailsList'].forEach((v) {
        _detailsList.add(DetailsList.fromJson(v));
      });
    }
  }
  bool _returnCode;
  String _message;
  List<DetailsList> _detailsList;
VideoResponseModel copyWith({  bool returnCode,
  String message,
  List<DetailsList> detailsList,
}) => VideoResponseModel(  returnCode: returnCode ?? _returnCode,
  message: message ?? _message,
  detailsList: detailsList ?? _detailsList,
);
  bool get returnCode => _returnCode;
  String get message => _message;
  List<DetailsList> get detailsList => _detailsList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    if (_detailsList != null) {
      map['detailsList'] = _detailsList.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// Video_URL : "https://www.youtube.com/watch?v=oNFGC7S4cw0"
/// Video_Heading : "PA Project Video"

class DetailsList {
  DetailsList({
      String videoURL, 
      String videoHeading,}){
    _videoURL = videoURL;
    _videoHeading = videoHeading;
}

  DetailsList.fromJson(dynamic json) {
    _videoURL = json['Video_URL'];
    _videoHeading = json['Video_Heading'];
  }
  String _videoURL;
  String _videoHeading;
DetailsList copyWith({  String videoURL,
  String videoHeading,
}) => DetailsList(  videoURL: videoURL ?? _videoURL,
  videoHeading: videoHeading ?? _videoHeading,
);
  String get videoURL => _videoURL;
  String get videoHeading => _videoHeading;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Video_URL'] = _videoURL;
    map['Video_Heading'] = _videoHeading;
    return map;
  }

}