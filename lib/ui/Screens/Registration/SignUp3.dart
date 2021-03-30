import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watcher_app_for_securityguard/Common/Services.dart';
import 'package:watcher_app_for_securityguard/Common/appColors.dart';
import 'package:watcher_app_for_securityguard/Common/fontStyles.dart';
import 'package:watcher_app_for_securityguard/ui/CustomWidgets/CircleDesign.dart';
import 'package:watcher_app_for_securityguard/ui/CustomWidgets/MyButton.dart';
import 'package:watcher_app_for_securityguard/ui/CustomWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_securityguard/ui/Screens/HomeScreen.dart';

class SignUp3 extends StatefulWidget {
  String mobile;
  SignUp3({this.mobile});
  @override
  _SignUp3State createState() => _SignUp3State();
}

class _SignUp3State extends State<SignUp3> {
  List postData = [];
  bool isLoading = false;
  final _info_formKey = GlobalKey<FormState>();
  final _images_formKey = GlobalKey<FormState>();
  final _password_formKey = GlobalKey<FormState>();
  final TextEditingController txtFirstNameController = TextEditingController();
  final TextEditingController txtMiddleNameController = TextEditingController();
  final TextEditingController txtLastNameController = TextEditingController();
  final TextEditingController txtEmailNameController = TextEditingController();
  final TextEditingController txtAddressController = TextEditingController();
  final TextEditingController txtSocietyCodeController =
      TextEditingController();
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
  String ProofType;
  bool _passwordLength=false;
  bool _passwordNumberSymbol=false;
  bool _passwordUpperLower=false;
  //List proof = ["Driving Licence", "Aadhar Card"];

  List ProofTypeList;
  String IdproofType;
  var proofType = "";

  var deviceType = "";

  File _userProfile, _identityProof;
  String _userFileName, _identityFileName;
  String _userFilePath, _identityFilePath;
  final picker = ImagePicker();

