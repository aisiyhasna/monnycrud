import 'package:flutter/material.dart';
import '../../../services/transaction_service.dart';
import '../../../models/transaction_model.dart';
import '../../transactions/edit_transaction_screen.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TransactionService transactionService = TransactionService();

    return Scaffold(
      backgroundColor: const Color(0xFF0A192F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A192F),
        title: const Text('Riwayat Transaksi', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: StreamBuilder<List<TransactionModel>>(
        stream: transactionService.getTransactions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF64FFDA)));
          }

          List<TransactionModel> transactions = snapshot.data ?? [];

          if (transactions.isEmpty) {
            return const Center(child: Text('Belum ada riwayat transaksi.', style: TextStyle(color: Colors.white54)));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final item = transactions[index];
              final isMasuk = item.type == 'Pemasukan';
              return Card(
                color: const Color(0xFF112240),
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: isMasuk ? Colors.green.withOpacity(0.2) : Colors.red.withOpacity(0.2),
                    child: Icon(isMasuk ? Icons.arrow_downward : Icons.arrow_upward, color: isMasuk ? Colors.greenAccent : Colors.redAccent),
                  ),
                  title: Text(item.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  subtitle: Text('${item.date.day}/${item.date.month}/${item.date.year}', style: const TextStyle(color: Colors.white38)),
                  trailing: Text(
                    '${isMasuk ? "+" : "-"} Rp ${item.amount.toStringAsFixed(0)}',
                    style: TextStyle(color: isMasuk ? Colors.greenAccent : Colors.redAccent, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditTransactionScreen(transaction: item)),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}