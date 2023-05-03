import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension TextStyleExtension on TextStyle {
  TextStyle withColor(Color color) => this.copyWith(color: color);
}

extension stringExtentions on String {
  String get formatDate {
    if (this == null || this.isEmpty) return "-";

    String dateString = this;
    bool hasHyphen = dateString.contains("-");
    bool hasSlash = dateString.contains("/");

    DateFormat formatter;
    if (hasHyphen) {
      // 2023-04-12
      formatter = DateFormat('yyyy-MM-dd');
    } else if (hasSlash) {
      formatter = DateFormat('dd/MM/yyyy');
    } else {
      return this;
    }

    final DateFormat newFormat = DateFormat('MMM');
    DateTime dateTime = formatter.parse(this);
    String date = newFormat.format(dateTime);
    return date;
  }

  String get formatDate2 {
    if (this == null || this.isEmpty) return "-";

    String dateString = this;
    bool hasHyphen = dateString.contains("-");
    bool hasSlash = dateString.contains("/");

    DateFormat formatter;
    if (hasHyphen) {
      // 2023-04-12
      formatter = DateFormat('yyyy-MM-dd');
    } else if (hasSlash) {
      formatter = DateFormat('dd/MM/yyyy');
    } else {
      return this;
    }

    final DateFormat newFormat = DateFormat('MMMM dd, yyy');
    DateTime dateTime = formatter.parse(this);
    String date = newFormat.format(dateTime);
    return date;
  }


  String get notNull => this.isEmpty || this == "null" ? "-" : this;
}

extension ClickListener on Widget {
  Widget onClick(Function() clickHandler) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: clickHandler,
      child: this,
    );
  }
}

