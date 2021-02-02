import 'package:flutter/material.dart';
import 'package:watcher_app_for_securityguard/Common/appColors.dart';
import 'package:watcher_app_for_securityguard/ui/Screens/Tabs/Emergency.dart';
import 'package:watcher_app_for_securityguard/ui/Screens/Tabs/ParkingDetail.dart';
import 'package:watcher_app_for_securityguard/ui/Screens/Tabs/Verification.dart';
import 'package:watcher_app_for_securityguard/ui/Screens/Tabs/Visitorlist.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
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
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0.5,
          centerTitle: true,
          title: Text(
            "Hey, Megha",
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
        body: Column(
          children: [
            /* SizedBox(
              height: 40,
            ),*/
            TabBar(
                isScrollable: true,
                controller: _tabController,
                unselectedLabelColor: Colors.grey,
                labelColor: appPrimaryMaterialColor[900],
                indicatorColor: appPrimaryMaterialColor[700],
                indicatorWeight: 2,
                onTap: (index) {},
                tabs: tabs),
            Expanded(
              child: TabBarView(physics: BouncingScrollPhysics(), children: [
                Verification(),
                ParkingDetail(),
                Emergency(),
                Visitorlist(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
