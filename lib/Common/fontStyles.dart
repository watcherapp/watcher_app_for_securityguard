import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watcher_app_for_securityguard/Common/appColors.dart';

class fontConstants {
  static const bigTitleWhite = TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontFamily: 'WorkSans Bold');
  static const bigTitleBlack = TextStyle(
      color: Colors.black,
      fontSize: 22,
      fontWeight: FontWeight.bold,
      fontFamily: 'WorkSans Bold');
  static const subTitleText = TextStyle(color: Colors.grey, fontSize: 16);
  static const smallText = TextStyle(
    color: Colors.grey,
    fontSize: 14,
    fontFamily: 'WorkSans Bold',
  );

  // TextFormField label
  static const formFieldLabel = TextStyle(
      color: Colors.black54, fontSize: 14, fontWeight: FontWeight.w600);
}

class paddingConstant {
  static const authScreenContentPadding =
      EdgeInsets.only(top: 20, left: 20.0, right: 20.0);
}
