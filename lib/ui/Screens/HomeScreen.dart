import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watcher_app_for_securityguard/Common/ClassList.dart';
import 'package:watcher_app_for_securityguard/Common/appColors.dart';
import 'package:watcher_app_for_securityguard/CommonWidgets/BottomNavigationBarWithFab.dart';
import 'package:watcher_app_for_securityguard/Providers/BottomNavigationBarProvider.dart';
import 'package:watcher_app_for_securityguard/ui/Screens/Tabs/ParkingDetail.dart';
import 'package:watcher_app_for_securityguard/ui/Screens/Tabs/Verification.dart';
import 'package:watcher_app_for_securityguard/ui/Screens/Tabs/Visitorlist.dart';

import 'Tabs/Emergency.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  var watchmen_name="";

  GetWatchmanInfo() async{
    final login_pref = await SharedPreferences.getInstance();
    setState(() {
      watchmen_name = login_pref.getString("firstName") + " " + login_pref.getString("lastName") ;
    });
    print(watchmen_name);
  }

  List<Widget> _widgetOptions = <Widget>[
    VisitorList(),
    ParkingDetail(),
    Verification(),
    Emergency(),
    VisitorList(),
  ];
  List<Widget> tabs = [
    Tab(
      text: 'Verification',
    ),
    Tab(
      text: 'Visitorlist',
    ),
    Tab(
      text: 'Parking Detail',
    ),
    Tab(
      text: 'Emergency',
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetWatchmanInfo();
  }
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNavigationBarProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0.5,
        centerTitle: true,
        title: Text(
          "Hey, "+ watchmen_name,
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () {})
        ],
      ),
      body: _widgetOptions[provider.currentIndex],
      bottomNavigationBar: BottomNavigationBarWithFab(
        notchedShape: CircularNotchedRectangle(),
        height: 56,
        selectedColor: appPrimaryMaterialColor,
        unSelectedColor: Colors.grey,
        items: [
          BottomBarItem(icon: CupertinoIcons.profile_circled, title: "Visitor"),
          BottomBarItem(icon: CupertinoIcons.car_detailed, title: "Parking"),
          BottomBarItem(
              icon: CupertinoIcons.home,
              title: "Home",
              imageIcon: "images/Watcherlogo.png"),
          BottomBarItem(icon: CupertinoIcons.phone, title: "Emergency"),
          BottomBarItem(icon: CupertinoIcons.add, title: "More"),
        ],
      ),
    );
  }
}
