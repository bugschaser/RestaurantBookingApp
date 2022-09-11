import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant_booking_app/src/model/user.dart' as user_model;

class UserRepository{
  UserRepository() :
   _firebaseAuth = FirebaseAuth.instance;
  final FirebaseAuth _firebaseAuth;

  Future<UserCredential> signUpWithEmail({required String email, required String password}) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password );
  }

  Future<UserCredential> signInWithEmail({required String email, required String password}) async  {
    return await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password );
  }

  Future<Future<List>> signOut() async {
    return Future.wait([_firebaseAuth.signOut()]);
  }


  Future<bool> isLoggedIn() async {
    final User? currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<user_model.User?> getUser() async {
    final currentUser =  _firebaseAuth.currentUser;
    return user_model.User(email: currentUser!.email ?? '' ,
        name: currentUser.displayName ?? '');
  }

}