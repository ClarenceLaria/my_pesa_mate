import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kurerefinancialplanner_app/screens/transaction_screen.dart';
import 'package:kurerefinancialplanner_app/models/transaction_model.dart';

class TransactionsCard extends StatelessWidget {
  final List<FetchedTransaction> transactions;

  const TransactionsCard({super.key, required this.transactions});

  String formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final latestTransactions = transactions.take(2).toList(); // latest two

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Latest Transactions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              OutlinedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TransactionsScreen(),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.green.shade300, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "View All",
                  style: TextStyle(fontSize: 12, color: Colors.green),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...latestTransactions.map((tx) {
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: CircleAvatar(
                  radius: 24,
                  backgroundColor: tx.type.toLowerCase() == 'income'
                      ? Colors.green.shade100
                      : Colors.red.shade100,
                  child: Icon(
                    tx.type.toLowerCase() == 'income'
                        ? Icons.arrow_upward
                        : Icons.arrow_downward,
                    color: tx.type.toLowerCase() == 'income' ? Colors.green : Colors.red,
                  ),
                ),
                title: Text(tx.category, style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text(formatDate(tx.createdAt)),
                trailing: Text(
                  '${tx.type.toLowerCase() == 'income' ? '+' : '-'} KSh.${tx.amount.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: tx.type.toLowerCase() == 'income' ? Colors.green : Colors.red,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
