import 'package:easy_lo/app/Sign_in/Bloc/Model/email_sign_in_change_model.dart';
import 'package:easy_lo/common/CustomRaisedBtn.dart';
import 'package:easy_lo/common/Platform_widget/platform_exception_alert_dialog.dart';
import 'package:easy_lo/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EmailSignInForm extends StatefulWidget {
  EmailSignInForm({@required this.model});
  final EmailSignInChangeModel model;

  static Widget create(BuildContext context, ValueNotifier<bool> isLoading) {
    print(isLoading);
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<EmailSignInChangeModel>(
      create: (context) =>
          EmailSignInChangeModel(auth: auth, isLoading: isLoading),
      child: Consumer<EmailSignInChangeModel>(
        builder: (context, model, _) {
          return EmailSignInForm(model: model);
        },
      ),
    );
  }

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final TextEditingController _nameTextfieldController =
      TextEditingController();
  final TextEditingController _emailTextfieldController =
      TextEditingController();
  final TextEditingController _passwordTextfieldController =
      TextEditingController();

  @override
  void dispose() {
    _nameTextfieldController.dispose();
    _emailTextfieldController.dispose();
    _passwordTextfieldController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();

    super.dispose();
  }

  Future<void> _submit() async {
    try {
      await widget.model.submit();
    } catch (e) {
      print(e);
      PlatformExceptionAlertDialog(
        title: 'Sign in Failed',
        exception: PlatformException(code: e.code, message: e.message),
      ).show(context);
    }
  }

  void _nameEditingComplete() {
    FocusScope.of(context).requestFocus(_emailFocusNode);
  }

  void _emailEditingComplete() {
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  void _toggleForm() {
    widget.model.toggleForm();
    _nameTextfieldController.clear();
    _emailTextfieldController.clear();
    _passwordTextfieldController.clear();
  }

  List<Widget> _buildChildern() {
    return [
      if (widget.model.formType == EmailSignInFormType.register) ...[
        _buildNameTextField(),
      ],
      _buildEmailTextField(),
      SizedBox(height: 8.0),
      _buildPasswordTextField(),
      SizedBox(height: 32.0),
      CustomRaisedBtn(
        borderRadius: 25,
        child: Text(
          widget.model.primaryText,
          style: TextStyle(
              color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
        color: Colors.black87,
        onpress: widget.model.canSubmitted ? _submit : null,
      ),
      SizedBox(height: 8.0),
      FlatButton(
        child: Text(widget.model.secondryText),
        onPressed: widget.model.isLoading.value ? null : _toggleForm,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: _buildChildern(),
          ),
        ),
      ),
    );
  }

  TextField _buildNameTextField() {
    return TextField(
      controller: _nameTextfieldController,
      decoration: InputDecoration(
        labelText: 'Name',
        errorText: widget.model.nameErrorText,
        enabled: widget.model.isLoading.value == false,
      ),
      focusNode: _nameFocusNode,
      textInputAction: TextInputAction.next,
      onEditingComplete: _nameEditingComplete,
      onChanged: widget.model.updateName,
    );
  }

  TextField _buildEmailTextField() {
    return TextField(
      controller: _emailTextfieldController,
      decoration: InputDecoration(
        labelText: 'Email',
        errorText: widget.model.emailErrorText,
        enabled: widget.model.isLoading.value == false,
      ),
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
        enabled: widget.model.isLoading.value == false,
      ),
      textInputAction: TextInputAction.done,
      focusNode: _passwordFocusNode,
      obscureText: true,
      onEditingComplete: _submit,
      onChanged: widget.model.updatePassword,
    );
  }
}
