import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'models/views/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Jangan sampai kosong!
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monny - Catatan Keuangan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A192F),
        primaryColor: const Color(0xFF64FFDA),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF64FFDA),
          secondary: Color(0xFF64FFDA),
          surface: Color(0xFF112240),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}