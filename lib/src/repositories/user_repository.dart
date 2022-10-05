import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// ignore: library_prefixes
import 'package:restaurant_booking_app/src/model/user.dart' as UserModel;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/constant.dart';

class UserRepository{
  UserRepository() :
   _firebaseAuth = FirebaseAuth.instance;
  final FirebaseAuth _firebaseAuth;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String?> createNewUser(UserModel.UserModel user) async {
    return await firestore
      .collection(Constant.USERS)
      .doc(user.userID)
      .set(user.toJson())
      .then((value) => null, onError: (e) => e);
  }

  Future<UserModel.UserModel?> getAuthUser() async {
    User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      UserModel.UserModel? user = await getCurrentUser(firebaseUser.uid);
      return user;
    } else {
      return null;
    }
  }

  Future<UserModel.UserModel?> getCurrentUser(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> userDocument = await
      firestore.collection(Constant.USERS).doc(uid).get();
    if(userDocument.exists && userDocument.data() != null){
      return UserModel.UserModel.fromJson(userDocument.data()!);
    }
    else{
      return null;
    }
  }

  Future<UserModel.UserModel> updateCurrentUser(UserModel.UserModel user) async {
    return await firestore
        .collection(Constant.USERS)
        .doc(user.userID)
        .set(user.toJson())
        .then((document) {
      return user;
    });
  }

  Future<dynamic> createUserWithEmail({required String email,
    required String password,
    File? image,
    name = 'Anonymous User'
  }) async {
     try {
       UserCredential userCredential =
       await _firebaseAuth.createUserWithEmailAndPassword(email: email,
           password: password );

       UserModel.UserModel user = UserModel.UserModel(name: name, email: email,
           userID:userCredential.user?.uid ?? '0',profilePic: '' );

       String? result = await createNewUser(user);

       if(result != null){
         return user;
       }

     } on FirebaseAuthException catch (e) {
       if (e.code == 'weak-password') {
         return('The password provided is too weak.');
       } else if (e.code == 'email-already-in-use') {
         return('The account already exists for that email.');
       }
     } catch (e) {
       if (kDebugMode) {
         print("Catch Exception: $e");
       }
       return(e.toString());
     }
     return null;
  }

  Future<dynamic> signInWithEmail({required String email,
    required String password}) async  {
    try {
      UserCredential? result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password );
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await
        firestore.collection(Constant.USERS).doc(result.user?.uid ?? '').get();
      UserModel.UserModel? user;
      if (documentSnapshot.exists) {
        user = UserModel.UserModel.fromJson(documentSnapshot.data() ?? {});
        return user;
      }
      else{
         return 'No user found, please signed up first.';
      }
    }on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return('Wrong password provided for that user.');
      }
    }catch(e){
      return  'Login failed, Please try again.';
    }
  }

  Future<dynamic> signInWithFacebook() async {
    FacebookAuth facebookAuth = FacebookAuth.instance;
    bool isLogged = await facebookAuth.accessToken != null;
    AccessToken? accessToken;
    if (!isLogged) {
      LoginResult result = await facebookAuth
          .login(); // by default we request the email and the public profile
      if (result.status == LoginStatus.success) {
        // you are logged
        accessToken = await facebookAuth.accessToken;
      }
    } else {
      accessToken = await facebookAuth.accessToken;
    }
    if(accessToken != null){
      UserCredential userCredential = await _firebaseAuth.signInWithCredential(
        FacebookAuthProvider.credential(accessToken.token)
      );
      UserModel.UserModel? user = await getCurrentUser(userCredential.user?.uid ?? '');
      if(user != null){
        return user;
      }
      else{
        Map<String, dynamic> userData = await facebookAuth.getUserData();
        UserModel.UserModel userModel = UserModel.UserModel(name: userData['name'] as String,
            email: userData['email'] as String,
            userID: userCredential.user?.uid ?? '',
            profilePic: userData['picture']['data']['url']
        );
        String? errorMessage = await createNewUser(userModel);
        if (errorMessage == null) {
          return user;
        } else {
          return errorMessage;
        }
      }

   }
    else {
      return 'Couldn\'t login with these facebook Id.';
    }
  }

  Future<dynamic> signInWithGoogle() async  {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential = await
      FirebaseAuth.instance.signInWithCredential(credential);

      UserModel.UserModel? currentUser = await getCurrentUser(userCredential.user?.uid ?? '');

      if(currentUser != null){
        return currentUser;
      }
      else{
        UserModel.UserModel user = UserModel.UserModel(
          userID: userCredential.user?.uid ?? '',
          name: userCredential.user?.displayName ?? '',
          email: userCredential.user?.email ?? '',
          profilePic: ''
        );
        String? errorMessage = await createNewUser(user);
        if (errorMessage == null) {
          return user;
        } else {
          return 'Couldn\'t create new user with gmail.';
        }
      }

    }on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
      }
    }
    return null;
  }

  Future<dynamic> signInOrCreateWithPhoneNumber(String phoneNumber) async  {
    try {
      String message = '';
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential authCredential) async {
          UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(authCredential);
          UserModel.UserModel? currentUser = await getCurrentUser(userCredential.user?.uid ?? '');

        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            message = "The phone number entered is invalid!";
          }
        },
        codeSent: (String verificationId, int? resendToken) {},
        codeAutoRetrievalTimeout: (String verificationId) {},
      );



    }on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
      }
    }
    return null;
  }

  Future<Future<List>> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      GoogleSignIn().signOut()
    ]);
  }

  Future<bool> isLoggedIn() async {
    final User? currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<void> resetPassword(String emailAddress) async =>
      await _firebaseAuth
          .sendPasswordResetEmail(email: emailAddress);

}