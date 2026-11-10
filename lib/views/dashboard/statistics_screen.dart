import 'package:flutter/material.dart';
import '../../../services/transaction_service.dart';
import '../../../models/transaction_model.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TransactionService transactionService = TransactionService();

    return Scaffold(
      backgroundColor: const Color(0xFF0A192F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A192F),
        title: const Text('Statistik Keuangan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: StreamBuilder<List<TransactionModel>>(
        stream: transactionService.getTransactions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF64FFDA)));
          }

          List<TransactionModel> list = snapshot.data ?? [];
          int totalTransaksi = list.length;
          int totalPemasukanCount = list.where((t) => t.type == 'Pemasukan').length;
          int totalPengeluaranCount = list.where((t) => t.type == 'Pengeluaran').length;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildStatCard('Total Transaksi', '$totalTransaksi Catatan', Icons.receipt, const Color(0xFF64FFDA)),
                const SizedBox(height: 12),
                _buildStatCard('Jumlah Pemasukan', '$totalPemasukanCount Kali', Icons.arrow_downward, Colors.greenAccent),
                const SizedBox(height: 12),
                _buildStatCard('Jumlah Pengeluaran', '$totalPengeluaranCount Kali', Icons.arrow_upward, Colors.redAccent),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color accentColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF112240),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: accentColor.withOpacity(0.15),
            child: Icon(icon, color: accentColor),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white54, fontSize: 13)),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}