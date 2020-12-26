import 'package:easy_lo/common/CustomRaisedBtn.dart';
import 'package:flutter/material.dart';

class SignInBtn extends CustomRaisedBtn {
  SignInBtn({
    @required String text,
    Color textColor,
    Color color,
    double borderRadius: 2.0,
    VoidCallback onpress,
  })  : assert(text != null),
        super(
            child: Text(
              text,
              style: TextStyle(color: textColor, fontSize: 15.0),
            ),
            color: color,
            borderRadius: borderRadius,
            onpress: onpress);
}