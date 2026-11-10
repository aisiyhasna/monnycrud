import 'package:flutter/material.dart';
import '../../../services/auth_service.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _authService = AuthService();
  String _name = 'Loading...';
  String _email = '';

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  void _loadProfile() async {
    String name = await _authService.getUserName();
    String email = _authService.currentUser?.email ?? '';
    if (mounted) {
      setState(() {
        _name = name;
        _email = email;
      });
    }
  }

  void _logout() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF112240),
        title: const Text('Konfirmasi Logout', style: TextStyle(color: Colors.white)),
        content: const Text('Apakah Anda yakin ingin keluar dari akun ini?', style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal', style: TextStyle(color: Colors.white38)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () async {
              Navigator.pop(context);
              await _authService.signOut();
              if (!mounted) return;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
            child: const Text('Logout', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A192F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A192F),
        title: const Text('Profil Saya', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 45,
              backgroundColor: Color(0xFF64FFDA),
              child: Icon(Icons.person, size: 50, color: Color(0xFF0A192F)),
            ),
            const SizedBox(height: 16),
            Text(_name, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(_email, style: const TextStyle(color: Colors.white54, fontSize: 14)),
            const SizedBox(height: 40),
            ListTile(
              tileColor: const Color(0xFF112240),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text('Keluar Akun', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
              onTap: _logout,
            ),
          ],
        ),
      ),
    );
  }
}