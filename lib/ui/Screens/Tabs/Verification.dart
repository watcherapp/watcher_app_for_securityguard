import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:watcher_app_for_securityguard/Common/appColors.dart';

class Verification extends StatefulWidget {
  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  var _onKeyboardTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 55,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: appPrimaryMaterialColor,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      border: Border.all(width: 0.5, color: Colors.black),
                    ),
                    child: Icon(
                      Icons.person_add_alt_1_outlined,
                      size: 30,
                      color: Colors.white,
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 11.0),
                  child: Text(
                    "Add Visitor",
                    style: TextStyle(
                        color: appPrimaryMaterialColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                )
              ],
            ),
            Column(
              children: [
                Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: appPrimaryMaterialColor,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      border: Border.all(width: 0.5, color: Colors.black),
                    ),
                    child: Icon(
                      Icons.qr_code,
                      size: 30,
                      color: Colors.white,
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 11.0),
                  child: Text(
                    "Scan QR",
                    style: TextStyle(
                        color: appPrimaryMaterialColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: 60,
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
          pinBoxDecoration: ProvidedPinBoxDecoration.defaultPinBoxDecoration,
          pinTextStyle: TextStyle(fontSize: 17),
        ),
        /*  NumericKeyboard(
            onKeyboardTap: _onKeyboardTap,
            textColor: Colors.red,
            rightButtonFn: () {
              setState(() {});
            },
            rightIcon: Icon(
              Icons.backspace,
              color: Colors.red,
            ),
            leftButtonFn: () {
              print('left button clicked');
            },
            leftIcon: Icon(
              Icons.check,
              color: Colors.red,
            ),
            mainAxisAlignment: MainAxisAlignment.spaceEvenly)*/
      ],
    );
  }
}
