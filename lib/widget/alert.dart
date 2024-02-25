import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, text) {
  Widget okButton = ElevatedButton(
    child: Text("OK"),
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0x0000000d),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("Alert"),
    content: Text(text),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}