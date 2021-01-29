import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:watcher_app_for_securityguard/Common/appColors.dart';
import 'package:watcher_app_for_securityguard/ui/CustomWidgets/MyButton.dart';

class Verification extends StatefulWidget {
  @override
  _VerificationState createState() => new _VerificationState();
}

class _VerificationState extends State<Verification>
    with SingleTickerProviderStateMixin {
  // Constants
  final int time = 30;
  // Variables
  Size _screenSize;
  int _currentDigit;
  int _firstDigit;
  int _secondDigit;
  int _thirdDigit;
  int _fourthDigit;

  final List<String> _visitorType = ["Visitor", "Staff"];

  int selected_Index = 1;

  @override
  void initState() {
    super.initState();
  }

  get _getInputField {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _otpTextField(_firstDigit),
        _otpTextField(_secondDigit),
        _otpTextField(_thirdDigit),
        _otpTextField(_fourthDigit),
      ],
    );
  }

  get _getOtpKeyboard {
    return new Container(
        height: _screenSize.width - 130,
        child: new Column(
          children: <Widget>[
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "1",
                      onPressed: () {
                        _setCurrentDigit(1);
                      }),
                  _otpKeyboardInputButton(
                      label: "2",
                      onPressed: () {
                        _setCurrentDigit(2);
                      }),
                  _otpKeyboardInputButton(
                      label: "3",
                      onPressed: () {
                        _setCurrentDigit(3);
                      }),
                ],
              ),
            ),
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "4",
                      onPressed: () {
                        _setCurrentDigit(4);
                      }),
                  _otpKeyboardInputButton(
                      label: "5",
                      onPressed: () {
                        _setCurrentDigit(5);
                      }),
                  _otpKeyboardInputButton(
                      label: "6",
                      onPressed: () {
                        _setCurrentDigit(6);
                      }),
                ],
              ),
            ),
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "7",
                      onPressed: () {
                        _setCurrentDigit(7);
                      }),
                  _otpKeyboardInputButton(
                      label: "8",
                      onPressed: () {
                        _setCurrentDigit(8);
                      }),
                  _otpKeyboardInputButton(
                      label: "9",
                      onPressed: () {
                        _setCurrentDigit(9);
                      }),
                ],
              ),
            ),
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new SizedBox(
                    width: 80.0,
                  ),
                  _otpKeyboardInputButton(
                      label: "0",
                      onPressed: () {
                        _setCurrentDigit(0);
                      }),
                  _otpKeyboardActionButton(
                      label: new Icon(
                        Icons.backspace,
                        color: appPrimaryMaterialColor,
                      ),
                      onPressed: () {
                        setState(() {
                          if (_fourthDigit != null) {
                            _fourthDigit = null;
                          } else if (_thirdDigit != null) {
                            _thirdDigit = null;
                          } else if (_secondDigit != null) {
                            _secondDigit = null;
                          } else if (_firstDigit != null) {
                            _firstDigit = null;
                          }
                        });
                      }),
                ],
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Container(
        width: _screenSize.width,
        child: SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              SizedBox(
                height: 50,
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
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
              /* Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/VisitorHistoryList');
                          },
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 10),
                              Icon(Icons.search),
                              SizedBox(width: 5),
                              Expanded(child: Text("Search Visitor"))
                            ],
                          ),
                        ),
                        height: 45,
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0))),
                      ),
                    ),
                  ),
                   GestureDetector(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Center(
                            child: Icon(Icons.exit_to_app, color: Colors.red),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.red[100],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(80.0))),
                          height: 45,
                          width: 45,
                        ),
                        Text("Logout",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10))
                      ],
                    ),
                    onTap: () {},
                  ),
                ],
              ),*/
              Padding(padding: EdgeInsets.only(top: 25)),
              _getInputField,
              SizedBox(height: 60),
              _getOtpKeyboard,
              Padding(padding: EdgeInsets.only(top: 40)),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: 45,
                child: RaisedButton(
                    child: Text("Verify",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    color: appPrimaryMaterialColor,
                    onPressed: () {}),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Returns "Otp custom text field"
  Widget _otpTextField(int digit) {
    return new Container(
      width: 45.0,
      height: 45.0,
      alignment: Alignment.center,
      child: new Text(
        digit != null ? digit.toString() : "",
        style: new TextStyle(
          fontSize: 30.0,
          color: Colors.black,
        ),
      ),
      decoration: BoxDecoration(
//            color: Colors.grey.withOpacity(0.4),
          border: Border(
              bottom: BorderSide(
        width: 2.0,
        color: Colors.black,
      ))),
    );
  }

  // Returns "Otp keyboard input Button"
  Widget _otpKeyboardInputButton({String label, VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: new Material(
        color: Colors.grey[100],
        child: new InkWell(
          onTap: onPressed,
          borderRadius: new BorderRadius.circular(40.0),
          child: new Container(
            height: 80.0,
            width: 80.0,
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: new Center(
              child: new Text(
                label,
                style: new TextStyle(
                  fontSize: 30.0,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Returns "Otp keyboard action Button"
  _otpKeyboardActionButton({Widget label, VoidCallback onPressed}) {
    return new InkWell(
      onTap: onPressed,
      borderRadius: new BorderRadius.circular(40.0),
      child: new Container(
        height: 80.0,
        width: 80.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: new Center(
          child: label,
        ),
      ),
    );
  }

  // Current digit
  void _setCurrentDigit(int i) {
    setState(() {
      _currentDigit = i;
      if (_firstDigit == null) {
        _firstDigit = _currentDigit;
      } else if (_secondDigit == null) {
        _secondDigit = _currentDigit;
      } else if (_thirdDigit == null) {
        _thirdDigit = _currentDigit;
      } else if (_fourthDigit == null) {
        _fourthDigit = _currentDigit;
      }
    });
  }

  void clearOtp() {
    _fourthDigit = null;
    _thirdDigit = null;
    _secondDigit = null;
    _firstDigit = null;
    setState(() {});
  }
}
