import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_securityguard/Common/appColors.dart';
import 'package:watcher_app_for_securityguard/Common/fontStyles.dart';
import 'package:watcher_app_for_securityguard/ui/CustomWidgets/CircleDesign.dart';
import 'package:watcher_app_for_securityguard/ui/CustomWidgets/MyButton.dart';
import 'package:watcher_app_for_securityguard/ui/CustomWidgets/MyTextFormField.dart';

import '../HomeScreen.dart';

class PasswordScreen extends StatefulWidget {
  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appPrimaryMaterialColor,
      body: Column(
        children: [
          CircleDesign(title: "Change Password"),
          Expanded(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )),
              child: Padding(
                padding: paddingConstant.authScreenContentPadding,
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    MyTextFormField(
                        lable: "Create Password",
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Please Enter Password";
                          }
                          return "";
                        },
                        hintText: "Enter Password"),
                    MyTextFormField(
                        lable: "Confirm Password",
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Pasword does not match";
                          }
                          return "";
                        },
                        hintText: "Re-enter Password"),
                    SizedBox(
                      height: 30,
                    ),
                    MyButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                              child: HomeScreen(),
                              type: PageTransitionType.rightToLeft),
                        );
                      },
                      title: "Done",
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
