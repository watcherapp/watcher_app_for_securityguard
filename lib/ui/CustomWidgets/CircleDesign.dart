import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_securityguard/Common/fontStyles.dart';
import 'package:watcher_app_for_securityguard/Shapes/CircleShape.dart';

class CircleDesign extends StatelessWidget {
  String title;
  bool backicon = false;
  CircleDesign({this.title, this.backicon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Stack(fit: StackFit.expand, children: [
        if (backicon == true) ...[
          Positioned(
              top: 40,
              left: 10,
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 23,
                  ),
                  onPressed: () {
                    Navigator.pop(
                        context,
                        PageTransition(
                            type: PageTransitionType.bottomToTop, child: null));
                  })),
        ],
        Positioned(
            bottom: 40,
            left: 20,
            top: 5,
            child: Text("${title ?? ""}", style: fontConstants.bigTitleWhite)),
        Positioned(
            right: 20,
            top: 6,
            child: Opacity(
                opacity: 0.1, child: CustomPaint(painter: DrawCircle()))),
        Positioned(
            right: -40,
            bottom: 25,
            child: Opacity(
                opacity: 0.1, child: CustomPaint(painter: DrawCircle()))),
      ]),
    );
  }
}
