import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/ui/core/core_presenter.dart';
import 'package:piramal_channel_partner/ui/core/login/model/login_response.dart';
import 'package:piramal_channel_partner/ui/core/login/model/token_response.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/relation_manager_list_response.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/signup_request.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/signup_response.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/terms_and_condition_response.dart';
import 'package:piramal_channel_partner/ui/core/signup/signup_view.dart';
import 'package:piramal_channel_partner/user/AuthUser.dart';
import 'package:piramal_channel_partner/user/CurrentUser.dart';
import 'package:piramal_channel_partner/utils/Dialogs.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/pml_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> implements SignupView {
  final subTextStyle = textStyleSubText14px500w;
  final mainTextStyle = textStyle14px500w;

  SignupRequest signupRequest = SignupRequest();
  CorePresenter corePresenter;

  List<String> rmList = [];
  String relationManagerListResponse;

  bool mobileOTPVerified = false;
  bool emailOTPVerified = false;
  bool checkedValue = false;

  int emailOTP;
  int mobileOTP;

  @override
  void initState() {
    super.initState();
    corePresenter = CorePresenter(this);
    corePresenter.getAccessToken();
  }

  @override
  Widget build(BuildContext context) {
    // 18% from top
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              verticalSpace(30.0),
              Image.asset(Images.kAppIcon, width: 100),
              verticalSpace(20.0),
              Text("Sign Up", style: textStyle24px500w),
              verticalSpace(20.0),
              input("Name as per Rera ID", (String v) {
                signupRequest.name = v;
                return;
              }, important: true, limit: 250),
              verticalSpace(10.0),
              input("Primary Contact Person Name", (String v) {
                signupRequest.primaryContactPerson = v;
                return;
              }, limit: 250),
              verticalSpace(10.0),
              input(
                "Primary Mobile Number",
                (String v) {
                  signupRequest.primaryMobNo = v;
                  return;
                },
                limit: 10,
                showChildButton: true,
                childButtonText: "Get OTP",
                number: true,
                onClick: () {
                  Dialogs.showLoader(context, "Sending OTP to ${signupRequest.primaryMobNo}");
                  corePresenter.sendMobileOTP(signupRequest.primaryMobNo);
                  mobileOTPVerified = false;
                  setState(() {});
                },
              ),
              verticalSpace(10.0),
              input(
                "OTP",
                (String v) {
                  signupRequest.mobileOTP = v;
                  return;
                },
                showChildButton: true,
                childButtonText: mobileOTPVerified ? "Verified" : "Verify",
                number: true,
                limit: 4,
                verified: mobileOTPVerified,
                onClick: () {
                  if (mobileOTPVerified) return;

                  if (signupRequest.mobileOTP == null) {
                    onError("Please Enter OTP");
                    return;
                  }

                  if (signupRequest.mobileOTP != mobileOTP.toString()) {
                    onError("Please Enter correct OTP");
                    return;
                  }

                  mobileOTPVerified = true;
                  setState(() {});
                },
              ),
              verticalSpace(10.0),
              input(
                "Email",
                (String v) {
                  signupRequest.email = v;
                  emailOTPVerified = false;
                  return;
                },
                showChildButton: true,
                childButtonText: "Get OTP",
                limit: 250,
                onClick: () {
                  Dialogs.showLoader(context, "Sending OTP to ${signupRequest.email}");
                  corePresenter.sendOTPX(signupRequest.email);
                },
              ),
              verticalSpace(10.0),
              input(
                "OTP",
                (String v) {
                  signupRequest.emailOTP = v;
                  return;
                },
                showChildButton: true,
                limit: 4,
                childButtonText: emailOTPVerified ? "Verified" : "Verify",
                number: true,
                verified: emailOTPVerified,
                onClick: () {
                  if (emailOTPVerified) return;

                  if (signupRequest.emailOTP == null) {
                    onError("Please Enter OTP");
                    return;
                  }

                  if (signupRequest.emailOTP != emailOTP.toString()) {
                    onError("Please Enter correct OTP");
                    return;
                  }

                  emailOTPVerified = true;
                  setState(() {});

                },
              ),
              // verticalSpace(10.0),
              // input("Relationship Manager", (String v) {
              //   signupRequest.relationshipManager = v;
              //   return;
              // }),
              verticalSpace(10.0),
              Container(
                height: 38.0,
                decoration: BoxDecoration(
                  color: AppColors.inputFieldBackgroundColor,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: Text("Select Relation Manager", style: subTextStyle),
                  value: relationManagerListResponse,
                  underline: Container(),
                  items: <String>[...rmList].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: subTextStyle),
                    );
                  }).toList(),
                  onChanged: (value) {
                    relationManagerListResponse = value;
                    signupRequest.relationshipManager = value;
                    // signupRequest.typeoffirm = value.
                    setState(() {});
                  },
                ),
              ),
              verticalSpace(10.0),
              input("Permanent Account Number (PAN)", (String v) {
                signupRequest.pan = v;
                return;
              }, important: true, limit: 10),
              verticalSpace(10.0),
              input("RERA Registration ID", (String v) {
                signupRequest.reraID = v;
                return;
              },limit: 20),
              verticalSpace(40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: checkedValue,
                    onChanged: (newValue) {
                      setState(() {
                        checkedValue = newValue;
                      });
                    },
                  ),
                  InkWell(
                    onTap: (){
                      corePresenter.getTermsAndCondition(context);
                    },
                    child: Stack(
                      children: [
                        Text("I Agree to the Terms & Conditions", style: textStyle14px500w),
                        Positioned(
                          right: 0,
                          left: 0,
                          bottom: 0,
                          child: Container(
                            height: 1,
                            color: AppColors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              loginButton(context),
              verticalSpace(20.0),
            ],
          ),
        ),
      ),
    );
  }

  Container input(String helperText, Function onX(String value),
      {bool number: false,
      bool important: false,
      bool showChildButton: false,
      String childButtonText: "",
      Function onClick,
      bool verified: false,
      int limit: 1}) {
    return Container(
      height: 38,
      decoration: BoxDecoration(
        color: AppColors.inputFieldBackgroundColor,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          horizontalSpace(10.0),
          Expanded(
            child: TextFormField(
              obscureText: false,
              textAlign: TextAlign.left,
              // controller: widget.textEditingController ?? _controller,
              inputFormatters: [
                number ? FilteringTextInputFormatter.digitsOnly : FilteringTextInputFormatter.singleLineFormatter,
                LengthLimitingTextInputFormatter(limit)
              ],
              maxLines: 1,
              textCapitalization: TextCapitalization.none,
              style: subTextStyle,
              keyboardType: number ? TextInputType.number : TextInputType.text,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "$helperText",
                hintStyle: subTextStyle,
                suffixStyle: TextStyle(color: AppColors.textColor),
              ),
              onChanged: (String val) {
                onX(val);
                /*      widget.onTextChange(val);
                        resetErrorOnTyping();*/
              },
            ),
          ),
          if (important)
            Container(
              height: 5.0,
              width: 5.0,
              decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.colorPrimary),
            ),
          if (showChildButton)
            Row(
              children: [
                Container(
                  height: 5.0,
                  width: 5.0,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.colorPrimary),
                ),
                horizontalSpace(15.0),
                PmlButton(
                  width: 95,
                  height: 36,
                  text: "$childButtonText",
                  color: verified ? AppColors.colorSecondary.withOpacity(0.5) : AppColors.colorSecondary,
                  onTap: onClick,
                ),
              ],
            ),
          if (!showChildButton) horizontalSpace(10.0),
        ],
      ),
    );
  }

  PmlButton loginButton(BuildContext context) {
    return PmlButton(
      width: Utility.screenWidth(context) * 0.58,
      height: 36,
      text: "Next",
      onTap: () {

        if (!checkedValue) {
          onError("Please select terms and condition");
          return;
        }

        if (!mobileOTPVerified) {
          onError("Please verify mobile");
          return;
        }

        if (!emailOTPVerified) {
          onError("Please verify email");
          return;
        }

        // corePresenter.singUp(context, signupRequest);
        Navigator.pushNamed(context, Screens.kUploadDocumentScreen, arguments: signupRequest);
      },
    );
  }

  @override
  onError(String message) {
    Dialogs.hideLoader(context);
    Utility.showErrorToastB(context, message);
  }

  @override
  void onRelationManagerListFetched(List<RelationManagerListResponse> relationManagerListResponse) {
    rmList.clear();
    RelationManagerListResponse s = relationManagerListResponse.first;
    s.values.split(",").forEach((element) {
      rmList.add(element);
    });

    // relationManagerListResponse.forEach((element) {
    //   if (element.returnCode)
    //     rmList.add(element);
    //   else
    //     onError(element.message);
    // });

    setState(() {});
  }

  @override
  void onSignupSuccessfully(SignupResponse signupResponse) async {
    LoginResponse loginResponse = LoginResponse();
    loginResponse.accountId = signupResponse.brokerAccountID;

    Dialogs.hideLoader(context);
    var currentUser = await AuthUser.getInstance().getCurrentUser();
    currentUser.userCredentials = loginResponse;
    AuthUser.getInstance().login(currentUser);

    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pushNamed(context, Screens.kUploadDocumentScreen);
  }

  @override
  void onTokenGenerated(TokenResponse tokenResponse) {
    // _tokenResponse = tokenResponse;

    //Save token
    var currentUser = CurrentUser()..tokenResponse = tokenResponse;
    AuthUser.getInstance().saveToken(currentUser);

    //sent otp request
    corePresenter.getRmList(context);
  }

  @override
  onOtpSent(int otp, provider) {
    Utility.showSuccessToastB(context, "OTP sent successfully");
    Dialogs.hideLoader(context);
    //0 for email and 1 for mobile
    if (provider == 1)
      mobileOTP = otp;
    else
      emailOTP = otp;
  }

  @override
  void onTermsAndConditionFetched(TermsAndConditionResponse termsAndConditionResponse) {
    showDetailDialog(context);
  }

  void showDetailDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      contentPadding: EdgeInsets.all(0.0),
      backgroundColor: Colors.transparent,
      content: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(''' I/flutter (24677): 
I/flutter (24677): 
I/flutter (24677): *****************
I/flutter (24677): ApiController
I/flutter (24677): Api Call :
I/flutter (24677):  https://test.salesforce.com/services/oauth2/token 
I/flutter (24677):  --> Inputs :
I/flutter (24677):  Instance of 'FormData' 
I/flutter (24677):  --> payload :
I/flutter (24677):  null 
I/flutter (24677):  --> header :
I/flutter (24677):  null
I/flutter (24677): *****************
I/flutter (24677): 
I/flutter (24677): 
I/flutter (24677): 
I/flutter (24677): *****************
I/flutter (24677): ApiController
I/flutter (24677): {"access_token":"00Dp00000001TjB!ARYAQO45x7P0fvhZXVwd5ltnqKMKgwx6Qbl6UDFLPvEv2OJI40uPNAAEnaHTfTx8ZAR8z05vsWVQXzoyX.q9vYtdzdgX3uir","instance_url":"https://prl--PRLAPP.my.salesforce.com","id":"https://test.salesforce.com/id/00Dp00000001TjBEAU/005p0000004R4ifAAC","token_type":"Bearer","issued_at":"1645188842233","signature":"N7IKUcGLJKEoGaYe/IHHRnb8VpHH0eoDap1wOFHOtik="}
I/flutter (24677): *****************
I/flutter (24677): 
I/flutter (24677): 
I/flutter (24677): 
I/flutter (24677): *****************
I/flutter (24677): user
I/flutter (24677): {_userCredentials: null, _tokenResponse: {access_token: 00Dp00000001TjB!ARYAQO45x7P0fvhZXVwd5ltnqKMKgwx6Qbl6UDFLPvEv2OJI40uPNAAEnaHTfTx8ZAR8z05vsWVQXzoyX.q9vYtdzdgX3uir, instance_url: https://prl--PRLAPP.my.salesforce.com, id: https://test.salesforce.com/id/00Dp00000001TjBEAU/005p0000004R4ifAAC, token_type: Bearer, issued_at: 1645188842233, signature: N7IKUcGLJKEoGaYe/IHHRnb8VpHH0eoDap1wOFHOtik=}, isLogin: false}
I/flutter (24677): *****************
I/flutter (24677): 
I/flutter (24677): 
I/flutter (24677): 
I/flutter (24677): *****************
I/flutter (24677): AuthUser current user
I/flutter (24677): {"_userCredentials":null,"_tokenResponse":{"access_token":"00Dp00000001TjB!ARYAQO45x7P0fvhZXVwd5ltnqKMKgwx6Qbl6UDFLPvEv2OJI40uPNAAEnaHTfTx8ZAR8z05vsWVQXzoyX.q9vYtdzdgX3uir","instance_url":"https://prl--PRLAPP.my.salesforce.com","id":"https://test.salesforce.com/id/00Dp00000001TjBEAU/005p0000004R4ifAAC","token_type":"Bearer","issued_at":"1645188842233","signature":"N7IKUcGLJKEoGaYe/IHHRnb8VpHH0eoDap1wOFHOtik="},"isLogin":false}
I/flutter (24677): *****************
I/flutter (24677): 
I/flutter (24677): 
I/flutter (24677): 
I/flutter (24677): *****************
I/flutter (24677): CorePresenter
I/flutter (24677): 1463
I/flutter (24677): *****************
I/flutter (24677): 
I/flutter (24677): 
I/flutter (24677): 
I/flutter (24677): *****************
I/flutter (24677): AuthUser current user
I/flutter (24677): {"_userCredentials":null,"_tokenResponse":{"access_token":"00Dp00000001TjB!ARYAQO45x7P0fvhZXVwd5ltnqKMKgwx6Qbl6UDFLPvEv2OJI40uPNAAEnaHTfTx8ZAR8z05vsWVQXzoyX.q9vYtdzdgX3uir","instance_url":"https://prl--PRLAPP.my.salesforce.com","id":"https://test.salesforce.com/id/00Dp00000001TjBEAU/005p0000004R4ifAAC","token_type":"Bearer","issued_at":"1645188842233","signature":"N7IKUcGLJKEoGaYe/IHHRnb8VpHH0eoDap1wOFHOtik="},"isLogin":false}
I/flutter (24677): *****************
I/flutter (24677): 
I/flutter (24677): 
I/flutter (24677): 
I/flutter (24677): *****************
I/flutter (24677): AuthUser
I/flutter (24677): User Token: 00Dp00000001TjB!ARYAQO45x7P0fvhZXVwd5ltnqKMKgwx6Qbl6UDFLPvEv2OJI40uPNAAEnaHTfTx8ZAR8z05vsWVQXzoyX.q9vYtdzdgX3uir
I/flutter (24677): *****************
I/flutter (24677): 
I/flutter (24677): 
I/flutter (24677): 
I/flutter (24677): *****************
I/flutter (24677): ApiController
I/flutter (24677): Api Call :
I/flutter (24677):  https://prl--PRLAPP.my.salesforce.com/services/apexrest/CP_Mobile_App/EmailOTPCP 
I/flutter (24677):  --> Inputs :
I/flutter (24677):  {EmailId: niji@gmail.com, GenOTP: 1463} 
I/flutter (24677):  --> payload :
I/flutter (24677):  null 
I/flutter (24677):  --> header :
I/flutter (24677):  {Authorization: Bearer 00Dp00000001TjB!ARYAQO45x7P0fvhZXVwd5ltnqKMKgwx6Qbl6UDFLPvEv2OJI40uPNAAEnaHTfTx8ZAR8z05vsWVQXzoyX.q9vYtdzdgX3uir}
I/flutter (24677): *****************
I/flutter (24677): 
I/flutter (24677): 
I/flutter (24677): 
I/flutter (24677): *****************
I/flutter (24677): ApiController
I/flutter (24677): {"returnCode":false,"message":"Please Enter Registered Email Id"}
I/flutter (24677): *****************
I/flutter (24677): 
I/flutter (24677): Hide Loader true
I/flutter (24677): Hide Loader false
W/IInputConnectionWrapper(24677): getTextBeforeCursor on inactive InputConnection
W/IInputConnectionWrapper(24677): getSelectedText on inactive InputConnection
W/IInputConnectionWrapper(24677): getTextAfterCursor on inactive InputConnection
W/IInputConnectionWrapper(24677): beginBatchEdit on inactive InputConnection
W/IInputConnectionWrapper(24677): getTextBeforeCursor on inactive InputConnection
W/IInputConnectionWrapper(24677): endBatchEdit on inactive InputConnection
I/flutter (24677): Base consumer rebuilding ... Navigator-[LabeledGlobalKey<NavigatorState>#d10aa]

======== Exception caught by foundation library ====================================================
The following assertion was thrown while dispatching notifications for BaseProvider:
setState() or markNeedsBuild() called during build.

This _InheritedProviderScope<BaseProvider> widget cannot be marked as needing to build because the framework is already in the process of building widgets.  A widget can be marked as needing to be built during the build phase only if one of its ancestors is currently building. This exception is allowed because the framework builds parent widgets before children, which means a dirty descendant will always be built. Otherwise, the framework might not visit this widget during this build phase.
The widget on which setState() or markNeedsBuild() was called was: _InheritedProviderScope<BaseProvider>
  value: Instance of 'BaseProvider'
  listening to value
The widget which was currently being built when the offending call was made was: HomeScreen
  dirty
  dependencies: [_EffectiveTickerMode]
  state: _HomeScreenState#379f7(ticker inactive and muted)
When the exception was thrown, this was the stack: 
#0      Element.markNeedsBuild.<anonymous closure> (package:flutter/src/widgets/framework.dart:4217:11)
#1      Element.markNeedsBuild (package:flutter/src/widgets/framework.dart:4232:6)
#2      _InheritedProviderScopeElement.markNeedsNotifyDependents (package:provider/src/inherited_provider.dart:496:5)
#3      ChangeNotifier.notifyListeners (package:flutter/src/foundation/change_notifier.dart:243:25)
#4      BaseProvider.showToolTip (package:piramal_channel_partner/ui/base/provider/base_provider.dart:52:5)
...
The BaseProvider sending notification was: Instance of 'BaseProvider'
====================================================================================================

======== Exception caught by foundation library ====================================================
The following assertion was thrown while dispatching notifications for BaseProvider:
setState() or markNeedsBuild() called during build.

This _InheritedProviderScope<BaseProvider> widget cannot be marked as needing to build because the framework is already in the process of building widgets.  A widget can be marked as needing to be built during the build phase only if one of its ancestors is currently building. This exception is allowed because the framework builds parent widgets before children, which means a dirty descendant will always be built. Otherwise, the framework might not visit this widget during this build phase.
The widget on which setState() or markNeedsBuild() was called was: _InheritedProviderScope<BaseProvider>
  value: Instance of 'BaseProvider'
  listening to value
The widget which was currently being built when the offending call was made was: LoginScreen
  dirty
  dependencies: [MediaQuery]
  state: _LoginScreenState#11d01
When the exception was thrown, this was the stack: 
#0      Element.markNeedsBuild.<anonymous closure> (package:flutter/src/widgets/framework.dart:4217:11)
#1      Element.markNeedsBuild (package:flutter/src/widgets/framework.dart:4232:6)
#2      _InheritedProviderScopeElement.markNeedsNotifyDependents (package:provider/src/inherited_provider.dart:496:5)
#3      ChangeNotifier.notifyListeners (package:flutter/src/foundation/change_notifier.dart:243:25)
#4      BaseProvider.hideToolTip (package:piramal_channel_partner/ui/base/provider/base_provider.dart:47:5)
...
The BaseProvider sending notification was: Instance of 'BaseProvider'
====================================================================================================
I/flutter (24677): Base consumer rebuilding ... Navigator-[LabeledGlobalKey<NavigatorState>#d10aa]

======== Exception caught by foundation library ====================================================
The following assertion was thrown while dispatching notifications for BaseProvider:
setState() or markNeedsBuild() called during build.

This _InheritedProviderScope<BaseProvider> widget cannot be marked as needing to build because the framework is already in the process of building widgets.  A widget can be marked as needing to be built during the build phase only if one of its ancestors is currently building. This exception is allowed because the framework builds parent widgets before children, which means a dirty descendant will always be built. Otherwise, the framework might not visit this widget during this build phase.
The widget on which setState() or markNeedsBuild() was called was: _InheritedProviderScope<BaseProvider>
  value: Instance of 'BaseProvider'
  listening to value
The widget which was currently being built when the offending call was made was: HomeScreen
  dirty
  dependencies: [_EffectiveTickerMode]
  state: _HomeScreenState#379f7(ticker inactive and muted)
When the exception was thrown, this was the stack: 
#0      Element.markNeedsBuild.<anonymous closure> (package:flutter/src/widgets/framework.dart:4217:11)
#1      Element.markNeedsBuild (package:flutter/src/widgets/framework.dart:4232:6)
#2      _InheritedProviderScopeElement.markNeedsNotifyDependents (package:provider/src/inherited_provider.dart:496:5)
#3      ChangeNotifier.notifyListeners (package:flutter/src/foundation/change_notifier.dart:243:25)
#4      BaseProvider.showToolTip (package:piramal_channel_partner/ui/base/provider/base_provider.dart:52:5)
...
The BaseProvider sending notification was: Instance of 'BaseProvider'
====================================================================================================

======== Exception caught by foundation library ====================================================
The following assertion was thrown while dispatching notifications for BaseProvider:
setState() or markNeedsBuild() called during build.

This _InheritedProviderScope<BaseProvider> widget cannot be marked as needing to build because the framework is already in the process of building widgets.  A widget can be marked as needing to be built during the build phase only if one of its ancestors is currently building. This exception is allowed because the framework builds parent widgets before children, which means a dirty descendant will always be built. Otherwise, the framework might not visit this widget during this build phase.
The widget on which setState() or markNeedsBuild() was called was: _InheritedProviderScope<BaseProvider>
  value: Instance of 'BaseProvider'
  listening to value
The widget which was currently being built when the offending call was made was: LoginScreen
  dirty
  dependencies: [MediaQuery]
  state: _LoginScreenState#11d01
When the exception was thrown, this was the stack: 
#0      Element.markNeedsBuild.<anonymous closure> (package:flutter/src/widgets/framework.dart:4217:11)
#1      Element.markNeedsBuild (package:flutter/src/widgets/framework.dart:4232:6)
#2      _InheritedProviderScopeElement.markNeedsNotifyDependents (package:provider/src/inherited_provider.dart:496:5)
#3      ChangeNotifier.notifyListeners (package:flutter/src/foundation/change_notifier.dart:243:25)
#4      BaseProvider.hideToolTip (package:piramal_channel_partner/ui/base/provider/base_provider.dart:47:5)
...
The BaseProvider sending notification was: Instance of 'BaseProvider'
====================================================================================================
 '''),
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: PmlButton(
              width: 30,
              height: 30,
              color: AppColors.colorPrimary,
              child: Icon(Icons.close, color: AppColors.white, size: 16.0),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
