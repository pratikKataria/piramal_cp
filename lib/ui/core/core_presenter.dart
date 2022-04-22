import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/api/api_controller_expo.dart';
import 'package:piramal_channel_partner/api/api_end_points.dart';
import 'package:piramal_channel_partner/api/api_error_parser.dart';
import 'package:piramal_channel_partner/ui/base/base_presenter.dart';
import 'package:piramal_channel_partner/ui/core/core_view.dart';
import 'package:piramal_channel_partner/ui/core/login/login_view.dart';
import 'package:piramal_channel_partner/ui/core/login/model/login_response.dart';
import 'package:piramal_channel_partner/ui/core/login/model/otp_response.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/document_upload_request.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/document_upload_response.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/relation_manager_list_response.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/signup_request.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/signup_response.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/terms_and_condition_response.dart';
import 'package:piramal_channel_partner/ui/core/signup/signup_view.dart';
import 'package:piramal_channel_partner/ui/core/uploadDocument/upload_document_view.dart';
import 'package:piramal_channel_partner/user/AuthUser.dart';
import 'package:piramal_channel_partner/utils/Dialogs.dart';
import 'package:piramal_channel_partner/utils/NetworkCheck.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

class CorePresenter extends BasePresenter {
  CoreView _v;
  final tag = "CorePresenter";

  CorePresenter(this._v) : super(_v);

  void sendEmailMobileOTP(String value) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) return;

    //if incoming value is mobile number
    if (checkForMobileNumber(value)) {
      if (value.length == 10)
        sendMobileOTP(value);
      else
        _v.onError("please enter valid mobile number");
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

  void sendOTPX(String value) async {
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

    apiController.post(EndPoints.SEND_OTP_V1, body: body, headers: await Utility.header())
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
        signupView.onOtpSent(mobileOtp, 0);
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

  void verifyMobileEmail(String value) async {
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
          loginView.onVerificationSuccess(loginResponse);
        else if (loginResponse?.accountId == null)
          loginView.onVerificationFailed();
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
          loginView.onVerificationSuccess(loginResponse);
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
        UploadDocumentView signUpView = _v as UploadDocumentView;
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

  void getTypeOfFirm(BuildContext context) async {
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
        List<String> brList = [];

        var listOfDynamic = response.data as List;
        listOfDynamic.forEach((element) {
          RelationManagerListResponse rm = RelationManagerListResponse.fromJson(element);
          if (rm != null && rm.fieldName == "Type_of_firm__c") {
            brList.addAll(rm.values?.split(",")?.toList() ?? []);
          }
        });

        if (brList.isNotEmpty) brList.removeLast();

        UploadDocumentView signUpView = _v as UploadDocumentView;
        signUpView.onTypeOfFirmFetched(brList);
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

  void getTermsAndCondition(BuildContext context) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) return;

    Dialogs.showLoader(context, "Getting terms and condition please wait ...");
    apiController.post(EndPoints.TERMS_AND_CONDITION, headers: await Utility.header())
      ..then((response) {
        Utility.log(tag, response.data);
        Dialogs.hideLoader(context);
        TermsAndConditionResponse termsAndConditionResponse = TermsAndConditionResponse.fromJson(response.data);
        UploadDocumentView view = _v as UploadDocumentView;
        if (termsAndConditionResponse.returnCode) {
          view.onTermsAndConditionFetched(termsAndConditionResponse);
        } else {
          _v.onError(termsAndConditionResponse.message);
        }
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
