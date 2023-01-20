/// access_token : "00Dp00000001TjB!ARYAQIehPqb4bJnSQpsDqKRHCUQDJNYoQq6PoJ93X5txspYuX80OuJX7tiC9hAPNkxJoasp7FJkDV2KcWaCDHwJlXhlLi.jb"
/// instance_url : "https://prl--PRLAPP.my.salesforce.com"
/// id : "https://test.salesforce.com/id/00Dp00000001TjBEAU/005p0000004R4ifAAC"
/// token_type : "Bearer"
/// issued_at : "1643036907661"
/// signature : "MC+FatYoL/FKJvKPKCIONivtFsb0Uu9R4Mu1JYQYmDE="

class TokenResponse {
  TokenResponse({
      String accessToken, 
      String instanceUrl, 
      String id, 
      String tokenType, 
      String issuedAt, 
      String signature,}){
    _accessToken = accessToken;
    _instanceUrl = instanceUrl;
    _id = id;
    _tokenType = tokenType;
    _issuedAt = issuedAt;
    _signature = signature;
}

  TokenResponse.fromJson(dynamic json) {
    _accessToken = json['access_token'];
    _instanceUrl = json['instance_url'];
    _id = json['id'];
    _tokenType = json['token_type'];
    _issuedAt = json['issued_at'];
    _signature = json['signature'];
  }
  String _accessToken;
  String _instanceUrl;
  String _id;
  String _tokenType;
  String _issuedAt;
  String _signature;

  String get accessToken => _accessToken;
  String get instanceUrl => _instanceUrl;
  String get id => _id;
  String get tokenType => _tokenType;
  String get issuedAt => _issuedAt;
  String get signature => _signature;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['access_token'] = _accessToken;
    map['instance_url'] = _instanceUrl;
    map['id'] = _id;
    map['token_type'] = _tokenType;
    map['issued_at'] = _issuedAt;
    map['signature'] = _signature;
    return map;
  }

}