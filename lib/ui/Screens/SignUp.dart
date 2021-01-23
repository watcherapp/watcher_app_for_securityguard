import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_securityguard/Common/appColors.dart';
import 'package:watcher_app_for_securityguard/ui/CustomWidgets/CircleDesign.dart';
import 'package:watcher_app_for_securityguard/Common/fontStyles.dart';
import 'package:watcher_app_for_securityguard/ui/CustomWidgets/MyButton.dart';
import 'package:watcher_app_for_securityguard/ui/CustomWidgets/MyTextFormField.dart';

import 'Login.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appPrimaryMaterialColor,
      body: Column(
        children: [
          CircleDesign(title: "Create account", backicon: true),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text("Enter Your Mobile Number",
                            style: fontConstants.bigTitleBlack),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        "We will send the OTP ( One Time Password )",
                        style: fontConstants.smallText,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Text(
                        "to verify a number",
                        style: fontConstants.smallText,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MyTextFormField(
                        lable: "Mobile No",
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Please Enter Mobile or email";
                          }
                          return "";
                        },
                        hintText: "Enter mobile"),
                    SizedBox(
                      height: 20,
                    ),
                    MyButton(title: "Send OTP", onPressed: () {}),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: Login(),
                                      type: PageTransitionType.bottomToTop));
                            },
                            child: RichText(
                                text: TextSpan(
                                    text: "Already have an account ? ",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: 'WorkSans',
                                        fontSize: 16),
                                    children: [
                                  TextSpan(
                                      text: "Sign in",
                                      style: TextStyle(
                                          color: appPrimaryMaterialColor,
                                          fontFamily: 'WorkSans Bold',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16))
                                ])),
                          ),
                        ],
                      ),
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
