import 'package:flutter/material.dart';
import 'package:watcher_app_for_securityguard/Common/appColors.dart';
import 'package:watcher_app_for_securityguard/ui/CustomWidgets/MyButton.dart';

class PopUp extends StatefulWidget {
  String titleText;
  String messageText;
  PopUp({
    this.titleText,
    this.messageText,
  });
  @override
  _PopUpState createState() => _PopUpState();
}

class _PopUpState extends State<PopUp> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.titleText,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: appPrimaryMaterialColor),
      ),
      actions: [],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.messageText,
          ),
          MyButton(
            title: "Ok",
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
