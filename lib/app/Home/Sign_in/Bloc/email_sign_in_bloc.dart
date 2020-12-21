import 'dart:async';

import 'package:easy_lo/app/Home/Sign_in/Bloc/Model/email_sign_in_model.dart';
import 'package:easy_lo/services/auth.dart';

class EmailSignInBloc {
  EmailSignInBloc({this.auth});

  final AuthBase auth;
  final StreamController<EmailSignInModel> _emailModelController =
      StreamController<EmailSignInModel>();
  EmailSignInModel _model = EmailSignInModel();

  void dispose() {
    _emailModelController.close();
  }

  Stream<EmailSignInModel> get emailModelController => _emailModelController.stream;
  void updateModel({
    String email,
    String password,
    EmailSignInFormType fromType,
    bool isLoading,
    bool submitted,
  }) {
    _model = _model.copyWith(
        email: email,
        password: password,
        formType: fromType,
        isLoading: isLoading,
        submitted: submitted);
    _emailModelController.add(_model);
  }

  Future<void> submit() async {
    try {
      updateModel(submitted: true, isLoading: true);
      if (_model.formType == EmailSignInFormType.signIn) {
        await auth.signWithEmail(_model.email, _model.password);
      } else {
        await auth.createWithEmail(_model.email, _model.password);
      }
    } catch (e) {
      updateModel(isLoading: false);
      rethrow;
    }
  }

  void toggleForm() {
    final formTypes = _model.formType == EmailSignInFormType.signIn
        ? EmailSignInFormType.register
        : EmailSignInFormType.signIn;
    updateModel(email: '', password: '', submitted: false, fromType: formTypes);
  }

  void updateEmail(String email) => updateModel(email: email);
  void updatePassword(String password) => updateModel(password: password);
}
