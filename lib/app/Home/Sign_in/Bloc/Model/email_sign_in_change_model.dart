
import 'package:easy_lo/app/Home/Sign_in/Function/validation.dart';
import 'package:easy_lo/services/auth.dart';
import 'package:flutter/foundation.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInChangeModel with EmailAndPassowrdValidator, ChangeNotifier {
  EmailSignInChangeModel({
    @required this.auth,
    this.submitted = false,
    this.isLoading = false,
    this.email = '',
    this.password = '',
    this.formType = EmailSignInFormType.signIn,
  });
  final AuthBase auth;
  bool submitted;
  bool isLoading;
  String email;
  String password;
  EmailSignInFormType formType;



  void updateWith({
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted,
  }) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.formType = formType ?? this.formType;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submitted ?? this.submitted;
    notifyListeners();
  }

  Future<void> submit() async {
    try {
      updateWith(submitted: true, isLoading: true);
      if (this.formType == EmailSignInFormType.signIn) {
        await auth.signWithEmail(this.email, this.password);
      } else {
        await auth.createWithEmail(this.email, this.password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  bool get canSubmitted {
    return emailValidator.isValid(email) &&
        passwordValidator.isValid(password) &&
        !this.isLoading;
  }

  String get primaryText => this.formType == EmailSignInFormType.signIn
      ? 'Sign In'
      : 'Create an account';

  String get secondryText => this.formType == EmailSignInFormType.signIn
      ? 'Need an account? Register'
      : 'Have an account? Sign in';

  //email/password in valid text
  String get passwordErrorText {
    bool passwordValid = !(submitted && !(passwordValidator.isValid(password)));
    return passwordValid ? null : invalidPasswordText;
  }

  String get emailErrorText {
    bool emailValid = !(submitted && !(passwordValidator.isValid(email)));
    return emailValid ? null : invalidEmailText;
  }


  void toggleForm() {
    final formTypes = this.formType == EmailSignInFormType.signIn
        ? EmailSignInFormType.register
        : EmailSignInFormType.signIn;
    updateWith(email: '', password: '', submitted: false, formType: formTypes);
  }

  void updateEmail(String email) => updateWith(email: email);
  void updatePassword(String password) => updateWith(password: password);
}
