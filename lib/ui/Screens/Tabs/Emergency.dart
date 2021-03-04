import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:watcher_app_for_securityguard/ui/CustomWidgets/DialogOpenFormField.dart';
import 'package:watcher_app_for_securityguard/ui/CustomWidgets/MyDropdown.dart';

import '../../../Common/appColors.dart';
import '../../CustomWidgets/MyButton.dart';
import '../../CustomWidgets/MyTextFormField.dart';

class Emergency extends StatefulWidget {
  @override
  _EmergencyState createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> {
  Size _screenSize;
  TextEditingController typeController = TextEditingController();

  String wingName;

  List dataList = [
    {
      "lable": "Ambulance",
      "img": "images/Emergency/ambulance.png",
    },
    {
      "lable": "Fire",
      "img": "images/Emergency/fire-truck.png",
    },
    {
      "lable": "Police",
      "img": "images/Emergency/policeman.png",
    },
    {
      "lable": "Hospital",
      "img": "images/Emergency/hospital.png",
    },
  ];
  List EmergencyList = [
    {
      "lable": "Fire",
    },
    {
      "lable": "Thief",
    },
    {
      "lable": "Other",
    },
  ];
  List wingList = [
    "A",
    "B",
    "C",
    "D",
  ];

  void launchUrl(String url) async {
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw "Could not launch $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text("In Case of Emergency Call",
                  style: TextStyle(
                    color: appPrimaryMaterialColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  )),
              SizedBox(
                height: 15,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: dataList.map((data) {
                  return Padding(
                    padding: EdgeInsets.only(left: 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          child: Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(2),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    child: Image(
                                      image: AssetImage(
                                        data["img"],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    data["lable"],
                                    style: TextStyle(
                                        color: appPrimaryMaterialColor,
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            print(data["lable"]);
                            launchUrl("tel:9879208321");
                          },
                        )
                      ],
                    ),
                  );
                }).toList()),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text("Note: Call or Data rates may apply",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                    )),
              ),
              SizedBox(
                height: 15,
              ),
              Divider(
                color: Colors.grey,
                height: 1,
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3.0, right: 3),
                child: Text(
                  "Send SOS",
                  style: TextStyle(
                    color: appPrimaryMaterialColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3.0, right: 3),
                child: DialogOpenFormField(
                    lable: "Select Wing",
                    hintLable: "Wing Name",
                    value: wingName,
                    onTap: () {
                      print("click");
                      FocusScope.of(context).unfocus();
                      showDialog(
                        context: context,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: MyDropDown(
                              isSearchable: false,
                              dropDownTitle: "Select Relation",
                              dropDownData: wingList,
                              onSelectValue: (value) {
                                setState(() {
                                  wingName = value;
                                });
                              }),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3.0, right: 3),
                child: Text(
                  "Type of Emergency",
                  style: TextStyle(
                    color: Colors.grey[10],
                    // fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              SizedBox(
                height: 13,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: EmergencyList.map((data) {
                  return InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        // color: Colors.grey[700],
                        border: Border.all(
                          color: Colors.grey[700],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(35, 15, 35, 15),
                        child: Text(
                          data["lable"],
                        ),
                      ),
                    ),
                    onTap: () {
                      print(data["lable"]);
                    },
                  );
                  // return OutlineButton(
                  //   color: Colors.yellow,
                  //   child: Padding(
                  //     padding: const EdgeInsets.fromLTRB(23, 15, 23, 15),
                  //     child: new Text(data["lable"]),
                  //   ),
                  //   onPressed: () {},
                  //   shape: new RoundedRectangleBorder(
                  //     borderRadius: new BorderRadius.circular(8),
                  //   ),
                  // );
                }).toList(),
              ),
              SizedBox(
                height: 18,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3.0, right: 3),
                child: MyTextFormField(
                  lable: "Type Emergency",
                  controller: typeController,
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Please Enter type of Emergency";
                    }
                    return "";
                  },
                  hintText: "Type Emergency",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3.0, right: 3),
                child: MyTextFormField(
                  lable: "Suggest an Response",
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Please Enter relevent Response";
                    }
                    return "";
                  },
                  hintText: "Stay Calm and Indoors",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 11.0, right: 11),
                child: MyButton(title: "Raise an SOS", onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          ShowDialog());
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShowDialog extends StatefulWidget {
  @override
  _ShowDialogState createState() => _ShowDialogState();
}

class _ShowDialogState extends State<ShowDialog> {
  List dialogList = [
    {
      "lable": "Physically Misbehavior",
    },
    {
      "lable": "Verbal Misbehavior",
    },
    {
      "lable": "Threten on me",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Confirm to Raise SOS',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
            ),
            SizedBox(
              width: 5,
            ),
            Icon(
              Icons.report,
              size: 33,
              color: Colors.red,
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "You may be charged for raising a false alarm. Confirm it?",
              style: TextStyle(
                height: 1.5,
                color: appPrimaryMaterialColor,
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RaisedButton(
                    child: Text("Cancel",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            )),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    color: Colors.red[400].withOpacity(0.9),
                    onPressed: () {
                      Navigator.pop(context);
                      print("Cancel");
                    }),
                RaisedButton(
                    child: Text("Raise",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            )),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    color: Colors.green[400],
                    onPressed: () {
                      Navigator.pop(context);
                      print("Raise");
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
