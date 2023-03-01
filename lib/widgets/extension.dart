import 'package:flutter/material.dart';

extension mobileNumber on String {
  bool get isValidPhoneNumber => RegExp(r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)').hasMatch(this ?? '');

  bool get isValidEmail => RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(this ?? '');
}

extension stringNotNull on String {
  String get notNull => this == "null" ? "Not Available" : this;

  String get checkNullOrGiveError => this ?? "Something went wrong !!";
}

extension boolNotNull on bool {
  bool get notNullOrFalse => this ?? false;
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



// extension TimeStampToDate on String? {
//   String toTimeSlot() {
//     if (this != null) {
//       try {
//         var dateTime = DateTime.parse("-123450101 $this");
//         return DateFormat("HH : MM a").format(dateTime);
//       } catch (xe) {
//         return "-";
//       }
//     } else {
//       return "-";
//     }
//   }
//
//   String toDisplayDate() {
//     if (this != null) {
//       try {
//         var dateTime = DateTime.parse("$this");
//         return DateFormat("EEE, MMM d").format(dateTime);
//       } catch (xe) {
//         return "-";
//       }
//     } else {
//       return "-";
//     }
//   }
//
//   String toApiDate() {
//     if (this != null) {
//       try {
//         var dateTime = DateTime.parse("$this");//2022-09-16"
//         return DateFormat("yyyy-MM-dd").format(dateTime);
//       } catch (xe) {
//         return "-";
//       }
//     } else {
//       return "-";
//     }
//   }
//
// }

extension trimx on String {
  String get trimExtended => this.length > 15 ? this.substring(15) : this;
}
