import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watcher_app_for_securityguard/Common/Services.dart';
import 'package:watcher_app_for_securityguard/Common/appColors.dart';
import 'package:watcher_app_for_securityguard/Common/fontStyles.dart';
import 'package:watcher_app_for_securityguard/ui/CustomWidgets/CircleDesign.dart';
import 'package:watcher_app_for_securityguard/ui/CustomWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_securityguard/ui/CustomWidgets/PopUp.dart';
import 'package:watcher_app_for_securityguard/ui/Screens/Forgotpassword/VerifyScreen.dart';
import 'package:watcher_app_for_securityguard/ui/Screens/HomeScreen.dart';
import 'package:watcher_app_for_securityguard/ui/Screens/Registration/SignUp3.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool password = true;
  GlobalKey _formKey = GlobalKey<FormState>();
  bool isVerify = true;
  List postData = [];
  bool isLoading = false;
  bool isempty = false;
  var deviceType = "";
  final TextEditingController txtMobilOrEmailCntrl = TextEditingController();
  final TextEditingController txtPasswordCntrl = TextEditingController();

  PostForLogin() async {
    try {
      setState(() {
        isLoading = true;
      });
      final login_pref = await SharedPreferences.getInstance();
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var api = "api/staff/securityGuardSignIn";
        if (Platform.isAndroid == true) {
          deviceType = "Android";
        } else if (Platform.isIOS == true) {
          deviceType = "iphone";
        }
        var data_body = {
          'mobileNo1': txtMobilOrEmailCntrl.text,
          'password': txtPasswordCntrl.text,
          'fcmToken': 'ccdsacscavgscdgfcvdfbsvcg',
          'deviceType': deviceType,
        };
        Services.apiHandler(apiName: api, body: data_body).then((data) async {
          if (data.Data.length > 0) {
            postData = data.Data;
            print(postData);
            setState(() {
              login_pref.setBool("isApprove", postData[0]["isApprove"]??"");
              login_pref.setString("firstName", postData[0]["firstName"]??"");
              login_pref.setString("lastName", postData[0]["lastName"]??"");
              login_pref.setString("id", postData[0]["_id"]??"");
              login_pref.setString(
                  "staffCategoryId", postData[0]["staffCategoryId"]??"");
              login_pref.setString("mobileNo1", postData[0]["mobileNo1"]??"");
              login_pref.setString("emailId", postData[0]["emailId"]??"");
              login_pref.setString("societyId", postData[0]["societyId"]??"");
              login_pref.setString("staffNo", postData[0]["staffNo"]??"");
              login_pref.setString("fcmToken", postData[0]["fcmToken"]??"");
            });
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          } else {
            //Fluttertoast.showToast(msg: "Invalid username or password!");
            showDialog(
                context: context,
                builder: (context) => PopUp(
                    titleText: "Access Denied",
                    messageText: "Invalid username or password!"));
            setState(() {
              txtMobilOrEmailCntrl.clear();
              txtPasswordCntrl.clear();
            });
          }
          setState(() {
            isLoading = false;
          });
        }, onError: (e) {
          setState(() {
            isLoading = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "Something Went Wrong");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection.");
      print("No Internet Connection");
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: appPrimaryMaterialColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CircleDesign(title: "Sign In"),
            Container(
              height: MediaQuery.of(context).size.height * 0.765,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )),
              child: Padding(
                padding: paddingConstant.authScreenContentPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome Back", style: fontConstants.bigTitleBlack),
                    Text("Sign In to Continue",
                        style: fontConstants.subTitleText),
                    SizedBox(
                      height: 30,
                    ),

                    // Email or Mobile Number

                    MyTextFormField(
                      controller: txtMobilOrEmailCntrl,
                      lable: "Mobile No or email",
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Please Enter Mobile or email";
                        }
                        return "";
                      },
                      hintText: "Enter mobile or email",
                    ),

                    //Passwprd FormField

                    MyTextFormField(
                      controller: txtPasswordCntrl,
                      lable: "Password",
                      hintText: "Enter Password",
                      isPassword: password,
                      hideShowText: InkWell(
                        onTap: () {
                          setState(() {
                            password = !password;
                          });
                        },
                        child: Text("${!password ? "Hide" : "Show"}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: appPrimaryMaterialColor)),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          /*Navigator.push(
                              context,
                              PageTransition(
                                  child: VerifyScreen(),
                                  type: PageTransitionType.bottomToTop));*/
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: VerifyScreen(
                                    verifyData: isVerify,
                                  ),
                                  type: PageTransitionType.rightToLeft));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("Forgot Password ?"),
                            ],
                          ),
                        )),
                    // Sign In Button
                    /*isLoading != true
                        ? MyButton(
                            title: "Sign In",
                            onPressed: () {
                              PostForLogin();
                            },
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.3,
                            color: appPrimaryMaterialColor,
                            child: Center(child: CircularProgressIndicator()),
                          ),*/
                    SizedBox(
                      height: 35,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        color: appPrimaryMaterialColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        onPressed: () {
                          checkTextFieldEmptyOrNot();
                          if (isempty == false) PostForLogin();
                        },
                        child: isLoading == true
                            ? Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 3.5,
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )
                            : Text(
                                "Sign In",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            /*Navigator.push(
                                context,
                                PageTransition(
                                    child: SignUp1(),
                                    type: PageTransitionType.bottomToTop));*/
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: SignUp3(),
                                    type: PageTransitionType.bottomToTop));
                          },
                          child: RichText(
                            text: TextSpan(
                              text: "Don't have an account ? ",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: 'WorkSans',
                                  fontSize: 16),
                              children: [
                                TextSpan(
                                  text: "Sign Up",
                                  style: TextStyle(
                                      color: appPrimaryMaterialColor,
                                      fontFamily: 'WorkSans Bold',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  checkTextFieldEmptyOrNot() {
    // Creating 3 String Variables.

    // Getting Value From Text Field and Store into String Variable
    var userid = txtMobilOrEmailCntrl.text;
    var pass = txtPasswordCntrl.text;

    // Checking all TextFields.
    if (userid == '' || pass == '') {
      Fluttertoast.showToast(
        msg: "Please enter username or password",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: appPrimaryMaterialColor,
        textColor: Colors.white,
      );
      setState(() {
        isempty = true;
      });
      ;
      //print('Text Field is empty, Please Fill All Data');
    } else {
      setState(() {
        isempty = false;
      });
    }
  }
}
