
import 'package:easy_lo/app/Sign_in/Function/validation.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInModel with EmailAndPassowrdValidator {
  EmailSignInModel({
    this.submitted = false,
    this.isLoading = false,
    this.email = '',
    this.password = '',
    this.formType = EmailSignInFormType.signIn,
  });
  final bool submitted;
  final bool isLoading;
  final String email;
  final String password;
  final EmailSignInFormType formType;

  EmailSignInModel copyWith({
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted,
  }) {
    return EmailSignInModel(
        email: email ?? this.email,
        password: password ?? this.password,
        formType: formType ?? this.formType,
        isLoading: isLoading ?? this.isLoading,
        submitted: submitted ?? this.submitted);
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
}
