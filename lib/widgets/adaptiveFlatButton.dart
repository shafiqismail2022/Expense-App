// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String text;
  final VoidCallback datePicker;
  // final Function dateHandler;
  AdaptiveFlatButton(this.text, this.datePicker);
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: datePicker,
            // onPressed: () {
            //   dateHandler;
            // },
          )
        : FlatButton(
            textColor: Theme.of(context).primaryColor,
            onPressed: datePicker,
            // onPressed: () {
            //   dateHandler;
            // },
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}
