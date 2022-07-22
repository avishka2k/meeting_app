// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

class JoinWithId extends StatefulWidget {
  const JoinWithId({Key? key}) : super(key: key);

  @override
  State<JoinWithId> createState() => _JoinWithIdState();
}

class _JoinWithIdState extends State<JoinWithId> {
  bool audioCheckeds = true;
  bool videoChecked = false;

  final _joinWithId = TextEditingController();
  final _name = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
                textField(
                    _joinWithId, 'Join With Meeting ID', 'Can\'t be empty'),
                const SizedBox(height: 30),
                textField(_name, 'Your Name', 'Please enter your name'),
                const SizedBox(height: 30),
                audioCheckBox(),
                videoCheckBox(),
                const SizedBox(height: 50),
                saveBtn('Join', () {
                  if (_formKey.currentState!.validate()) {
                    joinMeeting(_joinWithId.text, audioCheckeds, videoChecked);
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget audioCheckBox() {
    return Row(
      children: [
        Checkbox(
          checkColor: Colors.white,
          activeColor: HexColor('#348DF5'),
          side: BorderSide(
            color: HexColor('#B4B4B4'),
            width: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          value: audioCheckeds,
          onChanged: (value) {
            setState(() {
              audioCheckeds = value!;
            });
          },
        ),
        Text(
          'Do not Connect to audio',
          style: TextStyle(
            fontSize: 13,
            color: HexColor('#B4B4B4'),
          ),
        ),
      ],
    );
  }

  Widget videoCheckBox() {
    return Row(
      children: [
        Checkbox(
          checkColor: Colors.white,
          activeColor: HexColor('#348DF5'),
          side: BorderSide(
            color: HexColor('#B4B4B4'),
            width: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          value: videoChecked,
          onChanged: (value) {
            setState(() {
              videoChecked = value!;
            });
          },
        ),
        Text(
          'Turn off my video',
          style: TextStyle(
            fontSize: 13,
            color: HexColor('#B4B4B4'),
          ),
        ),
      ],
    );
  }

  Widget saveBtn(String btnText, btnMethode) {
    return Container(
      width: 350,
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
          onTap: btnMethode,
          child: Center(
            child: Text(
              btnText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
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
        fillColor: HexColor('#1F2431').withOpacity(0.70),
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
        ..userDisplayName = _name.text
        ..audioMuted = audioState
        ..videoMuted = videoState;

      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      debugPrint("error: $error");
    }
  }
}
