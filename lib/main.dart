import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './pages/models/transaction_provider.dart';


import 'pages/home.dart';
import 'pages/invest.dart';
import 'pages/settings.dart';
import 'pages/wallet/wallet.dart';
import 'pages/what_if.dart';
import 'package:google_fonts/google_fonts.dart';




void main() => runApp(
  ChangeNotifierProvider(
    create: (_) => TransactionProvider(),
    child: FinancialApp(),
    ),
  );




class FinancialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance Buddy',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.tealAccent),
        textTheme: GoogleFonts.nunitoSansTextTheme(),
      ),
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
      backgroundColor: Colors.black, 
      body: Center( 
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 350, 
          ),
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor, 
            child: Scaffold( 
              body: _pages[_selectedIndex],
              bottomNavigationBar: BottomNavigationBar(
                items: _navItems,
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.teal,
                onTap: _onItemTapped,
                type: BottomNavigationBarType.fixed,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
