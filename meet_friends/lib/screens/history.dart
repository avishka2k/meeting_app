import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#323745'),
      body: Container(),
    );
  }
}
