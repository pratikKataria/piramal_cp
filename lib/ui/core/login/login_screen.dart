import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/res/Strings.dart';
import 'package:piramal_channel_partner/ui/core/core_presenter.dart';
import 'package:piramal_channel_partner/ui/core/login/login_view.dart';
import 'package:piramal_channel_partner/ui/core/login/model/token_response.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/pml_button.dart';

class LoginScreen extends StatelessWidget implements LoginView {
  LoginScreen({Key key}) : super(key: key);
  final subTextStyle = textStyleSubText14px500w;
  final mainTextStyle = textStyle14px500w;
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController otpTextController = TextEditingController();
  BuildContext _context;

  TokenResponse _tokenResponse;

  @override
  Widget build(BuildContext context) {
    // 18% from top
    final perTop18 = Utility.screenHeight(context) * 0.12;
    _context = context;
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
              passwordField(),
              verticalSpace(18.0),
              Text(kForgotPasswordText, style: subTextStyle),
              verticalSpace(110.0),
              loginButton(context),
              verticalSpace(10.0),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Screens.kSignupScreen);
                },
                child: Container(padding: EdgeInsets.all(10.0), child: Text(kCreateAccountText, style: subTextStyle)),
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
            width: 65,
            margin: EdgeInsets.symmetric(horizontal: 12.0),
            child: Text("Email", style: mainTextStyle),
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
                hintText: "Enter email address",
                hintStyle: subTextStyle,
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
            width: 65,
            margin: EdgeInsets.symmetric(horizontal: 12.0),
            child: Text("Password", style: mainTextStyle),
          ),
          Expanded(
            child: TextFormField(
              obscureText: true,
              textAlign: TextAlign.left,
              controller: otpTextController,
              maxLines: 1,
              textCapitalization: TextCapitalization.none,
              style: subTextStyle,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter password",
                hintStyle: subTextStyle,
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

  PmlButton loginButton(BuildContext context) {
    return PmlButton(
      width: Utility.screenWidth(context) * 0.58,
      height: 36,
      text: kLogin,
      onTap: () {
        CorePresenter presenter = CorePresenter(this);
        presenter.getAccessToken();
        // var provider = Provider.of<BaseProvider>(context, listen: false);
        // provider.showToolTip();
        // Navigator.pushNamed(context, Screens.kHomeBase);
      },
    );
  }

  @override
  onTokenGenerated(TokenResponse tokenResponse) {
    _tokenResponse = tokenResponse;
    CorePresenter presenter = CorePresenter(this);
    presenter.sendEmailOtp(emailTextController.text.toString());
  }

  @override
  onOtpSent(int otp) {

  }

  @override
  onError(String message) {
    Utility.showErrorToastB(_context, message);
  }
}
