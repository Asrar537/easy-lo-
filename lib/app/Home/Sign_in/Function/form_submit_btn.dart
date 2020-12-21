import 'package:easy_lo/common/CustomRaisedBtn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class FormSubmitBtn extends CustomRaisedBtn {
  FormSubmitBtn({
    @required String text,
    VoidCallback onPressed,
  }) : super(
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          height: 44.0,
          color: Colors.indigo,
          borderRadius: 4.0,
          onpress: onPressed,
        );
}
