import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

class RefreshListView extends StatelessWidget {
  List<Widget> children;
  EdgeInsets margin;
  Function onRefresh;

  // var refreshKey = GlobalKey<RefreshIndicatorState>();

  RefreshListView({Key key, List<Widget> children, @required Function onRefresh, EdgeInsets margin}) : super(key: key) {
    this.children = children;
    this.margin = margin;
    this.onRefresh = onRefresh;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refreshList,
      child: Container(
        margin: margin,
        child: children.isEmpty
            ? ListView(
              children: [
                verticalSpace(150.0),
                Center(child: Text("No Data Found", style: textStyleRegular16px500w)),
              ],
            )
            : ListView.builder(
                itemCount: children.length,
                itemBuilder: (context, i) {
                  return children[i];
                },
              ),
      ),
    );
  }

  Future<Null> refreshList() async {
    // refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    this.onRefresh();
    return null;
  }
}
