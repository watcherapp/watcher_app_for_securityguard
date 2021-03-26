import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watcher_app_for_securityguard/Common/Services.dart';
import 'package:watcher_app_for_securityguard/Common/appColors.dart';
import 'package:watcher_app_for_securityguard/ui/CustomWidgets/DialogOpenFormField.dart';
import 'package:watcher_app_for_securityguard/ui/CustomWidgets/MyButton.dart';
import 'package:watcher_app_for_securityguard/ui/CustomWidgets/MyDropdown.dart';
import 'package:watcher_app_for_securityguard/ui/CustomWidgets/MyTextFormField.dart';

import 'OTPScreen2.dart';
import 'package:watcher_app_for_securityguard/Common/fontStyles.dart';
//import 'package:video_player/video_player.dart';


class AddVisitorScreen extends StatefulWidget {
  @override
  _AddVisitorScreenState createState() => _AddVisitorScreenState();
}

class _AddVisitorScreenState extends State<AddVisitorScreen> {
  TextEditingController txtFirstNameController = TextEditingController();
  TextEditingController txtLastNameController = TextEditingController();
  TextEditingController txtMobileController = TextEditingController();
  TextEditingController txtEmailController = TextEditingController();
  var wing_flat = "";
  var relation = "";
  var _reason = "";

  String reasonData, relativeData;

  List reasonList;
  String reason_Type;
  var reason = "";

  List wingList;
  String wing_Type;
  var wing = "";

  List flatsList;
  String flats_Type;
  var flats = "";

  List guestTypeList;
  String guest_Type;
  var guest = "";

  List visitorsRecored = [];

  bool isempty = false;
  bool isLoading = false;

  File _visitorProfile, _frontIdProof, _backIdProof, _guestVideo;
  String _visitorFileName, _frontFileName, _backFileName;
  String _visitorFilePath, _frontFilePath, _backFilepath;

