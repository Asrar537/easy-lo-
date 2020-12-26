import 'package:easy_lo/app/Sign_in/Function/validation.dart';
import 'package:easy_lo/services/auth.dart';
import 'package:flutter/foundation.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInChangeModel with EmailAndPassowrdValidator, ChangeNotifier {
  EmailSignInChangeModel({
    @required this.auth,
    this.submitted = false,
    this.isLoading,
    this.name = '',
    this.email = '',
    this.password = '',
    this.formType = EmailSignInFormType.signIn,
  });
  final AuthBase auth;
  bool submitted;
  ValueNotifier<bool> isLoading;
  String name;
  String email;
  String password;
  EmailSignInFormType formType;



  void updateWith({
    String name,
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted,
  }) {
    this.name = name ?? this.name;
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.formType = formType ?? this.formType;
    this.isLoading.value = isLoading ?? this.isLoading.value;
    this.submitted = submitted ?? this.submitted;
    notifyListeners();
  }

  Future<void> submit() async {
    try {
      updateWith(submitted: true, isLoading: true);
      if (this.formType == EmailSignInFormType.signIn) {
        await auth.signWithEmail(this.email, this.password);
      } else {
        await auth.createWithEmail(this.email, this.password, this.name);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  bool get canSubmitted {
    return emailValidator.isValid(email) &&
        passwordValidator.isValid(password) &&
        !this.isLoading.value;
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
    bool emailValid = !(submitted && !(emailValidator.isValid(email)));
    return emailValid ? null : invalidEmailText;
  }

  String get nameErrorText {
    bool nameValid = !(submitted && !(nameValidator.isValid(name)));
    return nameValid ? null : invalidNameText;
  }


  void toggleForm() {
    final formTypes = this.formType == EmailSignInFormType.signIn
        ? EmailSignInFormType.register
        : EmailSignInFormType.signIn;
    updateWith(email: '', password: '', submitted: false, formType: formTypes);
  }

  void updateName(String name) => updateWith(name: name);
  void updateEmail(String email) => updateWith(email: email);
  void updatePassword(String password) => updateWith(password: password);
}
