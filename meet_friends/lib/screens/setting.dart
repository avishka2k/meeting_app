// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:meet_friends/firebaseAuth/googleAuth.dart';
import 'package:meet_friends/screens/editProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

bool notificaion = false;

class _SettingState extends State<Setting> {
  saveNotficationState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('notificaion', notificaion);
  }

  @override
  void initState() {
    saveNotficationState();
    lodeNotficationState();
    super.initState();
  }

  lodeNotficationState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      notificaion = prefs.getBool('notificaion') ?? true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#323745'),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: HexColor('#1F2431'),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const EditProfile(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/profile.jpeg'),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Avishka Prabath",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      "av*****@gmail.com",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white60,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image(
                                image:
                                    const AssetImage('assets/edit-button.png'),
                                width: 20,
                                color: HexColor('#5AA6FF'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 25, bottom: 10),
              child: Text(
                'settings'.toUpperCase(),
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            settingsItems(),
          ],
        ),
      ),
    );
  }

  Widget settingsItems() {
    return ListView(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      children: <Widget>[
        settingsItemsTheme('palette1', 'Appearance', () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 130,
                decoration: BoxDecoration(
                  color: HexColor('#323745'),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    appearanceList('Light'),
                    appearanceList('Dark'),
                    appearanceList('System default'),
                  ],
                ),
              );
            },
          );
        }),
        settingsItemsTheme('notification', 'Notification', () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: HexColor('#323745'),
                title: const Text(
                  "Notification",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Enable notification",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Switch(
                      value: notificaion,
                      onChanged: (value) {
                        setState(() {
                          notificaion = value;
                          print(notificaion);
                          saveNotficationState();
                          Navigator.of(context).pop();
                        });
                      },
                    )
                  ],
                ),
              );
            },
          );
        }),
        settingsItemsTheme('exit', 'Sign Out', () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: HexColor('#323745'),
                title: const Text(
                  "Sign Out",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                content: const Text(
                  "Are you sure you want to sign out?",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'cancel'.toUpperCase(),
                      style: TextStyle(
                        color: HexColor('#5AA6FF'),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      GoogleAuth().logOut();
                    },
                    child: Text(
                      'Yes'.toUpperCase(),
                      style: TextStyle(
                        color: HexColor('#5AA6FF'),
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }),
      ],
    );
  }

  Widget settingsItemsTheme(String icon, String text, methode) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: methode,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: Row(
            children: [
              Image.asset(
                'assets/$icon.png',
                width: 20,
                color: Colors.white70,
              ),
              const SizedBox(width: 20),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget appearanceList(String themeName) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                themeName,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