  _visitorImgFromCamera() async {
    // ignore: deprecated_member_use
    File image_profile = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 60);
    setState(() {
      _visitorProfile = image_profile;
    });
  }
  _visitorImgFromGallery() async {
    // ignore: deprecated_member_use
    File imageProfile = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 60);
    setState(() {
      _visitorProfile = imageProfile;
    });
  }
  void _visitorsShowPicker(context) {
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
                        _visitorImgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _visitorImgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _frontImgFromCamera() async {
    // ignore: deprecated_member_use
    File image_profile = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _frontIdProof = image_profile;
    });
  }
  _frontImgFromGallery() async {
    // ignore: deprecated_member_use
    File imageProfile = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _frontIdProof = imageProfile;
    });
  }
  void _frontShowPicker(context) {
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
                        _frontImgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _frontImgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _backImgFromCamera() async {
    // ignore: deprecated_member_use
    File image_profile = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _backIdProof = image_profile;
    });
  }
  _backImgFromGallery() async {
    // ignore: deprecated_member_use
    File imageProfile = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _backIdProof = imageProfile;
    });
  }
  void _backShowPicker(context) {
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
                        _backImgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _backImgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _videoFromCamera() async {
    // ignore: deprecated_member_use
    File video_guest = await ImagePicker.pickVideo(
        source: ImageSource.camera,);
    setState(() {
      _guestVideo = video_guest;
    });
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PostForGetAllWing();
    PostForVisitReason();
    PostForGetAllGuestCategory();
  }

  PostForGetAllGuestCategory() async {
    try {
      var api = "api/guest/getAllGuestCategory";
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Services.apiHandler(apiName: api,).then((data) {
          if (data.Data.length > 0) {
            setState(() {
              guestTypeList = data.Data;
            });
            print(guestTypeList);
          } else {
            Fluttertoast.showToast(
                msg: "Guest type not found.",
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

  FindRecoredFromMoobileNo(var mobile_num)async{
    try {
      var api = "api/staff/getExistVisitorData";
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var body_data = {
          "mobileNo" : mobile_num,
        };
        Services.apiHandler(apiName: api, body: body_data).then((data) {
          if (data.Data.length > 0) {
            setState(() {
              visitorsRecored = data.Data;
              txtFirstNameController.text = visitorsRecored[0]['firstName'];//TextEditingController(text: );
              txtLastNameController.text = visitorsRecored[0]['lastName'];//TextEditingController(text: );
              txtEmailController.text = visitorsRecored[0]['emailId'];//TextEditingController(text: visitorsRecored[0]['emailId']);
            });
            print(visitorsRecored);
            print(txtFirstNameController.text);
          } else {
            Fluttertoast.showToast(
                msg: "Visitors recored not found.",
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

  PostForVisitReason() async {
    try {
      var api = "api/admin/getAllPurposeCategory";
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Services.apiHandler(apiName: api).then((data) {
          if (data.Data.length > 0) {
            setState(() {
              reasonList = data.Data;
            });

            print(reasonList);
          } else {
            Fluttertoast.showToast(
                msg: "Visitors reasons not found.",
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

  PostForGetAllWing() async {
    try {
      var api = "api/society/getAllWingsOfSociety";
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        final login_pref = await SharedPreferences.getInstance();
        print("SOC ID = "+login_pref.getString("societyId"));
        var body_data = {"societyId" : login_pref.getString("societyId")};
        Services.apiHandler(apiName: api, body: body_data).then((data) {
          if (data.Data.length > 0) {
            setState(() {
              wingList = data.Data;
            });
            print(wingList);
          } else {
            Fluttertoast.showToast(
                msg: "Society wings not found.",
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

  PostForGetAllFlatsFromWings(wingID) async {
    try {
      var api = "api/society/getFlatsOfSocietyWing";
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        final login_pref = await SharedPreferences.getInstance();
        print("SOC ID = "+login_pref.getString("societyId"));
        var body_data = {"societyId" : login_pref.getString("societyId"),"wingId":wingID};
        Services.apiHandler(apiName: api, body: body_data).then((data) {
          if (data.Data.length > 0) {
            setState(() {
              flatsList = data.Data;
            });
            print(flatsList);
          } else {
            Fluttertoast.showToast(
                msg: "Flats not found.",
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.5,
          centerTitle: true,
          backgroundColor: appPrimaryMaterialColor,
          title: Text(
            "Add Visitor",
            style: TextStyle(fontSize: 17),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.cancel,
                color: Colors.white,
                size: 19,
              ),
              onPressed: () {
                Navigator.pop(context);
              })),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 11.0, right: 11),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                      child: Text("Mobile No", style: fontConstants.formFieldLabel),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: TextFormField(
                        controller: txtMobileController,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 13),
                        maxLength: 10,
                        decoration: InputDecoration(
                          fillColor: Colors.grey[200],
                          filled: true,
                          hintText: "Mobile No",
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
                        onChanged: (String val){
                         // if(val.length==10){
                            FindRecoredFromMoobileNo(val);
                          //}
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap:(){
                        _visitorsShowPicker(context);
                        print("visitors profile");
                      } ,
                      child: _visitorProfile == null ? Container(
                        width: 100.0,
                        height: 100.0,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 95,
                        ),
                        decoration: new BoxDecoration(
                          color: Color(0x22888888),
                          borderRadius:
                          new BorderRadius.all(new Radius.circular(90.0)),
                          border: new Border.all(
                            color: Colors.grey,
                            width: 0.5,
                          ),
                        ),
                      ):Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: new BoxDecoration(
                          color: Color(0x22888888),
                          image: DecorationImage(
                            image: FileImage(_visitorProfile),
                            fit: BoxFit.fill,
                          ),
                          borderRadius:
                          new BorderRadius.all(new Radius.circular(90.0)),
                          border: new Border.all(
                            color: Colors.grey,
                            width: 0.5,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 7.0),
                        child: Column(
                          children: [
                            MyTextFormField(
                                lable: "First Name",
                                controller: txtFirstNameController,
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Please Enter first name";
                                  }
                                  return null;
                                },
                                hintText: "Enter first name"),
                            MyTextFormField(
                                lable: "Last Name",
                                controller: txtLastNameController,
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Please Enter last name";
                                  }
                                  return null;
                                },
                                hintText: "Enter last name"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              MyTextFormField(
                  lable: "Email   ( optional )",
                  controller: txtEmailController,
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Please Enter email";
                    }
                    return null;
                  },
                  hintText: "Enter email",),
              /*Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: DialogOpenFormField(
                    lable: "Select Wings",
                    //value: reasonData,
                    onTap: () {
                      // print("click");
                      FocusScope.of(context).unfocus();
                      showDialog(
                        builder: (context) => Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: MyDropDown(
                              dropDownTitle: "Select C",
                              // dropDownData: reason,
                              onSelectValue: (value) {
                                setState(() {
                                  // reasonData = value;
                                });
                              }),
                        ),
                        context: context,
                      );
                    }),
              ),*/
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                    child: Text("Select Wings",style: fontConstants.formFieldLabel),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8.0)),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: wing_Type,
                            iconSize: 30,
                            icon: (null),
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                            hint:
                            Text('Select Wings', style: fontConstants.formFieldLabel,),
                            onChanged: (String newValue) {
                              setState(() {
                                wing_Type = newValue;
                                wing = newValue.toString();
                                print(wing_Type);
                                PostForGetAllFlatsFromWings(wing_Type);
                              });
                            },
                            items: wingList?.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(
                                    item['wingName']),
                                value: item['_id'].toString(),
                              );
                            })?.toList() ??
                                [],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                    child: Text("Select Flats",style: fontConstants.formFieldLabel),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8.0)),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: flats_Type,
                            iconSize: 30,
                            icon: (null),
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                            hint:
                            Text('Select Flats', style: fontConstants.formFieldLabel,),
                            onChanged: (String newValue) {
                              setState(() {
                                flats_Type = newValue;
                                flats = newValue.toString();
                                print(flats_Type);
                              });
                            },
                            items: flatsList?.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(
                                    item['flatNo'].toString()),
                                value: item['_id'].toString(),
                              );
                            })?.toList() ??
                                [],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                    child: Text("Select Guest Type",style: fontConstants.formFieldLabel),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8.0)),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: guest_Type,
                            iconSize: 30,
                            icon: (null),
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                            hint:
                            Text('Select Guest Type', style: fontConstants.formFieldLabel,),
                            onChanged: (String newValue) {
                              setState(() {
                                guest_Type = newValue;
                                guest = newValue.toString();
                                print(guest_Type);
                              });
                            },
                            items: guestTypeList?.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(
                                    item['guestType'].toString()),
                                value: item['_id'].toString(),
                              );
                            })?.toList() ??
                                [],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                    child: Text("Visit Reason",style: fontConstants.formFieldLabel),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8.0)),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: reason_Type,
                            iconSize: 30,
                            icon: (null),
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                            hint:
                            Text('Visit Reason', style: fontConstants.formFieldLabel,),
                            onChanged: (String newValue) {
                              setState(() {
                                reason_Type = newValue;
                                reason = newValue.toString();
                                print(reason_Type);
                              });
                            },
                            items: reasonList?.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(
                                    item['purposeName']),
                                value: item['_id'].toString(),
                              );
                            })?.toList() ??
                                [],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 4.0),
                    child: Text("Select ID Proof",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 4.0),
                    child: Text("Record 5 sec Video",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      _frontShowPicker(context);
                      print("Front Img");
                    },
                    child: _frontIdProof == null
                        ? containerdash1 : Center(
                            child: Container(
                              height: 110,
                              width: 100,
                              decoration: ShapeDecoration(
                                image: DecorationImage(
                                  image: FileImage(_frontIdProof),
                                  fit: BoxFit.fill,
                                ),
                                shape:
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                color: Color(0x22888888),
                              ),
                            ),
                          ),
                  ),
                  InkWell(
                    onTap: (){
                      _backShowPicker(context);
                      print("back Img");
                    },
                    child: _backIdProof == null
                        ? containerdash2 : Center(
                      child: Container(
                        height: 110,
                        width: 100,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: FileImage(_backIdProof),
                            fit: BoxFit.fill,
                          ),
                          shape:
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          color: Color(0x22888888),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      _videoFromCamera();
                      print("video tap");
                    },
                    child: _guestVideo == null
                        ? containerdash3 : Center(
                      child: Container(
                        height: 110,
                        width: 100,
                        decoration: ShapeDecoration(
                          shape:
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          color: Color(0x22888888),
                        ),
                        // child: FileImagettedBoxBox(
                        //   fit: BoxFit.contain,
                        //   child: mounted?Chewie(
                        //     controller: ChewieController(
                        //       videoPlayerController: VideoPlayerController.file(_guestVideo),
                        //       aspectRatio: 3/2,
                        //       autoPlay: true,
                        //       looping: true,
                        //     ),
                        //   ):Container()
                        // ),
                      ),
                    ),
                  ),
                  //_videoFromCamera
                  //containerdash1,
                  //containerdash2,
                  //containerdash3,
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: MyButton(
                    title: "Save Visitor",
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: OTPScreen(),
                              type: PageTransitionType.rightToLeft));
                    }),
              ),
              /*Center(
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: ShapeDecoration(
                    shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    color: Color(0x22888888),
                  ),
                  child: FittedBox(
                      fit: BoxFit.contain,
                      child: mounted?Chewie(
                        controller: ChewieController(
                          videoPlayerController: VideoPlayerController.file(_guestVideo),
                          aspectRatio: 3/2,
                          autoPlay: true,
                          looping: true,
                        ),
                      ):Container(child: Text("Hello"),)
                  ),
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }

  Widget get containerdash1 {
    return Center(
      child: DottedBorder(
        borderType: BorderType.Rect,
        dashPattern: [5, 5, 5, 5],
        color: Colors.grey[400],
        child: Container(
          height: 110,
          width: 100,
          decoration: ShapeDecoration(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            color: Color(0x22888888),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 32.0,
                  height: 32.0,
                  child: Icon(
                    Icons.add,
                    color: Colors.black54,
                    size: 25,
                  ),
                  decoration: new BoxDecoration(
                    // color: Colors.grey[300],
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(90.0)),
                    border: new Border.all(color: Colors.grey, width: 1),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Text("Front",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get containerdash2 {
    return Center(
      child: DottedBorder(
        borderType: BorderType.Rect,
        dashPattern: [5, 5, 5, 5],
        color: Colors.grey[400],
        child: Container(
          height: 110,
          width: 100,
          decoration: ShapeDecoration(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            color: Color(0x22888888),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 32.0,
                  height: 32.0,
                  child: Icon(
                    Icons.add,
                    color: Colors.black54,
                    size: 25,
                  ),
                  decoration: new BoxDecoration(
                    // color: Colors.grey[300],
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(90.0)),
                    border: new Border.all(color: Colors.grey, width: 1),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Text("Back",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get containerdash3 {
    return Center(
      child: DottedBorder(
        borderType: BorderType.Rect,
        dashPattern: [5, 5, 5, 5],
        color: Colors.grey[400],
        child: Container(
          height: 110,
          width: 100,
          decoration: ShapeDecoration(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            color: Color(0x22888888),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.video_call,
                  color: Colors.black54,
                  size: 28,
                ),
                Text("Tap to Record",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /*addVisitors() async {
    try {
      var api = "api/society/getFlatsOfSocietyWing";
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {


        FormData body_data = FormData.fromMap({

        });

        Services.apiHandler(apiName: api, body: body_data).then((data) {
          if (data.Data.length > 0) {
            setState(() {
              flatsList = data.Data;
            });
            print(flatsList);
          } else {
            Fluttertoast.showToast(
                msg: "Visitors not added successfully.",
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
  }*/

}

