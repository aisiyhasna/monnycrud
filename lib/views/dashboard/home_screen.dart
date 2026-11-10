import 'package:flutter/material.dart';
import '../../../services/auth_service.dart';
import '../../../services/transaction_service.dart';
import '../../../models/transaction_model.dart';
import '../../transactions/edit_transaction_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();
  final TransactionService _transactionService = TransactionService();
  String _userName = 'Pengguna';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  void _loadUserName() async {
    String name = await _authService.getUserName();
    if (mounted) setState(() => _userName = name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A192F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A192F),
        elevation: 0,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Color(0xFF64FFDA),
              child: Icon(Icons.person, color: Color(0xFF0A192F)),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Selamat Datang,', style: TextStyle(color: Colors.white54, fontSize: 12)),
                Text(_userName, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
      body: StreamBuilder<List<TransactionModel>>(
        stream: _transactionService.getTransactions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF64FFDA)));
          }

          List<TransactionModel> transactions = snapshot.data ?? [];
          double totalMasuk = transactions.where((t) => t.type == 'Pemasukan').fold(0, (sum, item) => sum + item.amount);
          double totalKeluar = transactions.where((t) => t.type == 'Pengeluaran').fold(0, (sum, item) => sum + item.amount);
          double saldo = totalMasuk - totalKeluar;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Kartu Ringkasan Saldo
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF112240),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Total Saldo', style: TextStyle(color: Colors.white54, fontSize: 14)),
                      const SizedBox(height: 8),
                      Text('Rp ${saldo.toStringAsFixed(0)}', style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.arrow_downward, color: Colors.greenAccent, size: 20),
                              const SizedBox(width: 4),
                              Text('Masuk: Rp ${totalMasuk.toStringAsFixed(0)}', style: const TextStyle(color: Colors.greenAccent, fontSize: 13)),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.arrow_upward, color: Colors.redAccent, size: 20),
                              const SizedBox(width: 4),
                              Text('Keluar: Rp ${totalKeluar.toStringAsFixed(0)}', style: const TextStyle(color: Colors.redAccent, fontSize: 13)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text('Transaksi Terbaru', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Expanded(
                  child: transactions.isEmpty
                      ? const Center(child: Text('Belum ada transaksi', style: TextStyle(color: Colors.white54)))
                      : ListView.builder(
                          itemCount: transactions.length,
                          itemBuilder: (context, index) {
                            final item = transactions[index];
                            final isMasuk = item.type == 'Pemasukan';
                            return Card(
                              color: const Color(0xFF112240),
                              margin: const EdgeInsets.only(bottom: 10),
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
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}