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
        body: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Flexible(
              child: TabBar(
                  isScrollable: true,
                  controller: _tabController,
                  unselectedLabelColor: Colors.grey,
                  labelColor: appPrimaryMaterialColor[900],
                  indicatorColor: appPrimaryMaterialColor,
                  indicatorWeight: 2,
                  onTap: (index) {},
                  tabs: tabs),
            ),
            Flexible(
              child: TabBarView(
                  physics: BouncingScrollPhysics(),
                  controller: _tabController,
                  children: [
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
