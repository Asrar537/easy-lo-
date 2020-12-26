import 'dart:async';

import 'package:easy_lo/services/auth.dart';
import 'package:flutter/foundation.dart';

class SignInManger {
  SignInManger({@required this.auth, @required this.isLoading});
  final AuthBase auth;
  final ValueNotifier<bool> isLoading;

  Future<GUser> _signMethod(Future<GUser> Function() signInMethod) async {
    try {
      isLoading.value = true;
      return await signInMethod();
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }

  Future<GUser> signGoogle() async => await _signMethod(auth.signInWithGoogle);
  Future<GUser> signFacebook() async => await _signMethod(auth.signInWithFacebook);
}
