import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Fungsi untuk memperbarui nama pengguna di Firestore
  Future<void> updateUserName(String newName) async {
    if (_auth.currentUser == null) return;
    await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
      'name': newName,
    });
  }

  // Mendapatkan user yang sedang aktif saat ini
  User? get currentUser => _auth.currentUser;

  // Stream status autentikasi
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Fungsi Login
  Future<User?> signIn(String email, String password) async {
    UserCredential result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user;
  }

  // Fungsi Register & Simpan Data Profil ke Firestore
  Future<User?> register(String email, String password, String name) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    
    // Simpan data profil ke koleksi 'users' agar nama bisa dipanggil di header/profil
    await _firestore.collection('users').doc(result.user!.uid).set({
      'name': name,
      'email': email,
      'createdAt': Timestamp.now(),
    });

    return result.user;
  }

  // Fungsi Logout
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Mengambil nama pengguna dari Firestore
  Future<String> getUserName() async {
    if (_auth.currentUser == null) return 'Pengguna';
    DocumentSnapshot doc = await _firestore.collection('users').doc(_auth.currentUser!.uid).get();
    if (doc.exists) {
      return (doc.data() as Map<String, dynamic>)['name'] ?? 'Pengguna';
    }
    return 'Pengguna';
  }
}