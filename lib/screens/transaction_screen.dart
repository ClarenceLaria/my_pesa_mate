import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kurerefinancialplanner_app/bloc/transaction/transaction_bloc.dart';
import 'package:kurerefinancialplanner_app/bloc/transaction/transaction_state.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
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
        child: BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            if (state is TransactionLoadingState) {
              return const CircularProgressIndicator();
            } else if (state is TransactionLoadedState) {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.transactions.length,
                itemBuilder: (context, index) {
                  final tx = state.transactions[index];
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: tx.type.toLowerCase() == 'income' ? Colors.green.shade100 : Colors.red.shade100,
                        child: Icon(
                          tx.type.toLowerCase() == 'income' ? Icons.arrow_downward : Icons.arrow_upward,
                          color: tx.type.toLowerCase() == 'income' ? Colors.green : Colors.red,
                        ),
                      ),
                      title: Text(
                        tx.category,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        formatDate(tx.createdAt),
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      trailing: Text(
                        '${tx.type.toLowerCase() == 'income' ? '+ ' : '- '}KSh.${tx.amount.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: tx.type.toLowerCase() == 'income' ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is TransactionErrorState) {
              return Center(child: Text(state.error),);
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
