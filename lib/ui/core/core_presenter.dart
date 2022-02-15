import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:piramal_channel_partner/api/api_controller_expo.dart';
import 'package:piramal_channel_partner/api/api_end_points.dart';
import 'package:piramal_channel_partner/api/api_error_parser.dart';
import 'package:piramal_channel_partner/ui/core/core_view.dart';
import 'package:piramal_channel_partner/ui/core/login/login_view.dart';
import 'package:piramal_channel_partner/ui/core/login/model/login_response.dart';
import 'package:piramal_channel_partner/ui/core/login/model/otp_response.dart';
import 'package:piramal_channel_partner/ui/core/login/model/token_response.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/document_upload_request.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/document_upload_response.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/relation_manager_list_response.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/signup_request.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/signup_response.dart';
import 'package:piramal_channel_partner/ui/core/signup/signup_view.dart';
import 'package:piramal_channel_partner/ui/core/uploadDocument/upload_document_view.dart';
import 'package:piramal_channel_partner/user/AuthUser.dart';
import 'package:piramal_channel_partner/utils/Dialogs.dart';
import 'package:piramal_channel_partner/utils/NetworkCheck.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

class CorePresenter {
  CoreView _v;
  final tag = "CorePresenter";

  CorePresenter(this._v);

  void getAccessToken() async {
    if (!await NetworkCheck.check()) return;

    var bodyReq = {
      "grant_type": "password",
      "client_id": "3MVG9Se4BnchkASnJ0eDEZX9z9D7w5.Useb0G1N5w8TloI60n3z2sLOgAP.kQJMu4cDVDD6R8ZoiI52dTnngF",
      "client_secret": "ABBF4E5B2A89FD49A3FE015D63A715BDA2D7CA9CE54AD3991560E98276387FB4",
      "username": "aniket.khillari1010@stetig.in",
      "password": "Mobileapp@123u0vS6ZiRg9RNJHRVr9WeO1jpY",
    };

    var body = FormData.fromMap(bodyReq);
    apiController.post(EndPoints.ACCESS_TOKEN, body: body)
      ..then((response) {
        TokenResponse tokenResponse = TokenResponse.fromJson(response.data);
         _v.onTokenGenerated(tokenResponse);
      })
      ..catchError((e) {
        Utility.log(tag, e.toString());
      });
  }

  void sendOTP(String value) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) return;

    //if incoming value is mobile number
    if (value.length == 10 && checkForMobileNumber(value)) {
      sendMobileOTP(value);
      return;
    }

    int mobileOtp = _genRandomNumber();
    var body = {
      "EmailId": "$value",
      "GenOTP": "$mobileOtp",
    };

    apiController.post(EndPoints.SEND_OTP, body: body, headers: await Utility.header())
      ..then((response) {
        OTPResponse otpResponse = OTPResponse.fromJson(response.data);
        if (otpResponse.returnCode == false) {
          _v.onError(otpResponse.message);
          return;
        }

        if (_v is LoginView) {
          LoginView loginView = _v as LoginView;
          loginView.onOtpSent(mobileOtp);
          return;
        }

        SignupView signupView = _v as SignupView;
        signupView.onOtpSent(mobileOtp, 1);
      })
      ..catchError((e) {
        ApiErrorParser.getResult(e, _v);
      });
  }

  bool checkForMobileNumber(String val) {
    try {
      int.parse(val);
      return true;
    } catch (numberFormatException) {
      return false;
    }
  }

  void sendMobileOTP(String value) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) return;

    int mobileOtp = _genRandomNumber();

    String queryParams =
        "username=7506775158&password=Stetig@123&To=$value&senderid=VM-PRLCRM&feedid=372501&Text=Your%20OTP%20for%20MyPiramal%20App%20is%20$mobileOtp%20kindly%20use%20this%20for%20login";
    apiController.get("${EndPoints.SEND_MOBILE_OTP}$queryParams", headers: await Utility.header())
      ..then((response) {
        Utility.log(tag, response.data);

        if (_v is LoginView) {
          LoginView loginView = _v as LoginView;
          loginView.onOtpSent(mobileOtp);
          return;
        }

        SignupView signupView = _v as SignupView;
        signupView.onOtpSent(mobileOtp, 1);
      })
      ..catchError((e) {
        ApiErrorParser.getResult(e, _v);
      });
  }

  void verifyEmail(String value) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) return;

    //if incoming value is mobile number
    if (value.length == 10 && checkForMobileNumber(value)) {
      verifyMobile(value);
      return;
    }

    var body = {
      "EmailId": "$value",
    };

    apiController.post(EndPoints.VERIFY_EMAIL, body: body, headers: await Utility.header())
      ..then((response) {
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);
        LoginView loginView = _v as LoginView;
        if (loginResponse.returnCode)
          loginView.onEmailVerified(loginResponse);
        else
          loginView.onError(loginResponse.message);
      })
      ..catchError((e) {
        _v.onError(e.message);
        Utility.log(tag, e.toString());
      });
  }

  void verifyMobile(String email) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) return;

    var body = {
      "MobileNumber": "$email",
    };

    apiController.post(EndPoints.VERIFY_MOBILE, body: body, headers: await Utility.header())
      ..then((response) {
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);
        LoginView loginView = _v as LoginView;
        if (loginResponse.returnCode)
          loginView.onEmailVerified(loginResponse);
        else
          loginView.onError(loginResponse.message);
      })
      ..catchError((e) {
        _v.onError(e.message);
        Utility.log(tag, e.toString());
      });
  }

  void singUp(BuildContext context, SignupRequest request) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) return;

    Dialogs.showLoader(context, "Please wait creating user ...");
    apiController.post(EndPoints.SIGN_UP, body: request.toJson(), headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        Utility.log(tag, response.data);
        SignupResponse signupResponse = SignupResponse.fromJson(response.data);
        SignupView signUpView = _v as SignupView;
        if (signupResponse.returnCode)
          signUpView.onSignupSuccessfully(signupResponse);
        else
          signUpView.onError(signupResponse.message);
      })
      ..catchError((e) {
        Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void getRmList(BuildContext context) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) return;

    apiController.post(EndPoints.GET_R_MANAGER_LIST, headers: await Utility.header())
      ..then((response) {
        Utility.log(tag, response.data);
        List<RelationManagerListResponse> brList = [];
        var listOfDynamic = response.data as List;
        listOfDynamic.forEach((element) {
          brList.add(RelationManagerListResponse.fromJson(element));
        });
        SignupView signUpView = _v as SignupView;
        signUpView.onRelationManagerListFetched(brList);
      })
      ..catchError((e) {
        ApiErrorParser.getResult(e, _v);
      });
  }

  void uploadDocument(BuildContext context, DocumentUploadRequest request) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) return;

    request.customerAccountId = await Utility.uID();

    Dialogs.showLoader(context, "Please wait uploading document ...");
    apiController.post(EndPoints.CP_EMP_DOC_UPLOAD, body: request.toJson(), headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        Utility.log(tag, response.data);
        DocumentUploadResponse documentUploadResponse = DocumentUploadResponse.fromJson(response.data);
        UploadDocumentView signUpView = _v as UploadDocumentView;
        signUpView.onDocumentUploaded(documentUploadResponse);
      })
      ..catchError((e) {
        Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  int _genRandomNumber() {
    var rng = new Random();
    var code = rng.nextInt(900) + 1000;
    Utility.log(tag, code);
    return code;
  }
}