class MyDropDown1 extends StatefulWidget {
  String dropDownTitle;
  List dropDownData = [];
  Function onSelectValue;

  MyDropDown1({this.dropDownTitle, this.dropDownData, this.onSelectValue});

  @override
  _MyDropDown1State createState() => _MyDropDown1State();
}

class _MyDropDown1State extends State<MyDropDown1> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 15.0, bottom: 15, left: 20.0, right: 22),
            child: Row(
              children: [
                GestureDetector(
                    child: Icon(Icons.backspace_rounded,
                        size: 22, color: appPrimaryMaterialColor),
                    onTap: () {
                      Navigator.pop(context);
                    }),
                Expanded(
                  child: Center(
                    child: Text("${widget.dropDownTitle ?? ""}"),
                    /*Text("Select ${widget.dropDownTitle ?? ""}",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: appPrimaryMaterialColor)),*/
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 0.5,
            color: Colors.grey[400],
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: widget.dropDownData.length ?? 0,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    widget.onSelectValue(widget.dropDownData[index]);
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 12.0, left: 16, bottom: 12.0),
                    child: Text(widget.dropDownData[index],
                        style: TextStyle(fontSize: 15, color: Colors.black87)),
                  ),
                );
              }),
          SizedBox(
            height: 6,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 13),
            child: MyTextFormField(
              lable: "Other",
              validator: (val) {
                if (val.isEmpty) {
                  return "Please Enter type Visit Reason";
                }
                return "";
              },
              hintText: "Please type Visit Reason",
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2.7,
                height: 40,
                child: RaisedButton(
                    child: Text("Ok",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    color: appPrimaryMaterialColor,
                    onPressed: () {}),
              )),
        ],
      ),
    );
  }
}
