import 'package:flutter/material.dart';

class RefreshListView extends StatelessWidget {
  List<Widget> children;
  EdgeInsets margin;
  Function onRefresh;

  // var refreshKey = GlobalKey<RefreshIndicatorState>();

  RefreshListView({Key key, List<Widget> children, Function onRefresh, EdgeInsets margin}) : super(key: key) {
    this.children = children;
    this.margin = margin;
    this.onRefresh = onRefresh;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      // key: refreshKey,
      onRefresh: refreshList,
      child: Container(
        margin: margin,
        child: ListView.builder(
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
