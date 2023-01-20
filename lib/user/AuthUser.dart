import 'dart:convert';

import 'package:piramal_channel_partner/res/keys.dart';
import 'package:piramal_channel_partner/utils/SharedManager.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

import 'CurrentUser.dart';

/// Created by Pratik Kataria on 04-03-2021.

class AuthUser {
  var tag = 'AuthUser';
  static AuthUser _instance = AuthUser.internal();

  AuthUser.internal();

  factory AuthUser() {
    return _instance;
  }

  static AuthUser getInstance() {
    if (_instance == null) {
      _instance = AuthUser.internal();
    }
    return _instance;
  }

  void loginUser(String response) {}

  Future<void> login(CurrentUser userModel) async {
    userModel.isLoggedIn = true;
    Utility.log("user", userModel.toMap());
    await SharedManager.setStringPreference(SharedPrefsKeys.kUserModel, json.encode(userModel.toMap()));
  }

  Future<void> saveToken(CurrentUser userModel) async {
    Utility.log("user", userModel.toMap());
    await SharedManager.setStringPreference(SharedPrefsKeys.kUserModel, json.encode(userModel.toMap()));
  }

  Future<void> logout() async {
    await SharedManager.setStringPreference(SharedPrefsKeys.kUserModel, "");
    // final GoogleSignIn _googleSignIn = new GoogleSignIn();
    // await _googleSignIn.signOut();
  }

  Future<void> updateUser(CurrentUser currentUser) async {
    await SharedManager.setStringPreference(SharedPrefsKeys.kUserModel, json.encode(currentUser.toMap()));
  }

  Future<CurrentUser> getCurrentUser() async {
    String userModel = await SharedManager.getStringPreference(SharedPrefsKeys.kUserModel);
    Utility.log('AuthUser current user', userModel);
    if (userModel.isNotEmpty) {
      CurrentUser user = CurrentUser.fromMap(jsonDecode(userModel));
      return user;
    }
    return null;
  }

  Future<bool> isLoggedIn() async {
    CurrentUser userModel = await getCurrentUser();
    if (userModel != null) {
      print('insize not null');
      Utility.log('check login', userModel.toMap());
      return userModel.isLoggedIn;
    }
    return false;
  }

  /*Future<bool> updateUserPlan(UserPlan plan) async {
    CurrentUser userModel = await getCurrentUser();
    if (userModel != null) {
      userModel.userPlan = UserPlan();
      SharedManager.setStringPreference(
          SharedPrefsKeys.kUserModel, userModel.toJson());
      return true;
    }
    return false;
  }
*/
  Future<String> token() async {
    CurrentUser userModel = await getCurrentUser();
    var token = userModel?.tokenResponse?.accessToken ?? "";
    Utility.log(tag, "User Token: $token");
    return 'Bearer $token';
  }

  Future<bool> hasToken() async {
    CurrentUser userModel = await getCurrentUser();
    var token = userModel?.tokenResponse?.accessToken ?? "";
    // print('token $token');
    return token.isEmpty;
  }
}
