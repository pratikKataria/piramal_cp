import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

class ProjectDetailOverviewPage extends StatelessWidget {
  const ProjectDetailOverviewPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Text(
            "Demonstrating lavishness and sophistication in every facet, Piramal Mahalaxmi is a landmark development of greatest glory. It encompasses the spirit of Mahalaxmi while mirroring South Mumbai’s essence with its three phenomenal towers.",
            style: textStyle14px500w20H,
          ),
          verticalSpace(10.0),
          line(),
          verticalSpace(10.0),
          Row(
            children: [
              Text("Website: ", style: textStyleSubText14px500w),
              Text("piramalmahalaxmi.com ↗ ", style: textStylePrimary14px500w),
            ],
          ),
          verticalSpace(10.0),

          Row(
            children: [
              Text("3D Tour:  ", style: textStyleSubText14px500w),
              Text("piramalmahalaxmi.com/e-tour ↗", style: textStylePrimary14px500w),
            ],
          ),
          
          Image.asset(Images.kImgPlaceholderMap, height: 178),
        ],
      ),
    );
  }
}
