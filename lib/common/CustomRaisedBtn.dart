import 'package:flutter/material.dart';

class CustomRaisedBtn extends StatelessWidget {
  CustomRaisedBtn({
    this.child,
    this.color: Colors.white,
    this.borderRadius: 2.0,
    this.onpress,
    this.height: 50.0,
  }) : assert(borderRadius != null);

  final Widget child;
  final Color color;
  final double borderRadius;
  final VoidCallback onpress;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: RaisedButton(
          child: child,
          color: color,
          disabledColor: color,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
          onPressed: onpress),
    );
  }
}
