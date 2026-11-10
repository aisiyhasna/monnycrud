import 'package:flutter/material.dart';
import '../../services/transaction_service.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  String _selectedType = 'Pengeluaran';
  final TransactionService _transactionService = TransactionService();
  bool _isLoading = false;

  void _save() async {
    if (_titleController.text.isEmpty || _amountController.text.isEmpty) return;
    setState(() => _isLoading = true);

    await _transactionService.addTransaction(
      _titleController.text.trim(),
      double.parse(_amountController.text.trim()),
      _selectedType,
    );

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A192F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A192F),
        title: const Text('Tambah Transaksi', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Judul Transaksi',
                labelStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: const Color(0xFF112240),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Nominal (Rp)',
                labelStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: const Color(0xFF112240),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedType,
              dropdownColor: const Color(0xFF112240),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Tipe Transaksi',
                labelStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: const Color(0xFF112240),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              items: ['Pemasukan', 'Pengeluaran'].map((type) {
                return DropdownMenuItem(value: type, child: Text(type));
              }).toList(),
              onChanged: (val) => setState(() => _selectedType = val!),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF64FFDA),
                  foregroundColor: const Color(0xFF0A192F),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _isLoading ? null : _save,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Color(0xFF0A192F))
                    : const Text('Simpan Transaksi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}