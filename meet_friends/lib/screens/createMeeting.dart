// ignore_for_file: file_names, deprecated_member_use

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:meet_friends/model/historyMethode.dart';
import 'package:meet_friends/model/userModel.dart';

class CreateMeeting extends StatefulWidget {
  const CreateMeeting({Key? key}) : super(key: key);

  @override
  State<CreateMeeting> createState() => _CreateMeetingState();
}

class _CreateMeetingState extends State<CreateMeeting> {
  final FirestoreMethods _firestoreMethods = FirestoreMethods();
  final _meetingName = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  User user = FirebaseAuth.instance.currentUser!;
  UserModel loggedUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((value) {
      loggedUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: HexColor('#5AA6FF'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 50),
                textField(_meetingName, 'Meeting Name', 'Can\'t be empty'),
                const SizedBox(height: 50),
                saveBtn('Create', () {
                  if (_formKey.currentState!.validate()) {
                    createNewMeeting();
                    //joinMeeting('2323dfdf224', true, true);
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget saveBtn(String btnText, btnMethode) {
    return Container(
      width: 350,
      height: 50,
      decoration: BoxDecoration(
        color: Theme.of(context).buttonColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.20),
            offset: const Offset(0, 3),
            blurRadius: 7,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: btnMethode,
          child: Center(
            child: Text(
              btnText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget textField(
      TextEditingController _controller, String label, String errorText) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return errorText;
        }
        return null;
      },
      controller: _controller,
      style: const TextStyle(
        color: Colors.white70,
      ),
      cursorColor: HexColor('#5AA6FF'),
      decoration: InputDecoration(
        fillColor: Theme.of(context).backgroundColor,
        filled: true,
        labelText: label,
        labelStyle: TextStyle(
          color: HexColor('#B4B4B4'),
          fontSize: 13,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: HexColor('#1F2431'),
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: HexColor('#1F2431').withOpacity(0.2),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.red.withOpacity(0.6),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 2,
            color: Colors.red.withOpacity(0.6),
          ),
        ),
      ),
    );
  }

  joinMeeting(String roomName, bool audioState, bool videoState) async {
    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = true;
      featureFlag.resolution = FeatureFlagVideoResolution.HD_RESOLUTION;

      var options = JitsiMeetingOptions(room: roomName)
        ..subject = _meetingName.text
        ..userDisplayName = loggedUser.name
        ..userEmail = loggedUser.email
        ..userAvatarURL = loggedUser.imageUrl // or .png
        ..audioMuted = audioState
        ..videoMuted = videoState;

      _firestoreMethods.addToMeetingHistory(_meetingName.text);

      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      debugPrint("error: $error");
    }
  }

  createNewMeeting() async {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    joinMeeting(getRandomString(9), true, true);
  }
}
