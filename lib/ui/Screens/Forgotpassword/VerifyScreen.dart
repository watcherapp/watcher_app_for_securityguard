import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:watcher_app_for_securityguard/Common/appColors.dart';
import 'package:watcher_app_for_securityguard/Common/fontStyles.dart';
import 'package:watcher_app_for_securityguard/ui/CustomWidgets/CircleDesign.dart';
import 'package:watcher_app_for_securityguard/ui/CustomWidgets/MyButton.dart';
import 'package:watcher_app_for_securityguard/ui/CustomWidgets/MyTextFormField.dart';

class VerifyScreen extends StatefulWidget {
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: appPrimaryMaterialColor,
      body: Column(
        children: [
          CircleDesign(title: "Verify Mobile"),
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
                        child: Text("Enter Verification Code",
                            style: fontConstants.bigTitleBlack),
                      ),
                    ),
                    /* Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        "We have sent a verification code on",
                        style: fontConstants.smallText,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        "+ 9429828152",
                        style: fontConstants.smallText,
                        textAlign: TextAlign.center,
                      ),
                    ),*/
                    SizedBox(
                      height: 30,
                    ),
                    MyTextFormField(
                      lable: "Mobile No or email",
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Please Enter Mobile or email";
                        }
                        return "";
                      },
                      hintText: "Enter mobile or email",
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    PinCodeTextField(
                      //controller: txtOTP,
                      autofocus: false,
                      wrapAlignment: WrapAlignment.center,
                      highlight: true,
                      pinBoxHeight: 42,
                      pinBoxWidth: 42,
                      pinBoxRadius: 8,
                      //pinBoxColor: Colors.grey[200],
                      highlightColor: appPrimaryMaterialColor,
                      defaultBorderColor: appPrimaryMaterialColor[700],
                      hasTextBorderColor: Colors.black,
                      maxLength: 6,
                      pinBoxDecoration:
                          ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                      pinTextStyle: TextStyle(fontSize: 17),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    MyButton(
                        title: "Verify",
                        onPressed: () {
                          /* Navigator.push(
                              context,
                              PageTransition(
                                  child: SignUp3(),
                                  type: PageTransitionType.rightToLeft));*/
                        }),
                    SizedBox(
                      height: 35,
                    ),
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
