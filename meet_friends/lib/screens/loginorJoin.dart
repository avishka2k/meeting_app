// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:meet_friends/firebaseAuth/googleAuth.dart';
import 'package:meet_friends/screens/joinWithId.dart';

class LoginOrJoin extends StatefulWidget {
  const LoginOrJoin({Key? key}) : super(key: key);

  @override
  State<LoginOrJoin> createState() => _LoginOrJoinState();
}

class _LoginOrJoinState extends State<LoginOrJoin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 70),
            Text(
              "TalkHost",
              style: TextStyle(
                fontSize: 35,
                color: HexColor('#5AA6FF'),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25),
            const Image(
              width: 300,
              image: AssetImage('assets/meet.png'),
            ),
            const SizedBox(height: 15),
            const Text(
              "Get Close with friends thtough \nvideo and chats",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 100),
            Container(
              width: 260,
              height: 50,
              decoration: BoxDecoration(
                color: HexColor('#141A1E'),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: HexColor('#000000').withOpacity(0.40),
                    offset: const Offset(0, 6),
                    blurRadius: 8,
                    spreadRadius: -1,
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const JoinWithId(),
                    ),
                  ),
                  borderRadius: BorderRadius.circular(10),
                  child: const Center(
                    child: Text(
                      "Join a Meeting",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              "OR",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              width: 260,
              height: 50,
              decoration: BoxDecoration(
                color: HexColor('#141A1E'),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: HexColor('#000000').withOpacity(0.40),
                    offset: const Offset(0, 6),
                    blurRadius: 8,
                    spreadRadius: -1,
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    GoogleAuth().signInWithGoogle(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Image(
                        image: AssetImage('assets/google-logo.png'),
                        width: 45,
                      ),
                      SizedBox(width: 20),
                      Text(
                        "Continue with Google",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
