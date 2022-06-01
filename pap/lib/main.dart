import 'package:flutter/material.dart';
import 'package:pap/pages/homepage/homepage.dart';
import 'package:pap/pages/mainpages/hometrue.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pap/pages/mainpages/scan.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'AlvesFlutter',
    options: DefaultFirebaseOptions.currentPlatform,
  ).whenComplete(() => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}
