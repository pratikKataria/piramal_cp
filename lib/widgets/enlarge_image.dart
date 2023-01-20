import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

class EnlargeImage extends StatelessWidget {
  final String imagecode;

  const EnlargeImage(this.imagecode, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: "img",
        child: Image.memory(Utility.convertMemoryImage(imagecode)),
      ),
    );
  }
}
