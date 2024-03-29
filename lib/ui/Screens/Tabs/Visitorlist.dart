import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watcher_app_for_securityguard/Common/Services.dart';
import 'package:watcher_app_for_securityguard/Common/appColors.dart';
import 'package:watcher_app_for_securityguard/ui/Screens/Tabs/AllVisitorsList.dart';
import 'package:watcher_app_for_securityguard/ui/Screens/Tabs/TodayVisitorsList.dart';

import '../../CustomWidgets/MyTextFormField.dart';

class VisitorList extends StatefulWidget {
  @override
  _VisitorListState createState() => _VisitorListState();
}

class _VisitorListState extends State<VisitorList> {
  // List status = ["ALL", "TODAY", "IN", "OUT"];
  bool isLoading = false;
  bool isempty = false;
  List allVisitorList = [];
  TabController _tabController1;
  List<Widget> status1 = [
    Tab(
      text: 'ALL',
    ),
    Tab(
      text: 'TODAY',
    ),
    Tab(
      text: 'IN',
    ),
    Tab(
      text: 'OUT',
    ),
  ];

  //List status1 = ["ALL","TODAY","IN","OUT"];


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
  void initState() {
    // TODO: implement initState
    super.initState();
    //GetAllVisitors();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: status1.length,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 4),
              child: Container(
                height: 35,
                child: TabBar(
                    isScrollable: false,
                    controller: _tabController1,
                    unselectedLabelColor: Colors.black,
                    labelColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: appPrimaryMaterialColor,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: appPrimaryMaterialColor[800]),
                    indicatorWeight: 1,
                    onTap: (index) {
                      //print(index);
                      if(index == 0){
                        print(index);
                        //GetAllVisitors();
                      }
                    },
                    tabs: status1),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4, top: 4),
                child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      /*ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: 4,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      width: 57.0,
                                      height: 57.0,
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 49,
                                      ),
                                      decoration: new BoxDecoration(
                                        color: Color(0x22888888),
                                        borderRadius: new BorderRadius.all(
                                            new Radius.circular(90.0)),
                                        border: new Border.all(
                                          color: Colors.grey,
                                          width: 0.5,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Text("Akshay",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  fontFamily: 'WorkSans Bold')),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5.0),
                                          child: Text("B 105",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontFamily: 'WorkSans Bold',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15,
                                              )),
                                        ),
                                      ],
                                    ),
                                    true == false
                                        ? Container(
                                            width: 40.0,
                                            height: 40.0,
                                            child: Center(
                                              child: Text(
                                                "Allowed",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'WorkSans Bold',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),
                                            decoration: new BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: new BorderRadius
                                                      .all(
                                                  new Radius.circular(90.0)),
                                            ),
                                          )
                                        : Container(
                                            width: 40.0,
                                            height: 40.0,
                                            child: Center(
                                              child: Text(
                                                "Denied",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'WorkSans Bold',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),
                                            decoration: new BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: new BorderRadius
                                                      .all(
                                                  new Radius.circular(90.0)),
                                            ),
                                          ),
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                ShowDialog());
                                      },
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.report,
                                            size: 33,
                                            color: Colors.black45,
                                          ),
                                          Text(
                                            "Report",
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontFamily: 'WorkSans Bold',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),*/
                      AllVisitorsList(),
                      TodayVisitorsList(),
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: 4,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      width: 57.0,
                                      height: 57.0,
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 49,
                                      ),
                                      decoration: new BoxDecoration(
                                        color: Color(0x22888888),
                                        borderRadius: new BorderRadius.all(
                                            new Radius.circular(90.0)),
                                        border: new Border.all(
                                          color: Colors.grey,
                                          width: 0.5,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Text("Aksha Patel",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  fontFamily: 'WorkSans Bold')),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5.0),
                                          child: Text("B-105",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontFamily: 'WorkSans Bold',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15,
                                              )),
                                        ),
                                      ],
                                    ),
                                    true == false
                                        ? Container(
                                      width: 40.0,
                                      height: 40.0,
                                      child: Center(
                                        child: Text(
                                          "Allowed",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'WorkSans Bold',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                      decoration: new BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: new BorderRadius
                                            .all(
                                            new Radius.circular(90.0)),
                                      ),
                                    )
                                        : Container(
                                      width: 40.0,
                                      height: 40.0,
                                      child: Center(
                                        child: Text(
                                          "Denied",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'WorkSans Bold',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                      decoration: new BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: new BorderRadius
                                            .all(
                                            new Radius.circular(90.0)),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                ShowDialog());
                                      },
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.report,
                                            size: 33,
                                            color: Colors.black45,
                                          ),
                                          Text("Report",
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontFamily: 'WorkSans Bold',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                              ))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: 4,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      width: 57.0,
                                      height: 57.0,
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 49,
                                      ),
                                      decoration: new BoxDecoration(
                                        color: Color(0x22888888),
                                        borderRadius: new BorderRadius.all(
                                            new Radius.circular(90.0)),
                                        border: new Border.all(
                                          color: Colors.grey,
                                          width: 0.5,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Text("Aksha Patel",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  fontFamily: 'WorkSans Bold')),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5.0),
                                          child: Text("B-105",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontFamily: 'WorkSans Bold',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15,
                                              )),
                                        ),
                                      ],
                                    ),
                                    true == true
                                        ? Container(
                                      width: 40.0,
                                      height: 40.0,
                                      child: Center(
                                        child: Text(
                                          "Allowed",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'WorkSans Bold',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                      decoration: new BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: new BorderRadius
                                            .all(
                                            new Radius.circular(90.0)),
                                      ),
                                    )
                                        : Container(
                                      width: 40.0,
                                      height: 40.0,
                                      child: Center(
                                        child: Text(
                                          "Denied",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'WorkSans Bold',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                      decoration: new BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: new BorderRadius
                                            .all(
                                            new Radius.circular(90.0)),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                ShowDialog());
                                      },
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.report,
                                            size: 33,
                                            color: Colors.black45,
                                          ),
                                          Text("Report",
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontFamily: 'WorkSans Bold',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                              ))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          })
                    ]),
              ),
            ),
          ],
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
        title: Center(
          child: Text(
            'Select Report Type',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: dialogList.map((data) {
                return Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(
                          color: Colors.grey,
                          height: 0.5,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          data["lable"],
                          style: TextStyle(
                            color: appPrimaryMaterialColor,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ],
                );
                print(data["lable"]);
              }).toList(),
            ),
            Column(
              children: [
                MyTextFormField(
                  lable: "Other",
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Please Enter type Report Reason";
                    }
                    return "";
                  },
                  hintText: "Please type Report Reason",
                ),
                Padding(
                    padding:
                        const EdgeInsets.only(right: 50, left: 50, top: 30),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: RaisedButton(
                          child: Text("Report",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          color: appPrimaryMaterialColor,
                          onPressed: () {}),
                    )),
                /*MyButton(title: "Report", onPressed: () {}),*/
              ],
            ),
          ],
        ),
      ),
    );
  }
}
