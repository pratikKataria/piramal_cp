import 'package:piramal_channel_partner/ui/core/login/model/login_response.dart';
import 'package:piramal_channel_partner/ui/core/login/model/token_response.dart';

class CurrentUser {
  LoginResponse _userCredentials;
  TokenResponse _tokenResponse;
  bool _isLoggedIn;

  CurrentUser({
    LoginResponse userCredentials,
    TokenResponse tokenResponse,
    bool isLoggedIn,
  })  : _userCredentials = userCredentials,
        _tokenResponse = tokenResponse,
        _isLoggedIn = isLoggedIn;

  bool get isLoggedIn => _isLoggedIn ?? false;

  LoginResponse get userCredentials => _userCredentials;

  TokenResponse get tokenResponse => _tokenResponse;

  factory CurrentUser.fromMap(Map<String, dynamic> map) {
    return CurrentUser(
        userCredentials: LoginResponse.fromMap(map['_userCredentials']),
        tokenResponse: TokenResponse.fromJson(map["_tokenResponse"]),
        isLoggedIn: map['isLogin']);
  }

  Map<String, dynamic> toMap() {
    return {
      '_userCredentials': this.userCredentials?.toMap(),
      '_tokenResponse': this.tokenResponse?.toJson(),
      'isLogin': this.isLoggedIn,
    };
  }

  set userCredentials(LoginResponse value) {
    _userCredentials = value;
  }

  set isLoggedIn(bool value) {
    _isLoggedIn = value;
  }

  set tokenResponse(TokenResponse value) {
    _tokenResponse = value;
  }
}
