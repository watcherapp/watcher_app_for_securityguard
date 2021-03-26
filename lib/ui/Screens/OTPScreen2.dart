import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:watcher_app_for_securityguard/Common/appColors.dart';
import 'package:watcher_app_for_securityguard/Common/fontStyles.dart';
import 'package:watcher_app_for_securityguard/ui/CustomWidgets/CircleDesign.dart';
import 'package:watcher_app_for_securityguard/ui/CustomWidgets/MyButton.dart';
import 'package:watcher_app_for_securityguard/ui/Screens/Forgotpassword/PasswordScreen.dart';
import 'package:watcher_app_for_securityguard/ui/Screens/Registration/SignUp3.dart';

class OTPScreen extends StatefulWidget {
  var otpData;
  OTPScreen({this.otpData});
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  bool isLoading = false;
  bool isFCMtokenLoading = false;
  String rndnumber;
  TextEditingController txtOTP = new TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String _verificationId;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String fcmToken = "";

  @override
  void initState() {
    _onVerifyCode();
    _firebaseMessaging.getToken().then((token) {
      setState(() {
        fcmToken = token;
      });
      print('----------->' + '${token}');
    });
  }

  void _onVerifyCode() async {
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      _firebaseAuth
          .signInWithCredential(phoneAuthCredential)
          .then((UserCredential value) {
        if (value.user != null) {
          print(value.user);

          print("OTP SEND SUCCESSFULLY");
          //_updateFCMtoken();
        } else {
          Fluttertoast.showToast(msg: "Error validating OTP, try again");
        }
      }).catchError((error) {
        Fluttertoast.showToast(msg: " $error");
      });
    };
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      Fluttertoast.showToast(msg: authException.message);
    };
    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };

    // TODO: Change country code

    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: widget.otpData,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void _onFormSubmitted() async {
    setState(() {
      isLoading = true;
    });
    AuthCredential _authCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: txtOTP.text);
    _firebaseAuth
        .signInWithCredential(_authCredential)
        .then((UserCredential value) {
      setState(() {
        isLoading = false;
      });
      if (value.user != null) {
        //_updateFCMtoken();
        print("OTP VERIFIED SUCCESSFULLY");
        Navigator.push(
            context,
            PageTransition(
                child: SignUp3(
                  mobile: widget.otpData,
                ),
                type: PageTransitionType.rightToLeft));
        print(value.user);
      } else {
        Fluttertoast.showToast(msg: "Invalid OTP");
      }
    }).catchError((error) {
      Fluttertoast.showToast(msg: "$error Something went wrong");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appPrimaryMaterialColor,
      body: Column(
        children: [
          CircleDesign(title: "OTP Verification", backicon: true),
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
                    Padding(
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
                        //"+ 9429828152",
                        widget.otpData,
                        style: fontConstants.smallText,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    PinCodeTextField(
                      controller: txtOTP,
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
                          _onFormSubmitted();
                          if (widget.otpData == true) {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: PasswordScreen(),
                                    type: PageTransitionType.rightToLeft));
                          } else {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: SignUp3(),
                                    type: PageTransitionType.rightToLeft));
                          }
                          /*    widget.otpData
                              ? Navigator.push(
                                  context,
                                  PageTransition(
                                      child: PasswordScreen(),
                                      type: PageTransitionType.rightToLeft))
                              : Navigator.push(
                                  context,
                                  PageTransition(
                                      child: SignUp3(),
                                      type: PageTransitionType.rightToLeft));*/
                        }),
                    SizedBox(
                      height: 35,
                    ),
                    GestureDetector(
                      onTap: () {
                        /*Navigator.push(
                            context,
                            PageTransition(
                                child: Login(),
                                type: PageTransitionType.bottomToTop));*/
                      },
                      child: Column(
                        children: [
                          RichText(
                              text: TextSpan(
                                  text: "If you didn't receive code ? ",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontFamily: 'WorkSans',
                                      fontSize: 16),
                                  children: [
                                /* TextSpan(
                                    text: "Sign in",
                                    style: TextStyle(
                                        color: appPrimaryMaterialColor,
                                        fontFamily: 'WorkSans Bold',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16))*/
                              ])),
                          InkWell(
                            onTap: () {
                              _onVerifyCode();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Text("Resend",
                                  style: TextStyle(
                                      color: appPrimaryMaterialColor,
                                      fontFamily: 'WorkSans Bold',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16)),
                            ),
                          )
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
