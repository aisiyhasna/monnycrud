import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/transaction_model.dart';

class TransactionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get userId => _auth.currentUser?.uid;

  // Stream transaksi real-time
  Stream<List<TransactionModel>> getTransactions() {
    if (userId == null) return const Stream.empty();
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('transactions')
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => TransactionModel.fromFirestore(doc))
            .toList());
  }

  // Tambah transaksi
  Future<void> addTransaction(String title, double amount, String type) async {
    if (userId == null) return;
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('transactions')
        .add({
      'title': title,
      'amount': amount,
      'type': type,
      'date': Timestamp.now(),
    });
  }

  // Edit transaksi
  Future<void> updateTransaction(String id, String title, double amount, String type) async {
    if (userId == null) return;
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('transactions')
        .doc(id)
        .update({
      'title': title,
      'amount': amount,
      'type': type,
    });
  }

  // Hapus transaksi
  Future<void> deleteTransaction(String id) async {
    if (userId == null) return;
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('transactions')
        .doc(id)
        .delete();
  }
}