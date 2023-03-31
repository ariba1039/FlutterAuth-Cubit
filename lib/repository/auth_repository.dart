import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_flex/exceptions/apple_failure.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../exceptions/anonymous_failure.dart';
import '../exceptions/facebook_failure.dart';
import '../exceptions/google_failure.dart';
import '../exceptions/login_failure.dart';
import '../exceptions/signup_failure.dart';
import '../models/user_model.dart';

class AuthRepository {
  AuthRepository({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
    FacebookAuth? facebookAuth,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard(),
        _facebookAuth = facebookAuth ?? FacebookAuth.instance;

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookAuth _facebookAuth;

  Stream<UserModel> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null
          ? UserModel.empty
          : UserModel(
              id: firebaseUser.uid,
              email: firebaseUser.email,
              name: firebaseUser.displayName,
              photo: firebaseUser.photoURL,
            );
      return user;
    });
  }

  /// =================================== [Login] with Email and password ===================================
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  /// =================================== [Login] Anonymously ===================================

  Future<void> loginAnonymously() async {
    try {
      await _firebaseAuth.signInAnonymously();
    } on FirebaseAuthException catch (_) {
      throw LoginAnonymousFailure();
    } on SocketException catch (_) {
      throw LoginAnonymousFailure('Please check your internet connection, and try again');
    } catch (e) {
      throw const LoginAnonymousFailure();
    }
  }

  /// =================================== Google ===================================
  Future<UserCredential> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw LogInWithGoogleFailure.fromCode(e.code);
    } catch (e) {
      throw LogInWithGoogleFailure(e.toString());
    }
  }

  /// =================================== Facebook ===================================
  Future<void> loginWithFacebook() async {
    try {
      final LoginResult result = await _facebookAuth.login(); // by default we request the email and the public profile
      if (result.status == LoginStatus.success) {
        /// In-case you want to extract data
        // Map<String, dynamic>? userProfile = await FacebookAuth.instance.getUserData();
        // final name = userProfile['name'];
        // final email = userProfile['email'];
        // final imageUrl = userProfile['picture']['data']['url'];

        // you are logged
        final AccessToken accessToken = result.accessToken!;
        log('ACCESS TOKEN :: ${accessToken.token}');

        OAuthCredential credential = FacebookAuthProvider.credential(accessToken.token);

        await _firebaseAuth.signInWithCredential(credential);
      } else {
        throw LogInWithFacebookFailure('cancelled');
      }
    } on FirebaseAuthException catch (e) {
      print('Facebook FirebaseAuthException ${e}');
      throw LogInWithFacebookFailure.fromCode(e.code);
    } catch (e) {
      if (e is LogInWithFacebookFailure) {
        throw LogInWithFacebookFailure(e.message);
      } else {
        throw LogInWithFacebookFailure();
      }
    }
  }

  /// =================================== Apple ===================================

  Future<void> loginWithApple() async {
    try {
      // final appleProvider = AppleAuthProvider();
      // await _firebaseAuth.signInWithProvider(appleProvider);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final oAuthProvider = OAuthProvider('apple.com');
      final credential = oAuthProvider.credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );
      await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print('Apple error :: ${e.toString()}');
      throw LogInWithAppleFailure.fromCode(e.code);
    } catch (e) {
      print('Apple error :: ${e.toString()}');
      throw const LogInWithAppleFailure();
    }
  }

  /// =================================== Register ===================================
  Future<void> registerWithEmailAndPassword({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  /// =================================== Logout ===================================

  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
        _facebookAuth.logOut(),
      ]);
    } catch (_) {
      throw LogOutFailure();
    }
  }
}
