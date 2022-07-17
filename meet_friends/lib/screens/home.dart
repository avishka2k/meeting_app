import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:meet_friends/screens/joinWithId.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#323745'),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: HexColor('#5AA6FF'),
                    borderRadius: BorderRadius.circular(20),
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
                      borderRadius: BorderRadius.circular(20),
                      onTap: () => joinMeeting('2323dfdf224'),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Image.asset(
                          'assets/zoom.png',
                          color: HexColor('#D9D9D9'),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    'Join',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: HexColor('#C7C4C4'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 50),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  color: Colors.transparent,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: HexColor('#5AA6FF'),
                      borderRadius: BorderRadius.circular(20),
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
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const JoinWithId(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Image.asset(
                            'assets/plus.png',
                            color: HexColor('#D9D9D9'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    'Create Meeting',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: HexColor('#C7C4C4'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  joinMeeting(String roomName) async {
    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = true;
      featureFlag.resolution = FeatureFlagVideoResolution.HD_RESOLUTION;

      var options = JitsiMeetingOptions(room: roomName)
        ..subject = "Meeting with Friend"
        ..userDisplayName = "Avishka Prabath"
        ..userEmail = "myemail@email.com"
        // ..userAvatarURL =
        //     "https://someimageurl.com/image.jpg" // or .png
        ..audioMuted = true
        ..videoMuted = true;

      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      debugPrint("error: $error");
    }
  }
}
