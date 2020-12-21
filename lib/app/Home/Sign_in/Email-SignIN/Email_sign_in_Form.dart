
import 'package:easy_lo/app/Home/Sign_in/Bloc/Model/email_sign_in_change_model.dart';
import 'package:easy_lo/app/Home/Sign_in/Function/form_submit_btn.dart';
import 'package:easy_lo/common/Platform_widget/platform_exception_alert_dialog.dart';
import 'package:easy_lo/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

//change notifier
class EmailSignInForm extends StatefulWidget {
  EmailSignInForm({@required this.model});
  final EmailSignInChangeModel model;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<EmailSignInChangeModel>(
      create: (context) => EmailSignInChangeModel(auth: auth),
      child: Consumer<EmailSignInChangeModel>(
        builder: (context, model, _) => EmailSignInForm(model: model),
      ),
    );
  }

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final TextEditingController _emailTextfieldController = TextEditingController();
  final TextEditingController _passwordTextfieldController = TextEditingController();

  @override
  void dispose() {
    _emailTextfieldController.dispose();
    _passwordTextfieldController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();

    super.dispose();
  }

  Future<void> _submit() async {
    try {
      await widget.model.submit();
      Navigator.of(context).pop();
    } catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Sign in Failed',
        exception: PlatformException(code: e.code, message: e.message),
      ).show(context);
    }
  }

  void _emailEditingComplete() {
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  void _toggleForm() {
    widget.model.toggleForm();
    _emailTextfieldController.clear();
    _passwordTextfieldController.clear();
  }

  List<Widget> _buildChildern() {
    return [
      _buildEmailTextField(),
      SizedBox(height: 8.0),
      _buildPasswordTextField(),
      SizedBox(height: 8.0),
      FormSubmitBtn(
        text: widget.model.primaryText,
        onPressed: widget.model.canSubmitted ? _submit : null,
      ),
      SizedBox(height: 8.0),
      FlatButton(
        child: Text(widget.model.secondryText),
        onPressed: widget.model.isLoading ? null : _toggleForm,
      ),
    ];
  }

  TextField _buildEmailTextField() {
    return TextField(
      controller: _emailTextfieldController,
      decoration: InputDecoration(
        labelText: 'Email',
        errorText: widget.model.emailErrorText,
        enabled: widget.model.isLoading == false,
      ),
      autofocus: true,
      keyboardType: TextInputType.emailAddress,
      focusNode: _emailFocusNode,
      textInputAction: TextInputAction.next,
      onEditingComplete: _emailEditingComplete,
      onChanged: widget.model.updateEmail,
    );
  }

  TextField _buildPasswordTextField() {
    return TextField(
      controller: _passwordTextfieldController,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: widget.model.passwordErrorText,
        enabled: widget.model.isLoading == false,
      ),
      textInputAction: TextInputAction.done,
      focusNode: _passwordFocusNode,
      obscureText: true,
      onEditingComplete: _submit,
      onChanged: widget.model.updatePassword,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildern(),
      ),
    );
  }
}