  _imgFromCamera() async {
    File image_profile = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _userProfile = image_profile;
    });
  }

  _imgFromCamera_proof() async {
    File image_proof = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _identityProof = image_proof;
    });
  }

  _imgFromGallery() async {
    File imageProfile = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _userProfile = imageProfile;
    });
  }

  _imgFromGallery_proof() async {
    File image_proof = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _identityProof = image_proof;
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

  signUp() async {
    try {
      var api = "api/staff/watchmanSignUp";
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (Platform.isAndroid == true) {
          deviceType = "android";
        } else if (Platform.isIOS == true) {
          deviceType = "ios";
        }
        print(IdproofType);

        String userFileName, identityFileName = "";
        String userFilePath, identityFilePath = "";
        File userCompressedFile, identityCompressedFile;

        if (_userProfile != null && _identityProof != null) {
          ImageProperties userprofileProperties =
          await FlutterNativeImage.getImageProperties(_userProfile.path);
          ImageProperties identityFileProperties =
          await FlutterNativeImage.getImageProperties(_identityProof.path);

          userCompressedFile = await FlutterNativeImage.compressImage(
              _userProfile.path,
              quality: 90);
          identityCompressedFile = await FlutterNativeImage.compressImage(
              _identityProof.path,
              quality: 90);

          userFileName = _userProfile.path.split('/').last;
          userFilePath = userCompressedFile.path;

          identityFileName = _identityProof.path.split('/').last;
          identityFilePath = identityCompressedFile.path;
        } else if (_userFilePath != null && _identityFilePath != "") {
          userFilePath = _userFilePath;
          userFileName = _userFileName;

          identityFilePath = _identityFilePath;
          identityFileName = _identityFileName;
        }

        FormData body = FormData.fromMap({
          "firstName": txtFirstNameController.text,
          "lastName": txtLastNameController.text,
          "mobileNo1": "9925918592", //widget.mobile,
          "emailId": txtEmailNameController.text,
          "address": txtAddressController.text,
          "password": txtCreatePasswordController.text,
          "societyCode": "SOC-RAGHUVIR-525411000000", //txtSocietyCodeController.text,
          "identityProof": IdproofType,
          "deviceType": deviceType,
          "identityImage": (identityFilePath != null && identityFilePath != '')
              ? await MultipartFile.fromFile(identityFilePath,
              filename: identityFileName.toString())
              : null,
          "watchmanImage": (userFilePath != null && userFilePath != '')
              ? await MultipartFile.fromFile(userFilePath,
              filename: userFileName.toString())
              : null,
        });
        log(body.fields.toString());
        Services.apiHandler(apiName: api, body: body).then((data) async {
          if (data.Data.length > 0) {
            postData = data.Data;
            print(postData);
            final login_pref = await SharedPreferences.getInstance();
            print("loginf Access ________________________________________");
            login_pref.setBool("isApprove", postData[0]["isApprove"]);
            login_pref.setString("firstName", postData[0]["firstName"]);
            login_pref.setString("lastName", postData[0]["lastName"]);
            login_pref.setString("id", postData[0]["_id"]);
            login_pref.setString("mobileNo1", postData[0]["mobileNo1"]);
            login_pref.setString("emailId", postData[0]["emailId"]);

            Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                    child: HomeScreen(), type: PageTransitionType.rightToLeft),
                    (route) => false);
          } else {
            Fluttertoast.showToast(
                msg: "Registration not successfully completed.",
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                toastLength: Toast.LENGTH_LONG);
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
      Fluttertoast.showToast(
          msg: "No internet connection.",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
      setState(() {
        isempty = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PostForIdProofType();
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return Scaffold(
        //resizeToAvoidBottomInset: false,
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
                            child: Form(
                              key: _info_formKey,
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
                                      return null;
                                    },
                                    hintText: "Enter first name",
                                  ),
                                  MyTextFormField(
                                      lable: "Middle Name",
                                      controller: txtMiddleNameController,
                                      hintText: "Enter Middle name"),
                                  MyTextFormField(
                                      lable: "Last Name *",
                                      controller: txtLastNameController,
                                      validator: (val) {
                                        if (val.isEmpty) {
                                          return "Please Enter Last Name";
                                        }
                                        return null;
                                      },
                                      hintText: "Enter last name"),
                                  MyTextFormField(
                                      lable: "email (Optional)",
                                      controller: txtEmailNameController,
                                      hintText: "Enter email"),
                                  MyTextFormField(
                                      lable: "Address *",
                                      controller: txtAddressController,
                                      validator: (val) {
                                        if (val.isEmpty) {
                                          return "Please Enter Address";
                                        }
                                        return null;
                                      },
                                      hintText: "Enter Address"),
                                  MyTextFormField(
                                    lable: "Society Code *",
                                    controller: txtSocietyCodeController,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Please Enter Society Code";
                                      }
                                      return null;
                                    },
                                    hintText: "Enter Society Code",
                                  ),
                                  MyTextFormField(
                                      lable:
                                          "Car registration number (Optional)",
                                      controller: txtParkingNumberController,
                                      hintText:
                                          "Enter Car registration number"),
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
                          ),
                        )
                      ] else if (selectedIndex == 1) ...[
                        Expanded(
                            child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Form(
                            key: _images_formKey,
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
                                  child: _userProfile == null
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
                                              color:
                                                  appPrimaryMaterialColor[700],
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
                                              image: FileImage(_userProfile),
                                              fit: BoxFit.fill,
                                            ),
                                            borderRadius: new BorderRadius.all(
                                                new Radius.circular(90.0)),
                                            border: new Border.all(
                                              color:
                                                  appPrimaryMaterialColor[700],
                                              width: 3,
                                            ),
                                          ),
                                        ),
                                ),
                                SizedBox(height: 12),
                                Text("Click or Select Profile Photo",
                                    style: fontConstants.smallText),
                                SizedBox(
                                  height: 18,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(8.0)),
                                  child: DropdownButtonHideUnderline(
                                    child: ButtonTheme(
                                      alignedDropdown: true,
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        value: IdproofType,
                                        iconSize: 30,
                                        icon: (null),
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 16,
                                        ),
                                        hint:
                                            Text('Select Identity Proof Type'),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            IdproofType = newValue;
                                            proofType = newValue.toString();
                                            print(IdproofType);
                                          });
                                        },
                                        items: ProofTypeList?.map((item) {
                                              return new DropdownMenuItem(
                                                child: new Text(
                                                    item['identityProofName']),
                                                value: item['_id'].toString(),
                                              );
                                            })?.toList() ??
                                            [],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                InkWell(
                                  onTap: () {
                                    _showPickerProof(context);
                                  },
                                  child: _identityProof == null
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
                                                        BorderRadius.circular(
                                                            4)),
                                                color: Color(0x22888888),
                                                image: DecorationImage(
                                                  image: FileImage(_identityProof),
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
                          ),
                        ))
                      ] else ...[
                        Expanded(
                            child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Form(
                            key: _password_formKey,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                                        child: Text("Create Password", style: fontConstants.formFieldLabel),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 2.0),
                                        child: TextFormField(
                                          controller: txtCreatePasswordController,
                                          style: TextStyle(fontSize: 13),
                                          decoration: InputDecoration(
                                            fillColor: Colors.grey[200],
                                            filled: true,
                                            hintText: "Create Password",
                                            hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                                            floatingLabelBehavior: FloatingLabelBehavior.never,
                                            contentPadding:
                                            EdgeInsets.only(left: 15, right: 8, top: 4, bottom: 4),
                                            counterText: "",
                                            errorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(8),
                                              borderSide: BorderSide(
                                                width: 0,
                                                style: BorderStyle.solid,
                                                color: Colors.red,
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(8),
                                              borderSide: BorderSide(
                                                width: 0,
                                                style: BorderStyle.none,
                                              ),
                                            ),
                                          ),
                                          validator: (val) {
                                            if (val.isEmpty) {
                                              return "Please Enter Password";
                                            }
                                            return null;
                                          },
                                          onChanged: (String val){
                                            // if(val.length==10){
                                            //}
                                            containPassword();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                /*MyTextFormField(
                                    controller: txtCreatePasswordController,
                                    lable: "Create Password",
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Please Enter Password";
                                      }
                                      return null;
                                    },

                                    hintText: "Enter Password"),*/
                                MyTextFormField(
                                    lable: "Confirm Password",
                                    controller: txtConfirmPasswordController,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Pasword does not match";
                                      }
                                      return null;
                                    },
                                    hintText: "Re-enter Password"),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, bottom: 4.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.lock,
                                        size: 13,
                                        color: Colors.grey,
                                      ),
                                      Text(
                                        "  Password must contain :",
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.black87),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /*Text(
                                      "○ at least 8 characters",
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.black87),
                                    ),*/
                                    RichText(
                                      text: TextSpan(
                                        style: TextStyle(color:Colors.black87),
                                        children: [
                                          _passwordLength==false? WidgetSpan(
                                            child: Icon(Icons.cancel_outlined, size: 15, color: Colors.red,),
                                          ):WidgetSpan(
                                            child: Icon(Icons.verified_outlined, size: 15, color: Colors.green,),
                                          ),
                                          TextSpan(
                                            text: " at least 8 characters",
                                          ),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style: TextStyle(color:Colors.black87),
                                        children: [
                                          _passwordNumberSymbol==false ? WidgetSpan(
                                            child: Icon(Icons.cancel_outlined, size: 15, color: Colors.red,),
                                          ):WidgetSpan(
                                            child: Icon(Icons.verified_outlined, size: 15, color: Colors.green,),
                                          ),
                                          TextSpan(
                                            text: " at least 1 number and 1 symbol like ( ! , \$ , # , & )",
                                          ),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style: TextStyle(color:Colors.black87),
                                        children: [
                                          _passwordUpperLower == false ? WidgetSpan(
                                            child: Icon(Icons.cancel_outlined, size: 15, color: Colors.red,),
                                          ):WidgetSpan(
                                            child: Icon(Icons.verified_outlined, size: 15, color: Colors.green,),
                                          ),
                                          TextSpan(
                                            text: " both uppercase and lowercase",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                MyButton(
                                  onPressed: () {
                                    _password_formKey.currentState.validate();
                                    checkPassword();
                                    //signUp();
                                  },
                                  title: "Sign Up",
                                )
                              ],
                            ),
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
                              print(_info_formKey.currentState.validate());
                              if (_info_formKey.currentState.validate() !=
                                  false) {
                                setState(() {
                                  selectedIndex = 1;
                                });
                              }
                              //_info_formKey.currentState.validate();
                              setState(() {
                                //selectedIndex = 1;
                                print("First Page $selectedIndex");
                                //checkTextFieldEmptyOrNot();
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
    var societyCode = txtSocietyCodeController.text;

    // Checking all compulsory TextFields.
    if (fname == '') {
      Fluttertoast.showToast(
        msg: "Please enter your first name.",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
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
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      setState(() {
        isempty = true;
      });
    } else if (societyCode == '') {
      Fluttertoast.showToast(
        msg: "Please enter your soceity code.",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      setState(() {
        isempty = true;
      });
    } else if (address == '') {
      Fluttertoast.showToast(
        msg: "Please enter your address.",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
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
    var proof = _identityProof;
    var profile = _userProfile;
    if (profile == null) {
      Fluttertoast.showToast(
          msg: "Please upload your profile image.",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
      setState(() {
        isempty = true;
      });
    } else if (proof == null) {
      Fluttertoast.showToast(
          msg: "Please upload your identity proof image.",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
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

  containPassword() {
    var create_pass = txtCreatePasswordController.text;

    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    String lower_upper = r'^(?=.*?[A-Z])(?=.*?[a-z])';
    String number_symbol = r'^(?=.*?[0-9])(?=.*?[!@#\$&*~])';

    RegExp regExp = new RegExp(pattern);
    var pwd_match = regExp.hasMatch(create_pass);

    RegExp regExp_LU = new RegExp(lower_upper);
    var pwd_matchLU = regExp_LU.hasMatch(create_pass);

    RegExp regExp_SN = new RegExp(number_symbol);
    var pwd_matchSN = regExp_SN.hasMatch(create_pass);


    if(create_pass == '' && create_pass.isEmpty){
      setState(() {
        _passwordUpperLower=false;
        _passwordNumberSymbol=false;
        _passwordLength = false;
      });
    }

    if(pwd_matchLU == false){
      print("not lower upper");
      setState(() {
        _passwordUpperLower=false;
      });
    }else{
      print("lower upper");
      setState(() {
        _passwordUpperLower=true;
      });
    }
    if(pwd_matchSN == false){
      print("not symbol number");
      setState(() {
        _passwordNumberSymbol=false;
      });
    }else{
      print("symbol number");
      setState(() {
        _passwordNumberSymbol=true;
      });
    }
    if(create_pass.length < 8 ) {
      print("not length");
      setState(() {
        _passwordLength = false;
      });
    }else{
      print("Lenght");
      setState(() {
        _passwordLength = true;
      });
    }

  }
  checkPassword() {
    var create_pass = txtCreatePasswordController.text;
    var confirm_pass = txtConfirmPasswordController.text;

    if (create_pass == '' && create_pass.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please enter your password.",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
      setState(() {
        isempty = true;
        _passwordLength=false;
        _passwordNumberSymbol=false;
        _passwordUpperLower=false;
      });
    } else if (confirm_pass == '' && confirm_pass.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please enter confirm password.",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
      setState(() {
        isempty = true;
      });
    } else if (create_pass != confirm_pass) {
      Fluttertoast.showToast(
          msg: "Password not matched.",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
      setState(() {
        isempty = true;
      });
    } else {
      String pattern =
          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

      RegExp regExp = new RegExp(pattern);
      var pwd_match = regExp.hasMatch(create_pass);

      if (pwd_match == false) {
        Fluttertoast.showToast(
            msg: "Password does not match with the requirement.",
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            toastLength: Toast.LENGTH_LONG);

        setState(() {
          isempty = true;
        });
      } else {
        signUp();
      }
    }
  }

  PostForIdProofType() async {
    try {
      List proofname = [];
      var api = "api/staff/getAllidentityCategory";
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Services.apiHandler(apiName: api).then((data) {
          if (data.Data.length > 0) {
            proofname = data.Data;
            ProofTypeList = data.Data;
          } else {
            Fluttertoast.showToast(
                msg: "No Identity proof type found",
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                toastLength: Toast.LENGTH_LONG);
            setState(() {
              isempty = true;
            });
          }
        }, onError: (e) {
          setState(() {
            isLoading = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(
              msg: "No internet connection.",
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              toastLength: Toast.LENGTH_LONG);
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(
          msg: "No internet connection.",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
      setState(() {
        isempty = true;
      });
    }
  }
}
