import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kurerefinancialplanner_app/models/transaction_model.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final List<Transaction> transactions = [
    Transaction(category: 'Salary', amount: 100000, date: DateTime.now(), type: 'Expense'),
    Transaction(category: 'Groceries', amount: 15000, date: DateTime.now().subtract(Duration(days: 1)), type: 'Expense'),
    Transaction(category: 'Electricity Bill', amount: 10000, date: DateTime.now().subtract(Duration(days: 2)), type: 'Expense'),
    Transaction(category: 'Freelance Project', amount: 25000, date: DateTime.now().subtract(Duration(days: 3)), type: 'Income'),
    Transaction(category: 'Transport', amount: 5000, date: DateTime.now().subtract(Duration(days: 4)), type: 'Expense'),
  ];

  String formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final tx = transactions[index];
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: tx.type == 'Income' ? Colors.green.shade100 : Colors.red.shade100,
                  child: Icon(
                    tx.type == 'Income' ? Icons.arrow_downward : Icons.arrow_upward,
                    color: tx.type == 'Income' ? Colors.green : Colors.red,
                  ),
                ),
                title: Text(
                  tx.category,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  formatDate(tx.date),
                  style: TextStyle(color: Colors.grey[600]),
                ),
                trailing: Text(
                  '${tx.type == 'Income' ? '+ ' : '- '}KSh.${tx.amount.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: tx.type == 'Income' ? Colors.green : Colors.red,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
