import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/wallet.dart';
import 'pages/what_if.dart';
import 'pages/invest.dart';
import 'pages/settings.dart';

void main() => runApp(FinancialApp());

class FinancialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance Buddy',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    WalletPage(),
    WhatIfPage(),
    InvestPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<BottomNavigationBarItem> _navItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Wallet'),
    BottomNavigationBarItem(icon: Icon(Icons.help_outline), label: 'What If'),
    BottomNavigationBarItem(icon: Icon(Icons.trending_up), label: 'Invest'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Finance Buddy')),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _navItems,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
