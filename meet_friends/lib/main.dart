import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meet_friends/firebaseAuth/googleAuth.dart';
import 'package:meet_friends/themedata.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    ChangeNotifierProvider<AppStateNotifier>(
      create: (context) => AppStateNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateNotifier>(builder: (context, appState, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Meeting',
        darkTheme: MyTheme.darkTheme,
        theme: MyTheme.lightTheme,
        themeMode: !appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        home: GoogleAuth().handleAuthSate(),
      );
    });
  }
}
