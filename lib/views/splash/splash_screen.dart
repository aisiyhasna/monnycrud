import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:praktikum_crud_firebase/views/auth/login_screen.dart';
import 'package:praktikum_crud_firebase/views/dashboard/main_navigation_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  void _checkAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF0A192F), // Dark Navy Blue
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_balance_wallet, size: 80, color: Color(0xFF64FFDA)),
            SizedBox(height: 16),
            Text(
              'MONNY',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 8),
            Text('Catatan Keuangan Pribadi', style: TextStyle(color: Colors.white54, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}