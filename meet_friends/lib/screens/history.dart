import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:meet_friends/model/historyMethode.dart';
import 'package:intl/intl.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  Future<bool> _isCollectionExits() async {
    User user = FirebaseAuth.instance.currentUser!;
    QuerySnapshot<Map<String, dynamic>> _query = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(user.uid)
        .collection('meeting')
        .get();

    if (_query.docs.isNotEmpty) {
      // Collection exits
      return true;
    } else {
      // Collection not exits
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _isCollectionExits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirestoreMethods().meetingsHistory,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: (snapshot.data! as dynamic).docs.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 20,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: HexColor('#1F2431'),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () async {
                      User user = FirebaseAuth.instance.currentUser!;

                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.uid)
                          .collection('meetings')
                          .get()
                          .then((snapshot) {
                        for (DocumentSnapshot ds in snapshot.docs) {
                          ds.reference.delete();
                        }
                      });
                    },
                    child: ListTile(
                      title: Text(
                        '${(snapshot.data! as dynamic).docs[index]['meetingName']}',
                      ),
                      subtitle: Text(
                        'Joined on ${DateFormat.yMMMd().format(
                          (snapshot.data! as dynamic)
                              .docs[index]['createdAt']
                              .toDate(),
                        )}',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
