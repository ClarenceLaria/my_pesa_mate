import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kurerefinancialplanner_app/bloc/add_transaction/add_transaction_bloc.dart';
import 'package:kurerefinancialplanner_app/bloc/add_transaction/add_transaction_event.dart';
import 'package:kurerefinancialplanner_app/bloc/add_transaction/add_transaction_state.dart';
import 'package:kurerefinancialplanner_app/bloc/transaction/transaction_bloc.dart';
import 'package:kurerefinancialplanner_app/bloc/transaction/transaction_event.dart';
import 'package:kurerefinancialplanner_app/bloc/transaction/transaction_state.dart';
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
  initState() {
    super.initState();
    // Load initial transactions when the screen is opened
    context.read<TransactionBloc>().add(LoadTransactionsEvent());
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
                        children: [
                          'Salary',
                          'Capital Gains',
                          'Food',
                          'Transport',
                          'Rent',
                          'Health'
                        ]
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
                  child: BlocConsumer<AddTransactionBloc, AddTransactionState>(
                    listener: (context, state) {
                      if (state is AddTransactionSuccessState) {
                        // Dispatch an event to TransactionBloc
                        context
                            .read<TransactionBloc>()
                            .add(LoadTransactionsEvent());

                        // Show success snackbar
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );

                        // Clear the form fields
                        setState(() {
                          selectedType = 'Income';
                          selectedCategory = 'Food';
                          amountController.clear();
                          selectedDate = DateTime.now();
                        });
                      } else if (state is AddTransactionFailureState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.error),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: state is AddTransactionLoadingState
                            ? null
                            : () {
                                context.read<AddTransactionBloc>().add(
                                      CreateTransactionEvent(
                                        type: selectedType,
                                        amount: double.tryParse(
                                                amountController.text) ??
                                            0.0,
                                        category: selectedCategory,
                                        txnDate: selectedDate,
                                      ),
                                    );
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
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                BlocBuilder<TransactionBloc, TransactionState>(
                    builder: (context, state) {
                  if (state is TransactionLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TransactionLoadedState) {
                    return TransactionsCard(transactions: state.transactions);
                  } else if (state is TransactionErrorState) {
                    return Center(child: Text('Error: ${state.error}'));
                  } else {
                    return const SizedBox();
                  }
                }),
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
