import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/res/Strings.dart';
import 'package:piramal_channel_partner/ui/base/provider/base_provider.dart';
import 'package:piramal_channel_partner/ui/core/core_presenter.dart';
import 'package:piramal_channel_partner/ui/core/login/login_view.dart';
import 'package:piramal_channel_partner/ui/core/login/model/login_response.dart';
import 'package:piramal_channel_partner/ui/core/login/model/token_response.dart';
import 'package:piramal_channel_partner/user/AuthUser.dart';
import 'package:piramal_channel_partner/user/CurrentUser.dart';
import 'package:piramal_channel_partner/utils/Dialogs.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/pml_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginView {
  final subTextStyle = textStyleSubText14px500w;

  final mainTextStyle = textStyle14px500w;

  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController otpTextController = TextEditingController();

  BuildContext _context;

  int otp;

  TokenResponse _tokenResponse;

  @override
  Widget build(BuildContext context) {
    // 18% from top
    _context = context;
    final perTop18 = Utility.screenHeight(context) * 0.12;
    var provider = Provider.of<BaseProvider>(context, listen: false);
    if (provider.showAppbarAndBottomNavigation) provider.hideToolTip();
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              verticalSpace(perTop18),
              Image.asset(Images.kAppIcon, width: 170),
              verticalSpace(perTop18),
              emailField(),
              verticalSpace(10.0),
              if (otp != null) passwordField(),
              verticalSpace(18.0),
              // Text(kForgotPasswordText, style: subTextStyle),
              verticalSpace(30.0),
              loginButton(otp != null ? "Log In" : "Send OTP"),
              verticalSpace(10.0),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Screens.kSignupScreen);
                },
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text(kCreateAccountText, style: subTextStyle),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container emailField() {
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
          Container(
            width: 75,
            margin: EdgeInsets.symmetric(horizontal: 12.0),
            child: Text("Email/Phone", style: mainTextStyle),
          ),
          Expanded(
            child: TextFormField(
              obscureText: false,
              textAlign: TextAlign.left,
              controller: emailTextController,
              maxLines: 1,
              textCapitalization: TextCapitalization.none,
              style: subTextStyle,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter email or phone",
                hintStyle: subTextStyle,
                isDense: true,
                suffixStyle: TextStyle(color: AppColors.textColor),
              ),
              onChanged: (String val) {
                resetOTP();
                /*      widget.onTextChange(val);
                        resetErrorOnTyping();*/
              },
            ),
          ),
        ],
      ),
    );
  }

  Container passwordField() {
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
          Container(
            width: 75,
            margin: EdgeInsets.symmetric(horizontal: 12.0),
            child: Text("OTP", style: mainTextStyle),
          ),
          Expanded(
            child: TextFormField(
              // obscureText: true,
              textAlign: TextAlign.left,
              controller: otpTextController,
              maxLines: 1,
              inputFormatters: [LengthLimitingTextInputFormatter(4)],
              textCapitalization: TextCapitalization.none,
              style: subTextStyle,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter OTP",
                hintStyle: subTextStyle,
                isDense: true,
                suffixStyle: TextStyle(color: AppColors.textColor),
              ),
              onChanged: (String val) {
                /*      widget.onTextChange(val);
                        resetErrorOnTyping();*/
              },
            ),
          ),
        ],
      ),
    );
  }

  PmlButton loginButton(String text) {
    return PmlButton(
      width: Utility.screenWidth(_context) * 0.58,
      height: 36,
      text: "$text",
      onTap: () {
        if (otp == null)
          sendOTP();
        else
          verifyOTP();

        // Navigator.pushNamed(context, Screens.kHomeBase);
      },
    );
  }

  void sendOTP() {
    Dialogs.showLoader(context, "Sending OTP ...");
    CorePresenter presenter = CorePresenter(this);
    presenter.getAccessToken();
  }

  void verifyOTP() {
    if (otpTextController.text.toString() != otp.toString()) {
      onError("Please enter correct OTP");
      return;
    }

    Dialogs.showLoader(context, "Verifying ...");
    CorePresenter presenter = CorePresenter(this);
    presenter.verifyEmail(emailTextController.text.toString());
  }

  @override
  onTokenGenerated(TokenResponse tokenResponse) {
    _tokenResponse = tokenResponse;

    //Save token
    var currentUser = CurrentUser()..tokenResponse = tokenResponse;
    AuthUser.getInstance().saveToken(currentUser);

    //sent otp request
    CorePresenter presenter = CorePresenter(this);
    presenter.sendOTP(emailTextController.text.toString());
  }

  @override
  onOtpSent(int otp) {
    Dialogs.hideLoader(context);
    Utility.showSuccessToastB(_context, "OTP Sent Successfully");
    this.otp = otp;
    setState(() {});
  }

  @override
  onError(String message) {
    Utility.showErrorToastB(_context, message);
    Dialogs.hideLoader(context);
  }

  resetOTP() {
    otp = null;
    setState(() {});
  }

  @override
  onEmailVerified(LoginResponse loginResponse) async {
    //Save userId
    Dialogs.hideLoader(context);
    var currentUser = await AuthUser.getInstance().getCurrentUser();
    currentUser.userCredentials = loginResponse;
    AuthUser.getInstance().login(currentUser);

    Navigator.pop(context);
    Navigator.pushNamed(context, Screens.kHomeBase);

    var provider = Provider.of<BaseProvider>(context, listen: false);
    provider.showToolTip();
  }
}
