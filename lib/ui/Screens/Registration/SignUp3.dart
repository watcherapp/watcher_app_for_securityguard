import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:watcher_app_for_securityguard/Common/appColors.dart';
import 'package:watcher_app_for_securityguard/Common/fontStyles.dart';
import 'package:watcher_app_for_securityguard/ui/CustomWidgets/CircleDesign.dart';
import 'package:watcher_app_for_securityguard/ui/CustomWidgets/MyButton.dart';
import 'package:watcher_app_for_securityguard/ui/CustomWidgets/MyTextFormField.dart';

class SignUp3 extends StatefulWidget {
  @override
  _SignUp3State createState() => _SignUp3State();
}

class _SignUp3State extends State<SignUp3> {
  final TextEditingController txtFirstNameController = TextEditingController();
  final TextEditingController txtMiddleNameController = TextEditingController();
  final TextEditingController txtLastNameController = TextEditingController();
  final TextEditingController txtEmailNameController = TextEditingController();
  final TextEditingController txtAddressController = TextEditingController();
  final TextEditingController txtCreatePasswordController =
      TextEditingController();
  final TextEditingController txtConfirmPasswordController =
      TextEditingController();
  final TextEditingController txtParkingNumberController =
      TextEditingController();
  final TextEditingController txtCarRegistrationNumberController =
      TextEditingController();
  int selectedIndex = 0;
  bool isempty = false;

