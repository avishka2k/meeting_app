// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meet_friends/bottomTab.dart';
import 'package:meet_friends/screens/loginorJoin.dart';

class GoogleAuth {
  handleAuthSate() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Somting want wrong'));
        } else if (snapshot.hasData) {
          return const BottomTab();
        } else {
          return const LoginOrJoin();
        }
      },
    );
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

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
