import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'statistics_screen.dart';
import 'transaction_history_screen.dart';
import 'profile_screen.dart';
import '../../transactions/add_transaction_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    StatisticsScreen(),
    TransactionHistoryScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A192F),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF64FFDA),
        foregroundColor: const Color(0xFF0A192F),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTransactionScreen()),
          );
        },
        child: const Icon(Icons.add, size: 28),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: const Color(0xFF112240),
        selectedItemColor: const Color(0xFF64FFDA),
        unselectedItemColor: Colors.white38,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_rounded), label: 'Statistik'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long_rounded), label: 'Transaksi'),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profil'),
        ],
      ),
    );
  }
}