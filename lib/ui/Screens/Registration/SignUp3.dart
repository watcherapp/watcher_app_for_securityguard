import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_securityguard/Common/appColors.dart';
import 'package:watcher_app_for_securityguard/Common/fontStyles.dart';
import 'package:watcher_app_for_securityguard/ui/CustomWidgets/CircleDesign.dart';
import 'package:watcher_app_for_securityguard/ui/CustomWidgets/MyButton.dart';
import 'package:watcher_app_for_securityguard/ui/CustomWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_securityguard/ui/Screens/HomeScreen.dart';

class SignUp3 extends StatefulWidget {
  @override
  _SignUp3State createState() => _SignUp3State();
}

class _SignUp3State extends State<SignUp3> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: appPrimaryMaterialColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Tell us more about you !",
                          style: fontConstants.bigTitleBlack),
                      Text("Sign Up to Continue",
                          style: fontConstants.subTitleText),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 3,
                            width: 30,
                            decoration: BoxDecoration(
                                color: selectedIndex == 0
                                    ? appPrimaryMaterialColor
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(6.0)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                              height: 3,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: selectedIndex == 1
                                      ? appPrimaryMaterialColor
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(6.0)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                              height: 3,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: selectedIndex == 2
                                      ? appPrimaryMaterialColor
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(6.0)),
                            ),
                          )
                        ],
                      ),
                      if (selectedIndex == 0) ...[
                        Expanded(
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                MyTextFormField(
                                    lable: "First Name *",
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Please Enter First Name";
                                      }
                                      return "";
                                    },
                                    hintText: "Enter first name"),
                                MyTextFormField(
                                    lable: "Middle Name",
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Please Enter Middle Name";
                                      }
                                      return "";
                                    },
                                    hintText: "Enter Middle name"),
                                MyTextFormField(
                                    lable: "Last Name *",
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Please Enter Last Name";
                                      }
                                      return "";
                                    },
                                    hintText: "Enter last name"),
                                MyTextFormField(
                                    lable: "email (Optional)",
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Please Enter Last Name";
                                      }
                                      return "";
                                    },
                                    hintText: "Enter email"),
                                MyTextFormField(
                                    lable: "Address *",
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Please Enter Address";
                                      }
                                      return "";
                                    },
                                    hintText: "Enter Address"),
                                MyTextFormField(
                                    lable: "Parking Number (Optional)",
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Please Enter Parking Number";
                                      }
                                      return "";
                                    },
                                    hintText: "Enter Parking Number"),
                                MyTextFormField(
                                    lable: "Car registration number (Optional)",
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Please Enter Car registration number";
                                      }
                                      return "";
                                    },
                                    hintText: "Enter Car registration number"),
                                /* MyButton(
                                    title: "Next",
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              child: SignUp3(),
                                              type: PageTransitionType
                                                  .bottomToTop));
                                    }),*/
                              ],
                            ),
                          ),
                        )
                      ] else if (selectedIndex == 1) ...[
                        Expanded(
                            child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 35,
                              ),
                              Container(
                                width: 130.0,
                                height: 130.0,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 110,
                                ),
                                decoration: new BoxDecoration(
                                  color: Color(0x22888888),
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(90.0)),
                                  border: new Border.all(
                                    color: appPrimaryMaterialColor[700],
                                    width: 3,
                                  ),
                                ),
                              ),
                              SizedBox(height: 24),
                              Text("Click or Select Profile Photo",
                                  style: fontConstants.smallText),
                              SizedBox(height: 40),
                              containerdash,
                              SizedBox(height: 24),
                              Text("Select Identity Proof",
                                  style: fontConstants.smallText),
                            ],
                          ),
                        ))
                      ] else ...[
                        Expanded(
                            child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
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
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      PageTransition(
                                          child: HomeScreen(),
                                          type: PageTransitionType.rightToLeft),
                                      (route) => false);
                                },
                                title: "Sign Up",
                              )
                            ],
                          ),
                        ))
                      ]
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: keyboardIsOpened
            ? null
            : Stack(
                children: <Widget>[
                  selectedIndex == 1
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 31),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: FloatingActionButton(
                                    backgroundColor: appPrimaryMaterialColor,
                                    mini: true,
                                    onPressed: () {
                                      setState(() {
                                        selectedIndex = 0;
                                      });
                                    },
                                    heroTag: null,
                                    child: Icon(Icons.arrow_back_ios_rounded)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 31),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: FloatingActionButton(
                                    backgroundColor: appPrimaryMaterialColor,
                                    mini: true,
                                    onPressed: () {
                                      setState(() {
                                        selectedIndex = 2;
                                      });
                                    },
                                    heroTag: null,
                                    child:
                                        Icon(Icons.arrow_forward_ios_rounded)),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(),
                  selectedIndex == 0
                      ? Align(
                          alignment: Alignment.bottomRight,
                          child: FloatingActionButton(
                            backgroundColor: appPrimaryMaterialColor,
                            onPressed: () {
                              setState(() {
                                selectedIndex = 1;
                              });
                            },
                            mini: true,
                            heroTag: null,
                            child: Icon(Icons.arrow_forward_ios_rounded),
                          ),
                        )
                      : SizedBox(),
                  selectedIndex == 2
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 31),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: FloatingActionButton(
                                    backgroundColor: appPrimaryMaterialColor,
                                    mini: true,
                                    onPressed: () {
                                      setState(() {
                                        selectedIndex = 1;
                                      });
                                    },
                                    heroTag: null,
                                    child: Icon(Icons.arrow_back_ios_rounded)),
                              ),
                            ),
                            /*Padding(
                              padding: EdgeInsets.only(left: 31),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: FloatingActionButton(
                                    backgroundColor: appPrimaryMaterialColor,
                                    mini: true,
                                    onPressed: () {
                                      setState(() {
                                        selectedIndex = 0;
                                      });
                                    },
                                    heroTag: null,
                                    child:
                                        Icon(Icons.arrow_forward_ios_rounded)),
                              ),
                            ),*/
                          ],
                        )
                      : SizedBox(),
                ],
              ));
  }

  Widget get containerdash {
    return Center(
      child: DottedBorder(
        borderType: BorderType.Rect,
        dashPattern: [5, 5, 5, 5],
        color: Colors.grey[400],
        child: Container(
          height: 129,
          width: 220,
          decoration: ShapeDecoration(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            color: Color(0x22888888),
          ),
          child: Center(
            child: Container(
              width: 80.0,
              height: 80.0,
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 70,
              ),
              decoration: new BoxDecoration(
                color: Colors.grey[300],
                borderRadius: new BorderRadius.all(new Radius.circular(90.0)),
                border: new Border.all(color: Colors.grey[300], width: 0.5),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
