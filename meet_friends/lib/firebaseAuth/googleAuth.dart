// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meet_friends/bottomTab.dart';
import 'package:meet_friends/model/userModel.dart';
import 'package:meet_friends/screens/loginorJoin.dart';

class GoogleAuth {
  handleAuthSate() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return BottomTab(assUserDetails: addDataToDatabase());
        } else {
          return const LoginOrJoin();
        }
      },
    );
  }

  Future addDataToDatabase() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;
    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.name = user.displayName;
    userModel.imageUrl = user.photoURL;

    await firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .set(userModel.toMap());
  }

  Future<UserCredential> signInWithGoogle(context) async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    Navigator.pop(context);
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> logOut(context) async {
    await Future.delayed(const Duration(seconds: 2));
    await FirebaseAuth.instance.signOut();
  }
}
