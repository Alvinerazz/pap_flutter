// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:pap/pages/mainpages/hometrue.dart';
import '../mainpages/generator.dart';
import '../mainpages/scan.dart';
import '../mainpages/Info.dart';
import '../mainpages/Results.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    ResultsPage(),
    GeneratePage(),
    ScanPage(),
    Info(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _navigateBottomBar,
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.qr_code), label: 'QRCode'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.photo), label: 'Scanner'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
