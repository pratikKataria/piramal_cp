import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/api/api_controller_expo.dart';
import 'package:piramal_channel_partner/api/api_end_points.dart';
import 'package:piramal_channel_partner/api/api_error_parser.dart';
import 'package:piramal_channel_partner/env/environment_values.dart';
import 'package:piramal_channel_partner/global/variables.dart';
import 'package:piramal_channel_partner/ui/base/base_presenter.dart';
import 'package:piramal_channel_partner/ui/core/core_view.dart';
import 'package:piramal_channel_partner/ui/core/login/login_view.dart';
import 'package:piramal_channel_partner/ui/core/login/model/login_response.dart';
import 'package:piramal_channel_partner/ui/core/login/model/otp_response.dart';
import 'package:piramal_channel_partner/ui/core/login/model/token_response.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/document_upload_request.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/document_upload_response.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/relation_manager_list_response.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/signup_guest_request.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/signup_request.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/signup_response.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/signup_validation_check_response.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/terms_and_condition_response.dart';
import 'package:piramal_channel_partner/ui/core/signup/signup_view.dart';
import 'package:piramal_channel_partner/ui/core/uploadDocument/model/post_user_document_response.dart';
import 'package:piramal_channel_partner/ui/core/uploadDocument/model/type_of_document_response.dart';
import 'package:piramal_channel_partner/ui/core/uploadDocument/upload_document_view.dart';
import 'package:piramal_channel_partner/user/AuthUser.dart';
import 'package:piramal_channel_partner/utils/Dialogs.dart';
import 'package:piramal_channel_partner/utils/NetworkCheck.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

class CorePresenter extends BasePresenter {
  CoreView _v;
  final tag = "CorePresenter";

  CorePresenter(this._v) : super(_v);

  void sendEmailMobileOTP(BuildContext context, String value) async {
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
        sendMobileOTP(context, value);
      else
        _v.onError("please enter valid mobile number");
      return;
    }

    int mobileOtp = _genRandomNumber();
    var body = {
      "EmailId": "$value",
      "GenOTP": "$mobileOtp",
    };

