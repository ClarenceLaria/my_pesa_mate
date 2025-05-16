import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kurerefinancialplanner_app/components/transactions_card.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  String selectedType = 'Income';
  String selectedCategory = 'Food';
  DateTime selectedDate = DateTime.now();
  TextEditingController amountController = TextEditingController();

  final List<Transaction> transactions = [
    Transaction(category: 'Salary', amount: 100000, date: DateTime.now(), type: 'Income'),
    Transaction(category: 'Groceries', amount: 15000, date: DateTime.now().subtract(Duration(days: 1)), type: 'Expense'),
    Transaction(category: 'Electricity Bill', amount: 10000, date: DateTime.now().subtract(Duration(days: 2)), type: 'Expense'),
    Transaction(category: 'Freelance Project', amount: 25000, date: DateTime.now().subtract(Duration(days: 3)), type: 'Income'),
    Transaction(category: 'Transport', amount: 5000, date: DateTime.now().subtract(Duration(days: 4)), type: 'Expense'),
  ];

  Future<void> _pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          'Add Transaction',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Type'),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) => ListView(
                        children: ['Income', 'Expense']
                            .map((e) => ListTile(
                                  title: Text(e),
                                  onTap: () {
                                    setState(() {
                                      selectedType = e;
                                    });
                                    Navigator.pop(context);
                                  },
                                ))
                            .toList(),
                      ),
                    );
                  },
                  child: _customField(selectedType),
                ),
                const SizedBox(height: 16),
                const Text('Amount'),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: _inputDecoration('KSh.'),
                ),
                const SizedBox(height: 16),
                const Text('Category'),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) => ListView(
                        children: ['Food', 'Transport', 'Rent', 'Health']
                            .map((e) => ListTile(
                                  title: Text(e),
                                  onTap: () {
                                    setState(() {
                                      selectedCategory = e;
                                    });
                                    Navigator.pop(context);
                                  },
                                ))
                            .toList(),
                      ),
                    );
                  },
                  child: _customField(selectedCategory),
                ),
                const SizedBox(height: 16),
                const Text('Date'),
                GestureDetector(
                  onTap: _pickDate,
                  child: _customField(DateFormat.yMMMMd().format(selectedDate)),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      // Save logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TransactionsCard(transactions: transactions),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _customField(String value) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(value),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
