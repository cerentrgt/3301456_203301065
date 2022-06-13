import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<User?> signIn(String email, String password) async {
    var user =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return user.user;
  }

  signOut() async {
    return await auth.signOut();
  }

  Future<User?> createPerson(String name, String email, String password,
      String phoneNumber, String profileImage) async {
    var user = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    User? users = user.user;
    users!.updateProfile(displayName: name, photoURL: profileImage);

    await firestore.collection("Person").doc(user.user?.uid).set({
      'userName': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
    });

    return user.user;
  }

  Future<UserCredential> signInWithGoggle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return auth.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {


    final LoginResult loginResult = await FacebookAuth.instance.login();

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    return auth.signInWithCredential(facebookAuthCredential);
  }
}
