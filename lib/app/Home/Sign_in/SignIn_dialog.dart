import 'package:easy_lo/app/Home/Sign_in/Bloc/sign_in_manger.dart';
import 'package:easy_lo/app/Home/Sign_in/Email-SignIN/email_sign_in.dart';
import 'package:easy_lo/app/Home/Sign_in/Function/form_submit_btn.dart';
import 'package:easy_lo/app/Home/Sign_in/Function/sign_in_btn.dart';
import 'package:easy_lo/app/Home/Sign_in/Function/social_sign_in_btn.dart';
import 'package:easy_lo/common/CustomRaisedBtn.dart';
import 'package:easy_lo/common/Platform_widget/platform_exception_alert_dialog.dart';
import 'package:easy_lo/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SignInDialog extends StatelessWidget {
  SignInDialog({@required this.manger, @required this.isLoading});

  final SignInManger manger;
  final bool isLoading;
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final TextEditingController _emailTextfieldController = TextEditingController();
  final TextEditingController _passwordTextfieldController = TextEditingController();

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
              isLoading: isLoading.value,
            ),
          ),
        ),
      ),
    );
  }

  void _showSignInError(BuildContext context, PlatformException exception) {
    PlatformExceptionAlertDialog(
      title: 'Sign In Failed',
      exception: exception,
    ).show(context);
  }

  Future<void> _signAnonymus(BuildContext context) async {
    try {
      await manger.signAnonymus();
    } catch (e) {
      _showSignInError(
          context, PlatformException(code: e.code, message: e.message));
    }
  }

  Future<void> _signGoogle(BuildContext context) async {
    try {
      await manger.signGoogle();
    } on PlatformException catch (e) {
      if (e.code != 'User_Abort_Sign_in') {
        _showSignInError(context, e);
      }
    }
  }

  Future<void> _signFacebook(BuildContext context) async {
    try {
      await manger.signFacebook();
    } on PlatformException catch (e) {
      if (e.code != 'User_Abort_Sign_in') {
        _showSignInError(context, e);
      }
    }
  }

  void _signEmail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (context) => EmailSignIn(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Dialog(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Expanded(
                      child: Center(
                          child: Text(
                    'Easy Lo',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ))),
                  SizedBox(
                    width: 48,
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildEmailTextField(),
                    SizedBox(height: 8.0),
                    _buildPasswordTextField(),
                    SizedBox(height: 32.0),
                    CustomRaisedBtn(
                      borderRadius: 25,
                      child: Text(
                        'Sign In',//widget.model.primaryText,
                        style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                      color: Colors.black87,
                      onpress: isLoading ? null : () => _signEmail(context),//widget.model.canSubmitted ? _submit : null,
                    ),
                    SizedBox(height: 8.0),
                    FlatButton(
                      child: Text('widget.model.secondryText'),
                      onPressed: () {},//widget.model.isLoading ? null : _toggleForm, isLoading ? null : () => _signEmail(context),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(child: Divider(height: 1, color: Colors.black,)),
                    Center(child: Text('  OR CONNECT WITH  ')),
                    Expanded(child: Divider(height: 1, color: Colors.black,)),
                  ],
                ),
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialSignInBtn(
                    height: 40,
                    fontSize: 13,
                    borderRadius: 25,
                    icon: FaIcon(FontAwesomeIcons.facebookF, color: Colors.white),
                    text: 'Facebook',
                    textColor: Colors.white,
                    color: Color(0xFF334D92),
                    onpress: isLoading ? null : () => _signFacebook(context),
                  ),
                  SizedBox(width: 16.0,),
                  SocialSignInBtn(
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
                    onpress: isLoading ? null : () => _signGoogle(context),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              SignInBtn(
                text: 'Anynomus',
                textColor: Colors.black87,
                color: Colors.white,
                onpress: isLoading ? null : () => _signAnonymus(context),
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  TextField _buildEmailTextField() {
    return TextField(
      //controller: _emailTextfieldController,
      decoration: InputDecoration(
        labelText: 'Email',
        //errorText: widget.model.emailErrorText,
        //enabled: widget.model.isLoading == false,
      ),
      keyboardType: TextInputType.emailAddress,
      //focusNode: _emailFocusNode,
      textInputAction: TextInputAction.next,
      //onEditingComplete: _emailEditingComplete,
      //onChanged: widget.model.updateEmail,
    );
  }

  TextField _buildPasswordTextField() {
    return TextField(
      //ontroller: _passwordTextfieldController,
      decoration: InputDecoration(
        labelText: 'Password',
        //errorText: widget.model.passwordErrorText,
        //enabled: widget.model.isLoading == false,
      ),
      textInputAction: TextInputAction.done,
      //focusNode: _passwordFocusNode,
      obscureText: true,
      //onEditingComplete: _submit,
      //onChanged: widget.model.updatePassword,
    );
  }
}
