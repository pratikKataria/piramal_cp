import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:provider/provider.dart';

import 'provider/base_provider.dart';

class PersistentAppBar extends StatelessWidget {
  const PersistentAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      title: Text("Piramal Realty", style: textStyleDark18pxW700),
      centerTitle: true,
      leading: Row(
        children: [
          horizontalSpace(20.0),
          Container(child: Image.asset(Images.kIconMenu, width: 16.0)),
        ],
      ),
      actions: [
        Consumer<BaseProvider>(builder: (_, provider, __) {
          return InkWell(
            onTap: () {
              var baseProvider = Provider.of<BaseProvider>(context, listen: false);
              baseProvider.toggleFilter();
              // setState(() {});
            },
            child: Container(
              height: 40.0,
              width: 40.0,
              padding: EdgeInsets.all(11.0),
              child: Image.asset(
                Images.kIconFilter,
                color: provider.filterIsOpen ? AppColors.colorPrimary : AppColors.colorSecondary,
              ),
            ),
          );
        }),
        Container(height: 10, width: 6),
      ],
      elevation: 0.0,
    );
  }
}
