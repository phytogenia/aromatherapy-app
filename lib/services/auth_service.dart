import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user.dart';

abstract class AuthService {
  static const String googleProviderName = 'google';
  static const String facebookProviderName = 'facebook';

  Future<MyUser?> signInAnonymously();
  Future<void> signOut();
  MyUser? getCurrentUser();
  Stream<MyUser?> get onChangeUser;
  Future<MyUser?> signInWithGoogle();
  Future<MyUser?> signInWithFacebook();
  Future<MyUser?> createUserWithEmailAndPassword(String email, String password);
  Future<MyUser?> signInWithEmailAndPassword(String email, String password);
}

class FirebaseAuthService extends AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyUser? _userFromFirebase(User? user) {
    if (user == null) {
      return null;
    }
    return MyUser(uid: user.uid);
  }

  @override
  Future<MyUser?> signInAnonymously() async {
    try {
      UserCredential _userCredential = await _auth.signInAnonymously();
      return MyUser(uid: _userCredential.user!.uid);
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      final _providerData = _auth.currentUser!.providerData;
      if (_providerData.isNotEmpty) {
        if (_providerData[0]
            .providerId
            .toLowerCase()
            .contains(AuthService.googleProviderName)) {
          await GoogleSignIn().signOut();
        } else if (_providerData[0]
            .providerId
            .toLowerCase()
            .contains(AuthService.facebookProviderName)) {
          await FacebookAuth.instance.login();
        }
      }
      await _auth.signOut();
    } on FirebaseAuthException catch (error) {
      throw PlatformException(
          code: error.code, message: error.message, details: error.plugin);
    } catch (e) {
      print(e);
    }
  }

  @override
  MyUser? getCurrentUser() {
    final _uid = _auth.currentUser;
    return _userFromFirebase(_uid);
  }

  @override
  Stream<MyUser?> get onChangeUser {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  @override
  Future<MyUser?> signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? _googleSignInAccount =
          await _googleSignIn.signIn();
      if (_googleSignInAccount != null) {
        final GoogleSignInAuthentication _googleSignInAuthentication =
            await _googleSignInAccount.authentication;
        final AuthCredential _credential = GoogleAuthProvider.credential(
          accessToken: _googleSignInAuthentication.accessToken,
          idToken: _googleSignInAuthentication.idToken,
        );
        UserCredential _authResult =
            await _auth.signInWithCredential(_credential);
        return _userFromFirebase(_authResult.user);
      } else {
        throw PlatformException(
          code: 'ERROR_MISSING_GOOGLE_TOKEN',
          message: 'Missing Google Account Token.',
        );
      }
    } on FirebaseAuthException catch (error) {
      throw PlatformException(
          code: error.code, message: error.message, details: error.plugin);
    } on PlatformException catch (error) {
      rethrow;
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Future<MyUser?> signInWithFacebook() async {
    try {
      final LoginResult _result = await FacebookAuth.instance.login();
      switch (_result.status) {
        case LoginStatus.success:
          final AuthCredential facebookCredential =
              FacebookAuthProvider.credential(_result.accessToken!.token);
          final _userCredential =
              await _auth.signInWithCredential(facebookCredential);
          return _userFromFirebase(_userCredential.user);
        case LoginStatus.cancelled:
          throw PlatformException(
            code: 'ERROR_MISSING_FACEBOOK_TOKEN',
            message: 'Missing Facebook Account Token.',
          );
        case LoginStatus.failed:
          throw PlatformException(
            code: 'ERROR_FAILED_FACEBOOK_LOGIN',
            message: 'Failed To Login With Facebook.',
          );
        default:
          return null;
      }
    } on FirebaseAuthException catch (error) {
      throw PlatformException(
          code: error.code, message: error.message, details: error.plugin);
    } on PlatformException catch (error) {
      rethrow;
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Future<MyUser?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final _userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _userFromFirebase(_userCredential.user);
    } on FirebaseAuthException catch (error) {
      throw PlatformException(
          code: error.code, message: error.message, details: error.plugin);
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Future<MyUser?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final _userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _userFromFirebase(_userCredential.user);
    } on FirebaseAuthException catch (error) {
      throw PlatformException(
          code: error.code, message: error.message, details: error.plugin);
    } catch (error) {
      print(error.toString());
    }
  }
}