    Dialogs.showLoader(context, "Sending OTP ...");
    apiController.post(EndPoints.SEND_OTP, body: body, headers: await Utility.header())
      ..then((response) async {
        await Dialogs.hideLoader(context);
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
      ..catchError((e) async {
        await Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void sendOTPX(BuildContext context, String value) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) return;

    //if incoming value is mobile number
    if (value.length == 10 && checkForMobileNumber(value)) {
      sendMobileOTP(context, value);
      return;
    }

    int mobileOtp = _genRandomNumber();
    var body = {
      "EmailId": "$value",
      "GenOTP": "$mobileOtp",
    };

    Dialogs.showLoader(context, "Sending OTP to $value");
    apiController.post(EndPoints.SEND_OTP_V2, body: body, headers: await Utility.header())
      ..then((response) async {
        await Dialogs.hideLoader(context);
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
      ..catchError((e) async {
        await Dialogs.hideLoader(context);
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

  void sendMobileOTP(BuildContext context, String value) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    if (value == null || value.isEmpty) {
      _v.onError("Please enter mobile number");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) return;

    int mobileOtp = _genRandomNumber();

    String queryParams =
        "username=7506775158&password=Stetig@123&To=$value&senderid=PRLSLS&feedid=372501&Text=<%23> Your OTP for PRL CP App is $mobileOtp. Kindly use this for login. $appSignature";
    Dialogs.showLoader(context, "Sending OTP to $value");
    apiController.get("${EndPoints.SEND_MOBILE_OTP}$queryParams", headers: await Utility.header())
      ..then((response) async {
        await Dialogs.hideLoader(context);
        Utility.log(tag, response.data);

        if (_v is LoginView) {
          LoginView loginView = _v as LoginView;
          loginView.onOtpSent(mobileOtp);
          return;
        }

        SignupView signupView = _v as SignupView;
        signupView.onOtpSent(mobileOtp, 1);
      })
      ..catchError((e) async {
        await Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void verifyMobileEmail(BuildContext context, String value) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) return;

    //if incoming value is mobile number
    if (value.length == 10 && checkForMobileNumber(value)) {
      verifyMobile(context, value);
      return;
    }

    var body = {
      "EmailId": "$value",
    };

    Dialogs.showLoader(context, "Verifying ...");
    apiController.post(EndPoints.VERIFY_EMAIL, body: body, headers: await Utility.header())
      ..then((response) async {
        await Dialogs.hideLoader(context);
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);
        LoginView loginView = _v as LoginView;
        if (loginResponse.returnCode)
          loginView.onVerificationSuccess(loginResponse);
        else if (loginResponse?.accountId == null)
          loginView.onVerificationFailed();
        else
          loginView.onError(loginResponse.message);
      })
      ..catchError((e) async {
        await Dialogs.hideLoader(context);
        _v.onError(e.message);
        Utility.log(tag, e.toString());
      });
  }

  void verifyMobile(BuildContext context, String email) async {
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

    Dialogs.showLoader(context, "Verifying ...");
    apiController.post(EndPoints.VERIFY_MOBILE, body: body, headers: await Utility.header())
      ..then((response) async {
        await Dialogs.hideLoader(context);
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);
        LoginView loginView = _v as LoginView;
        if (loginResponse.returnCode)
          loginView.onVerificationSuccess(loginResponse);
        else
          loginView.onError(loginResponse.message);
      })
      ..catchError((e) async {
        await Dialogs.hideLoader(context);
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
      ..then((response) async {
        await Dialogs.hideLoader(context);
        Utility.log(tag, response.data);
        SignupResponse signupResponse = SignupResponse.fromJson(response.data);
        UploadDocumentView signUpView = _v as UploadDocumentView;
        if (signupResponse.returnCode)
          signUpView.onSignupSuccessfully(signupResponse);
        else
          signUpView.onError(signupResponse.message);
      })
      ..catchError((e) async {
        await Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }


  void singUpGuest(BuildContext context, SignupGuestRequest request) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) return;


    request.tnCFlag = true;
    request.typeoffirm = "Individual";

    Dialogs.showLoader(context, "Please wait creating user ...");
    apiController.post(EndPoints.SIGN_UP_GUEST, body: request.toJson(), headers: await Utility.header())
      ..then((response) async {
        await Dialogs.hideLoader(context);
        Utility.log(tag, response.data);
        SignupResponse signupResponse = SignupResponse.fromJson(response.data);
        SignupView signUpView = _v as SignupView;
        if (signupResponse.returnCode)
          signUpView.onSignupGuestSuccessfully(signupResponse);
        else
          signUpView.onError(signupResponse.message);
      })
      ..catchError((e) async {
        await Dialogs.hideLoader(context);
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
      ..then((response) async {
        Utility.log(tag, response.data);
        List<RelationManagerListResponse> brList = [];
        var listOfDynamic = response.data as List;
        listOfDynamic.forEach((element) {
          brList.add(RelationManagerListResponse.fromJson(element));
        });
        SignupView signUpView = _v as SignupView;
        signUpView.onRelationManagerListFetched(brList);
      })
      ..catchError((e) async {
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
      ..then((response) async {
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
      ..catchError((e) async {
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
      ..then((response) async {
        await Dialogs.hideLoader(context);
        Utility.log(tag, response.data);
        DocumentUploadResponse documentUploadResponse = DocumentUploadResponse.fromJson(response.data);
        UploadDocumentView signUpView = _v as UploadDocumentView;
        signUpView.onDocumentUploaded(documentUploadResponse);
      })
      ..catchError((e) async {
        await Dialogs.hideLoader(context);
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
      ..then((response) async {
        Utility.log(tag, response.data);
        await Dialogs.hideLoader(context);
        TermsAndConditionResponse termsAndConditionResponse = TermsAndConditionResponse.fromJson(response.data);
        UploadDocumentView view = _v as UploadDocumentView;
        if (termsAndConditionResponse.returnCode) {
          view.onTermsAndConditionFetched(termsAndConditionResponse);
        } else {
          _v.onError(termsAndConditionResponse.message);
        }
      })
      ..catchError((e) async {
        await Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void postCheckUserExist(BuildContext context, SignupRequest signupRequest) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) return;

    Map body = {
      "Mobile": signupRequest.primaryMobNo,
      "Email": signupRequest.email,
      "PAN": signupRequest.pan,
      "RERA": signupRequest.reraID,
    };

    Dialogs.showLoader(context, "Checking user please wait ...");
    apiController.post(EndPoints.SIGNUP_VALIDATION_CHECK, body: body, headers: await Utility.header())
      ..then((response) async {
        Utility.log(tag, response.data);
        await Dialogs.hideLoader(context);
        SignupValidationCheckResponse termsAndConditionResponse = SignupValidationCheckResponse.fromJson(response.data);
        SignupView view = _v as SignupView;
        // if (termsAndConditionResponse.returnCode) {
        view.newUserChecked(termsAndConditionResponse);
        // } else {
        //   _v.onError(termsAndConditionResponse.message);
        // }
      })
      ..catchError((e) async {
        await Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void postUserDocuments(BuildContext context, String typeOfFirm, String mobileAppBroker, Map<String, String> documents) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) return;
    List<Map<String, String>> bodyList = [];
    documents.forEach((key, value) {
      bodyList.add(
        {
          "MobileAppBrokerId": mobileAppBroker,
          "TypeOfFirm": typeOfFirm,
          "DocType": key,
          "DocFile": value,
        },
      );
      return;
    });

    Dialogs.showLoader(context, "Please wait uploading user document");
    List<PostUserDocumentResponse> postUserDocumentResponseList = [];
    await Future.wait(bodyList.map(
      (e) async => apiController.post(EndPoints.POST_DOCUMENTS_SIGNUP, body: e, headers: await Utility.header())
        ..then((response) async {
          Utility.log(tag, response.data);
          PostUserDocumentResponse postUserDocumentResponse = PostUserDocumentResponse.fromJson(response.data);
          postUserDocumentResponseList.add(postUserDocumentResponse);
        })
        ..catchError((e) async {
          ApiErrorParser.getResult(e, _v);
        }),
    ));
    await Dialogs.hideLoader(context);

    bool allOk = true;
    postUserDocumentResponseList.forEach((element) {
      if (element.returnCode == false) allOk = false;
    });

    if (allOk)
      (_v as UploadDocumentView).allDocumentUploadedSuccessfully();
    else
      (_v as UploadDocumentView).allDocumentUploadedWithError();
  }

  void getDocumentListByTypeOfFirm(BuildContext context, List<String> typeOfFirmList) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) return;

    Map<String, TypeOfDocumentResponse> responseMap = {};

    Dialogs.showLoader(context, "Please wait fetching document list");
    await Future.wait<Response>(
      typeOfFirmList
          .map((e) async => apiController.post(EndPoints.TYPE_OF_FIRM, body: {"Typeoffirm": e}, headers: await Utility.header())
            ..then((response) async {
              Utility.log(tag, response.data);
              responseMap[e] = TypeOfDocumentResponse.fromJson(response.data);
            })
            ..catchError((e) async {
              ApiErrorParser.getResult(e, _v);
            }))
          .toList(),
    );
    await Dialogs.hideLoader(context);

    if (_v is UploadDocumentView) (_v as UploadDocumentView).onFirmsDocumentFetched(responseMap);
  }

  void getDocumentListByTypeOfFirmSingle(BuildContext context, String value) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) return;

    Map<String, TypeOfDocumentResponse> responseMap = {};

    Dialogs.showLoader(context, "Please wait fetching document list");
    apiController.post(EndPoints.TYPE_OF_FIRM, body: {"Typeoffirm": value}, headers: await Utility.header())
      ..then((response) async {
        await Dialogs.hideLoader(context);
        Utility.log(tag, response.data);
        TypeOfDocumentResponse typeOfDocumentResponse = TypeOfDocumentResponse.fromJson(response.data);
        (_v as UploadDocumentView).onTypeOfFirmFetchedV2(typeOfDocumentResponse);
      })
      ..catchError((e) async {
        await Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });

    if (_v is UploadDocumentView) (_v as UploadDocumentView).onFirmsDocumentFetched(responseMap);
  }

  void postUserDocumentsV2(BuildContext context, String docType, String file) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) return;
    String uID = await Utility.uID();

    Map body = {
      "CustomerAccountId": uID,
      "DocType": docType,
      "DocFile": file,
    };

    Dialogs.showLoader(context, "Please wait uploading user document");
    List<PostUserDocumentResponse> postUserDocumentResponseList = [];
    apiController.post(EndPoints.POST_PENDING_DOCUMENTS, body: body, headers: await Utility.header())
      ..then((response) async {
        await Dialogs.hideLoader(context);
        Utility.log(tag, response.data);
        PostUserDocumentResponse postUserDocumentResponse = PostUserDocumentResponse.fromJson(response.data);
        postUserDocumentResponseList.add(postUserDocumentResponse);
        if (postUserDocumentResponse.returnCode) {
          (_v as UploadDocumentView).allDocumentUploadedSuccessfullyV2(docType);
        } else {
          _v.onError(postUserDocumentResponse.message);
        }
      })
      ..catchError((e) async {
        await Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void getAccessToken2() async {
    if (!await NetworkCheck.check()) {
      _v.onError("No Network Found");
      return;
    }

    var bodyReq = EnvironmentValues.getTokenBody();

    var body = FormData.fromMap(bodyReq);
    apiController.post(EndPoints.ACCESS_TOKEN, body: body)
      ..then((response) async {
        TokenResponse tokenResponse = TokenResponse.fromJson(response.data);
        if (_v is LoginView) (_v as LoginView).onTokenGenerated2(tokenResponse);
      })
      ..catchError((e) async {});
  }

  int _genRandomNumber() {
    var rng = new Random();
    var code = rng.nextInt(900) + 1000;
    Utility.log(tag, code);
    return code;
  }
}
