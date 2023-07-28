import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

class HrmInputFieldDummy extends StatelessWidget {
  final String headingText;
  final String text;
  final bool password;
  final bool mandate;
  final Color color;
  final Widget leftWidget;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final TextEditingController textController;
  final bool inputTypeNumber;
  final List<TextInputFormatter> inputFilters;
  final int inputLength;

  const HrmInputFieldDummy(
      {this.color = AppColors.attachmentBg,
      this.leftWidget,
      this.headingText,
      this.text = "",
      this.mandate = false,
      this.password = false,
      this.inputTypeNumber = false,
      this.padding,
      this.textController,
      this.inputFilters,
      this.margin,
      this.inputLength = 256,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (headingText != null) Text(headingText, style: textStyleSubText14px500w, maxLines: 1),
          if (headingText != null) verticalSpace(5.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.all(Radius.circular(8.0))),
            height: 35.0,
            child: Row(
              children: [
                Expanded(child: Text(text, style: textStyleSubText14px500w)),
                if (leftWidget == null) Container(),
                if (mandate) Container(width: 6.0, height: 6.0, decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.red))
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextFormField inputTextFormField({TextEditingController controller, String placeHolderText}) {
    return TextFormField(
      obscureText: password,
      textAlign: TextAlign.left,
      controller: controller,
      maxLines: 1,
      // inputFormatters: inputFilters    [LengthLimitingTextInputFormatter(inputLength)],
      textCapitalization: TextCapitalization.none,
      keyboardType: inputTypeNumber ? TextInputType.number : TextInputType.emailAddress,
      style: textStyleSubText14px500w,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: placeHolderText,
        hintStyle: textStyleSubText14px500w,
        isDense: true,
        suffixStyle: TextStyle(color: AppColors.textColor),
      ),
    );
  }
}
