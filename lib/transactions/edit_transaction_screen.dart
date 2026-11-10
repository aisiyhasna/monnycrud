import 'package:flutter/material.dart';
import '../../models/transaction_model.dart';
import '../../services/transaction_service.dart';

class EditTransactionScreen extends StatefulWidget {
  final TransactionModel transaction;
  const EditTransactionScreen({super.key, required this.transaction});

  @override
  State<EditTransactionScreen> createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends State<EditTransactionScreen> {
  late TextEditingController _titleController;
  late TextEditingController _amountController;
  late String _selectedType;
  final TransactionService _transactionService = TransactionService();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.transaction.title);
    _amountController = TextEditingController(text: widget.transaction.amount.toStringAsFixed(0));
    _selectedType = widget.transaction.type;
  }

  void _update() async {
    await _transactionService.updateTransaction(
      widget.transaction.id,
      _titleController.text.trim(),
      double.parse(_amountController.text.trim()),
      _selectedType,
    );
    if (mounted) Navigator.pop(context);
  }

  void _delete() async {
    await _transactionService.deleteTransaction(widget.transaction.id);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A192F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A192F),
        title: const Text('Edit Transaksi', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.redAccent),
            onPressed: _delete,
          ),
        ],
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
                onPressed: _update,
                child: const Text('Simpan Perubahan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}