import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_securityguard/Common/appColors.dart';
import 'package:watcher_app_for_securityguard/ui/CustomWidgets/DialogOpenFormField.dart';
import 'package:watcher_app_for_securityguard/ui/CustomWidgets/MyButton.dart';
import 'package:watcher_app_for_securityguard/ui/CustomWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_securityguard/ui/CustomWidgets/Popups/MyDropdown.dart';

import 'OTPScreen2.dart';

class AddVisitorScreen extends StatefulWidget {
  @override
  _AddVisitorScreenState createState() => _AddVisitorScreenState();
}

class _AddVisitorScreenState extends State<AddVisitorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
              onPressed: () {})),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 11.0, right: 11),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
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
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 7.0),
                        child: Column(
                          children: [
                            MyTextFormField(
                                lable: "First Name",
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Please Enter first name";
                                  }
                                  return "";
                                },
                                hintText: "Enter first name"),
                            MyTextFormField(
                                lable: "Last Name",
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Please Enter last name";
                                  }
                                  return "";
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
                  lable: "Mobile No",
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Please enter mobile number";
                    }
                    return "";
                  },
                  hintText: "Enter mobile number"),
              MyTextFormField(
                  lable: "Email   ( optional )",
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Please Enter email";
                    }
                    return "";
                  },
                  hintText: "Enter email"),
              /* Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text("",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    )),
              ),*/
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: DialogOpenFormField(
                    lable: "Select Wings & Flat",
                    //value: selectedCountry,
                    onTap: () {
                      // print("click");
                      FocusScope.of(context).unfocus();
                      showDialog(
                        context: context,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: MyDropDown(
                              dropDownTitle: "Select C",
                              //  dropDownData: country,
                              onSelectValue: (value) {
                                setState(() {
                                  //  selectedCountry = value;
                                });
                              }),
                        ),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: DialogOpenFormField(
                    lable: "Select Relation",
                    //value: selectedCountry,
                    onTap: () {
                      // print("click");
                      FocusScope.of(context).unfocus();
                      showDialog(
                        context: context,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: MyDropDown(
                              dropDownTitle: "Select C",
                              //  dropDownData: country,
                              onSelectValue: (value) {
                                setState(() {
                                  //  selectedCountry = value;
                                });
                              }),
                        ),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: DialogOpenFormField(
                    lable: "Visit Reason",
                    //value: selectedCountry,
                    onTap: () {
                      // print("click");
                      FocusScope.of(context).unfocus();
                      showDialog(
                        context: context,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: MyDropDown(
                              dropDownTitle: "Select C",
                              //  dropDownData: country,
                              onSelectValue: (value) {
                                setState(() {
                                  //  selectedCountry = value;
                                });
                              }),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 20,
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
                  containerdash1,
                  containerdash2,
                  containerdash3,
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
}
