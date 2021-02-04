import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialSignInBtn extends StatelessWidget {
  SocialSignInBtn({
    this.icon,
    this.text,
    this.color: Colors.white,
    this.borderRadius: 2.0,
    this.onpress,
    this.height: 50.0,
    this.textColor,
    this.fontSize = 15.0,
    this.padding = 0,
  }) : assert(borderRadius != null);

  final double fontSize;
  final FaIcon icon;
  final String text;
  final Color textColor;
  final Color color;
  final double borderRadius;
  final VoidCallback onpress;
  final double height;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: RaisedButton.icon(
          padding: EdgeInsets.symmetric(horizontal: padding),
          icon: icon,
          label: Text(
            text,
            style: TextStyle(color: textColor, fontSize: fontSize),
          ),
          color: color,
          disabledColor: color,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
          onPressed: onpress),
    );
  }
}
