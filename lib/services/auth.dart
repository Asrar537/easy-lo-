import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';


//generic class
class GUser {
  GUser({@required this.uid,@required this.photoUrl,@required this.displayName });
  final String uid;
  final String photoUrl;
  final String displayName;
}

abstract class AuthBase {
  Future<GUser> currentUser();

  Future<GUser> signAnonymusly();
  Future<GUser> signWithEmail(String email, String password);
  Future<GUser> createWithEmail(String email, String password);
  Future<GUser> signInWithGoogle();
  Future<GUser> signInWithFacebook();

  Future<void> signOut();
  Stream<GUser> get authStateChanges;
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  //convert fireuser to user
  GUser _userFromFirebase(User user) {
    print(user.uid);
    print(user.displayName);
    if (user == null) {
      return null;
    }
    return GUser(
      uid: user.uid,
      displayName: user.displayName,
      photoUrl: user.photoURL,
    );
  }

  @override
  Stream<GUser> get authStateChanges {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  @override
  Future<GUser> currentUser() async {
    final user = _firebaseAuth.currentUser;
    return _userFromFirebase(user);
  }

  @override
  Future<GUser> signAnonymusly() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<GUser> signWithEmail(String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<GUser> createWithEmail(String email, String password) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<GUser> signInWithGoogle() async {
    final googleAccount = await GoogleSignIn().signIn();
    //final googleAccount = await googlesignin.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final authResult = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );
        return _userFromFirebase(authResult.user);
      } else {
        throw PlatformException(
          code: 'Sign in Abort by Google',
          message: 'Sign in Abort by Google Missing Auth',
        );
      }
    } else {
      throw PlatformException(
        code: 'User_Abort_Sign_in',
        message: 'Sign in Abort by User',
      );
    }
  }

  @override
  Future<GUser> signInWithFacebook() async {
    // final facebookLogin = FacebookLogin();
    // final fbAccount = await facebookLogin.logIn(
    //   ['public_profile'],
    // );
    // if (fbAccount.accessToken != null) {
    //   final authResult = await _firebaseAuth.signInWithCredential(
    //     FacebookAuthProvider.credential(
    //       fbAccount.accessToken.token,
    //     ),
    //   );
    //   return _userFromFirebase(authResult.user);
    // } else {
    //   throw PlatformException(
    //     code: 'User_Abort_Sign_in',
    //     message: 'Sign in Abort by User',
    //   );
    // }
  }

  @override
  Future<void> signOut() async {
    //final googleSignin = GoogleSignIn();
    //await googleSignin.signOut();
    //final fbSignin = FacebookLogin();
    //await fbSignin.logOut();
    await _firebaseAuth.signOut();
  }
}