  /*Image picker code*/
  File _proof, _profile;
  final picker = ImagePicker();
  _imgFromCamera() async {
    File image_profile = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _profile = image_profile;
    });
  }

  _imgFromCamera_proof() async {
    File image_proof = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _proof = image_proof;
    });
  }

  _imgFromGallery() async {
    File image_profile = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _profile = image_profile;
    });
  }

  _imgFromGallery_proof() async {
    File image_proof = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _proof = image_proof;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _showPickerProof(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery_proof();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera_proof();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  // Future getImage() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.camera);
  //
  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }

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
                        height: 20,
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
                                    controller: txtFirstNameController,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Please Enter First Name";
                                      }
                                      return "";
                                    },
                                    hintText: "Enter first name"),
                                MyTextFormField(
                                    lable: "Middle Name",
                                    controller: txtMiddleNameController,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Please Enter Middle Name";
                                      }
                                      return "";
                                    },
                                    hintText: "Enter Middle name"),
                                MyTextFormField(
                                    lable: "Last Name *",
                                    controller: txtLastNameController,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Please Enter Last Name";
                                      }
                                      return "";
                                    },
                                    hintText: "Enter last name"),
                                MyTextFormField(
                                    lable: "email (Optional)",
                                    controller: txtEmailNameController,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Please Enter Last Name";
                                      }
                                      return "";
                                    },
                                    hintText: "Enter email"),
                                MyTextFormField(
                                    lable: "Address *",
                                    controller: txtAddressController,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Please Enter Address";
                                      }
                                      return "";
                                    },
                                    hintText: "Enter Address"),
                                MyTextFormField(
                                    lable: "Parking Number (Optional)",
                                    controller: txtParkingNumberController,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Please Enter Parking Number";
                                      }
                                      return "";
                                    },
                                    hintText: "Enter Parking Number"),
                                MyTextFormField(
                                    lable: "Car registration number (Optional)",
                                    controller: txtParkingNumberController,
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
                                height: 23,
                              ),
                              InkWell(
                                onTap: () {
                                  _showPicker(context);
                                  print("Tap image");
                                  // getImage();
                                },
                                child: _profile == null
                                    ? Container(
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
                                      )
                                    : Container(
                                        width: 130.0,
                                        height: 130.0,
                                        //child: Image.file(_image),
                                        decoration: new BoxDecoration(
                                          color: Color(0x22888888),
                                          image: DecorationImage(
                                            image: FileImage(_profile),
                                            fit: BoxFit.fill,
                                          ),
                                          borderRadius: new BorderRadius.all(
                                              new Radius.circular(90.0)),
                                          border: new Border.all(
                                            color: appPrimaryMaterialColor[700],
                                            width: 3,
                                          ),
                                        ),
                                      ),
                              ),
                              SizedBox(height: 18),
                              Text("Click or Select Profile Photo",
                                  style: fontConstants.smallText),
                              SizedBox(height: 30),
                              InkWell(
                                onTap: () {
                                  _showPickerProof(context);
                                },
                                child: _proof == null
                                    ? containerdash
                                    : Center(
                                        child: DottedBorder(
                                          borderType: BorderType.Rect,
                                          dashPattern: [5, 5, 5, 5],
                                          color: Colors.grey[400],
                                          child: Container(
                                            height: 129,
                                            width: 220,
                                            decoration: ShapeDecoration(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              color: Color(0x22888888),
                                              image: DecorationImage(
                                                image: FileImage(_proof),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                              SizedBox(height: 18),
                              Text("Select Identity Prooff",
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
                                  controller: txtCreatePasswordController,
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
                                  controller: txtConfirmPasswordController,
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return "Pasword does not match";
                                    }
                                    return "";
                                  },
                                  hintText: "Re-enter Password"),
                              SizedBox(
                                height: 5.0,
                              ),
                              /*Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.lock),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Text(
                                      "Your password needs to:\n- include both upper and lower case characters.\n- include at least one number or symbol.\n- be at least 8 character long.",
                                      style: TextStyle(
                                        color: appPrimaryMaterialColor,
                                        fontSize: 11.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),*/
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, bottom: 4.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.lock,
                                      size: 13,
                                      color: Colors.grey,
                                    ),
                                    Text(
                                      "  Password must contain :",
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.black87),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "○ at least 8 characters",
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.black87),
                                  ),
                                  Text(
                                    "○ at least 1 number and 1 symbol like ( ! , \$ , # , & )",
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.black87),
                                  ),
                                  Text(
                                    "○ both uppercase and lowercase",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                              MyButton(
                                onPressed: () {
                                  checkPassword();
                                  /*Navigator.pushAndRemoveUntil(
                                      context,
                                      PageTransition(
                                          child: HomeScreen(),
                                          type: PageTransitionType.rightToLeft),
                                      (route) => false);*/
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
                                        print("home {$selectedIndex}");
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
                                        //selectedIndex = 2;
                                        checkImageFieldEmptyOrNot();
                                        print("middle next $selectedIndex");
                                      });
                                    },
                                    heroTag: null,
                                    child: Icon(
                                        Icons.arrow_forward_ios_rounded)), //>
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
                                //selectedIndex = 1;
                                print("First Page $selectedIndex");
                                checkTextFieldEmptyOrNot();
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
                                        print("last $selectedIndex");
                                      });
                                    },
                                    heroTag: null,
                                    child: Icon(Icons.arrow_back_ios_rounded)),
                              ),
                            ),
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

  checkTextFieldEmptyOrNot() {
    // Getting Value From Text Field and Store into String Variable
    var fname = txtFirstNameController.text;
    var lname = txtLastNameController.text;
    var address = txtAddressController.text;

    // Checking all compulsory TextFields.
    if (fname == '') {
      Fluttertoast.showToast(
        msg: "Please enter your first name.",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: appPrimaryMaterialColor,
        textColor: Colors.white,
      );
      setState(() {
        isempty = true;
      });
      //print('Text Field is empty, Please Fill All Data');
    } else if (lname == '') {
      Fluttertoast.showToast(
        msg: "Please enter your last name.",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: appPrimaryMaterialColor,
        textColor: Colors.white,
      );
      setState(() {
        isempty = true;
      });
    } else if (address == '') {
      Fluttertoast.showToast(
        msg: "Please enter your address.",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: appPrimaryMaterialColor,
        textColor: Colors.white,
      );
      setState(() {
        isempty = true;
      });
    } else {
      setState(() {
        selectedIndex = 1;
        isempty = false;
      });
    }
  }

  checkImageFieldEmptyOrNot() {
    var proof = _proof;
    var profile = _profile;
    if (profile == null) {
      Fluttertoast.showToast(
          msg: "Please upload your profile image.",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: appPrimaryMaterialColor,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
      setState(() {
        isempty = true;
      });
    } else if (proof == null) {
      Fluttertoast.showToast(
          msg: "Please upload your identity proof image.",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: appPrimaryMaterialColor,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
      setState(() {
        isempty = true;
      });
    } else {
      selectedIndex = 2;
      isempty = false;
    }
  }

  checkPassword() {
    var create_pass = txtCreatePasswordController.text;
    var confirm_pass = txtConfirmPasswordController.text;

    if (create_pass == '' && create_pass.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please enter your password.",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: appPrimaryMaterialColor,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
      setState(() {
        isempty = true;
      });
    } else if (confirm_pass == '' && confirm_pass.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please enter confirm password.",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: appPrimaryMaterialColor,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
      setState(() {
        isempty = true;
      });
    } else if (create_pass != confirm_pass) {
      Fluttertoast.showToast(
          msg: "Password not matched.",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: appPrimaryMaterialColor,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
      setState(() {
        isempty = true;
      });
    } else {
      String pattern =
          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
      RegExp regExp = new RegExp(pattern);
      print(regExp.hasMatch(create_pass));
      var pwd_match = regExp.hasMatch(create_pass);
      if (pwd_match == false) {
        Fluttertoast.showToast(
            msg: "Password does not match with the requirement.",
            gravity: ToastGravity.BOTTOM,
            backgroundColor: appPrimaryMaterialColor,
            textColor: Colors.white,
            toastLength: Toast.LENGTH_LONG);
        setState(() {
          isempty = true;
        });
      }
      return regExp.hasMatch(create_pass);
    }
  }
}
