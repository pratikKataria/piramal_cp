import 'package:flutter/material.dart';

/// returnCode : true
/// ProjectWebsite : "www.piramalvaikunth.com"
/// ProjectName : "Piramal Vaikunth"
/// ProjectLocation : "South Mumbai - India"
/// ProjectImage : ""
/// ProjectId : "a03N0000005NHiTIAW"
/// MobileBroucher : "file:///C:/Users/Aniket/Downloads/CP%20APP%20Solution%20Document%20updated%20v2.pdf"
/// message : "Success"

class ProjectListResponse {
  Key key;
  Map<String, Key> mapOfKeys = {};

  ProjectListResponse({
      bool returnCode, 
      String projectWebsite, 
      String projectName, 
      String projectLocation, 
      String projectImage, 
      String projectId, 
      String mobileBroucher, 
      String message,}){
    _returnCode = returnCode;
    _projectWebsite = projectWebsite;
    _projectName = projectName;
    _projectLocation = projectLocation;
    _projectImage = projectImage;
    _projectId = projectId;
    _mobileBroucher = mobileBroucher;
    _message = message;
}

  ProjectListResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _projectWebsite = json['ProjectWebsite'];
    _projectName = json['ProjectName'];
    _projectLocation = json['ProjectLocation'];
    _projectImage = json['ProjectImage'];
    _projectId = json['ProjectId'];
    _mobileBroucher = json['MobileBroucher'];
    _message = json['message'];
  }
  bool _returnCode;
  String _projectWebsite;
  String _projectName;
  String _projectLocation;
  String _projectImage;
  String _projectId;
  String _mobileBroucher;
  String _message;

  bool get returnCode => _returnCode;
  String get projectWebsite => _projectWebsite;
  String get projectName => _projectName;
  String get projectLocation => _projectLocation;
  String get projectImage => _projectImage;
  String get projectId => _projectId;
  String get mobileBroucher => _mobileBroucher;
  String get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['ProjectWebsite'] = _projectWebsite;
    map['ProjectName'] = _projectName;
    map['ProjectLocation'] = _projectLocation;
    map['ProjectImage'] = _projectImage;
    map['ProjectId'] = _projectId;
    map['MobileBroucher'] = _mobileBroucher;
    map['message'] = _message;
    return map;
  }

}