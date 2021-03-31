import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Parking extends StatefulWidget {
  @override
  _ParkingState createState() => _ParkingState();
}

class _ParkingState extends State<Parking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      // icon: Icon(Icons.search),
                      suffixIcon: Icon(Icons.search),
                      labelText: 'Input Slot/Vehicle No',
                      fillColor: Colors.grey[200],
                      filled: true,
                      hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding: EdgeInsets.only(
                          left: 15, right: 8, top: 4, bottom: 4),
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
                  )),
              // Container(height: 6,),
              Container(
                height: MediaQuery.of(context).size.height-100,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      height: 150,
                      margin: EdgeInsets.only(
                          left: 20, right: 20, top: 7, bottom: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 3,
                              // spreadRadius: 5,
                              offset: Offset(3, 3),
                            )
                          ]),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(70))),
                          ),
                          Container(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name: ABC',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Wing No: 10',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                'Assigned Slots: ',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                '1  ',
                                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '1  ',
                                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '1  ',
                                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
