import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watcher_app_for_securityguard/Common/Services.dart';
import 'package:watcher_app_for_securityguard/ui/Screens/Tabs/Visitorlist.dart';


class TodayVisitorsList extends StatefulWidget {
  @override
  _TodayVisitorsListState createState() => _TodayVisitorsListState();
}

class _TodayVisitorsListState extends State<TodayVisitorsList> {
  List allVisitorList = [];
  bool isLoading = false;
  bool isempty = false;

  GetAllVisitors()async{
    try {
      var api = "api/staff/getAllEntryOfVisitor";
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {

        var now = new DateTime.now();
        print(now.day.toString() +"/"+ now.month.toString() +"/"+ now.year.toString());



        var body_data = {
          "toDate" : "22/03/2021",
        };
        Services.apiHandler(apiName: api, body: body_data).then((data) {
          if (data.Data.length > 0) {
            //proofname = data.Data;
            setState(() {
              allVisitorList = data.Data;
            });

            print(allVisitorList);

            print(allVisitorList[0]['guestName']);
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetAllVisitors();
  }

  @override
  Widget build(BuildContext context) {

    return allVisitorList.length > 0 ?ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: allVisitorList.length,
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
                        child: Text("${allVisitorList[index]['visitorName']??"- -"}",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                fontFamily: 'WorkSans Bold')),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(top: 5.0),
                        child: Text("${allVisitorList[index]['wingName']+" "??"- -"+ allVisitorList[index]['flatName']??"- -"}",
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
        }):Center(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.indigo),
        )
    );
  }
}