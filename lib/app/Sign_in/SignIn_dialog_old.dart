import 'package:easy_lo/app/Sign_in/Bloc/sign_in_manger.dart';
import 'package:easy_lo/app/Sign_in/Email-SignIN/Email_sign_in_Form.dart';
import 'package:easy_lo/app/Sign_in/Function/social_sign_in_btn.dart';
import 'package:easy_lo/common/Platform_widget/platform_exception_alert_dialog.dart';
import 'package:easy_lo/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SignInDialog extends StatefulWidget {
  SignInDialog({@required this.manger, @required this.isLoading});

  final SignInManger manger;
  final ValueNotifier<bool> isLoading;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, isLoading, __) => Provider<SignInManger>(
          create: (_) => SignInManger(auth: auth, isLoading: isLoading),
          child: Consumer<SignInManger>(
            builder: (context, manger, _) => SignInDialog(
              manger: manger,
              isLoading: isLoading,
            ),
          ),
        ),
      ),
    );
  }

  @override
  _SignInDialogState createState() => _SignInDialogState();
}

class _SignInDialogState extends State<SignInDialog> {
  void _showSignInError(BuildContext context, PlatformException exception) {
    PlatformExceptionAlertDialog(
      title: 'Sign In Failed',
      exception: exception,
    ).show(context);
  }

  Future<void> _signGoogle(BuildContext context) async {
    try {
      await widget.manger.signGoogle();
    } on PlatformException catch (e) {
      if (e.code != 'User_Abort_Sign_in') {
        _showSignInError(context, e);
      }
    }
  }

  Future<void> _signFacebook(BuildContext context) async {
    try {
      await widget.manger.signFacebook();
    } on PlatformException catch (e) {
      if (e.code != 'User_Abort_Sign_in') {
        _showSignInError(context, e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: widget.isLoading.value
                      ? CircularProgressIndicator()
                      : Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Easy',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Lo ',
                                style: TextStyle(
                                  color: Color.fromRGBO(38, 161, 148, 1),
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
                EmailSignInForm.create(context, widget.isLoading),
                SizedBox(height: 48.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                        child: Divider(
                      height: 1,
                      color: Colors.black,
                    )),
                    Center(child: Text('  OR CONNECT WITH  ')),
                    Expanded(
                        child: Divider(
                      height: 1,
                      color: Colors.black,
                    )),
                  ],
                ),
                SizedBox(height: 16.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: SocialSignInBtn(
                          height: 40,
                          fontSize: 13,
                          borderRadius: 25,
                          icon: FaIcon(FontAwesomeIcons.facebookF,
                              color: Colors.white),
                          text: 'Facebook',
                          textColor: Colors.white,
                          color: Color(0xFF334D92),
                          onpress: widget.isLoading.value
                              ? null
                              : () => _signFacebook(context),
                        ),
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      Expanded(
                        child: SocialSignInBtn(
                          height: 40,
                          fontSize: 13,
                          borderRadius: 25,
                          icon: FaIcon(
                            FontAwesomeIcons.google,
                            color: Colors.white,
                          ),
                          text: 'Google',
                          textColor: Colors.white,
                          color: Color.fromRGBO(234, 67, 53, 1),
                          onpress: widget.isLoading.value
                              ? null
                              : () => _signGoogle(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
