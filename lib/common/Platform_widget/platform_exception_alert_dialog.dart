import 'package:easy_lo/common/Platform_widget/platform_alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class PlatformExceptionAlertDialog extends PlatformAlertDialog {
  PlatformExceptionAlertDialog({
    @required String title,
    @required PlatformException exception,
    String defaultActionText = 'OK',
  }) : super(
          title: title,
          content: _message(exception),
          defaultActionText: defaultActionText,
        );
  static String _message(PlatformException exception) {
    return _errors[exception.code] ?? exception.message;
  }

  static Map<String, String> _errors = {
    //email sign in
    'user-disabled': 'Email has been disabled.',
    'user-not-found': 'Incorrect Email',
    'wrong-password': 'Email/Password wrong',

    //create
    'email-already-in-use': 'This Email is taken. Try another',
    'invalid-email': 'Email address is not valid.',
    'weak-password': 'Password is not strong enough',

    'operation-not-allowed': 'Performing ristrited action',

    //database exception
    'permission-denied':'Missing or insufficient permissions'
  };
}
