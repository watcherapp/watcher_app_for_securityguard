import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watcher_app_for_securityguard/Common/ClassList.dart';
import 'package:watcher_app_for_securityguard/Providers/BottomNavigationBarProvider.dart';

// ignore: must_be_immutable
class BottomNavigationBarWithFab extends StatefulWidget {
  List<BottomBarItem> items;
  Color selectedColor;
  Color unSelectedColor;
  NotchedShape notchedShape;
  double height;
  BottomNavigationBarWithFab(
      {@required this.items,
      this.selectedColor,
      this.unSelectedColor,
      this.height,
      this.notchedShape});
  @override
  _BottomNavigationBarWithFabState createState() =>
      _BottomNavigationBarWithFabState();
}

class _BottomNavigationBarWithFabState
    extends State<BottomNavigationBarWithFab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNavigationBarProvider>(context);
    return SizedBox(
      height: widget.height,
      child: BottomAppBar(
        child: Row(
            children: List.generate(widget.items.length, (index) {
          return Expanded(
            child: InkWell(
              onTap: () {
                provider.currentIndex = index;
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (provider.currentIndex != 2 &&
                      widget.items[index].imageIcon != null) ...[
                    Image.asset("${widget.items[index].imageIcon}", width: 45)
                  ] else ...[
                    Icon(widget.items[index].icon,
                        color: provider.currentIndex == index
                            ? widget.selectedColor
                            : widget.unSelectedColor),
                    Text(widget.items[index].title,
                        style: TextStyle(
                            fontSize: 11,
                            color: provider.currentIndex == index
                                ? widget.selectedColor
                                : widget.unSelectedColor,
                            fontWeight: FontWeight.bold)),
                  ]
                ],
              ),
            ),
          );
        })),
      ),
    );
  }
}
