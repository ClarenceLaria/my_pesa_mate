import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:kurerefinancialplanner_app/bloc/add_budget/add_budget_bloc.dart';
import 'package:kurerefinancialplanner_app/bloc/add_budget/add_budget_event.dart';
import 'package:kurerefinancialplanner_app/bloc/add_budget/add_budget_state.dart';
import 'package:kurerefinancialplanner_app/models/budget_model.dart';

class CreateBudgetScreen extends StatefulWidget {
  const CreateBudgetScreen({super.key});

  @override
  State<CreateBudgetScreen> createState() => _CreateBudgetScreenState();
}

class _CreateBudgetScreenState extends State<CreateBudgetScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  final TextEditingController _amountController = TextEditingController();

  String? _selectedCategory;
  final List<String> _categories = [
    'Food',
    'Transport',
    'Entertainment',
    'Health',
    'Utilities'
  ];

  Future<void> _pickStartDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      setState(() {
        startDate = date;
      });
    }
  }

  Future<void> _pickEndDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      setState(() {
        endDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Budget')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Select Category', style: TextStyle(fontSize: 16)),
                  DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    items: _categories
                        .map(
                            (cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                        .toList(),
                    onChanged: (value) => setState(() => _selectedCategory = value),
                    decoration: InputDecoration(
                      hintText: 'Choose a category',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    validator: (value) =>
                        value == null ? 'Please select a category' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Budget Amount (KSh)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Please enter amount';
                      final n = num.tryParse(value);
                      if (n == null || n <= 0) return 'Enter a valid number';
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text('Start Date'),
                  GestureDetector(
                    onTap: _pickStartDate,
                    child: _customField(DateFormat.yMMMMd().format(startDate)),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text('End Date'),
                  GestureDetector(
                    onTap: _pickEndDate,
                    child: _customField(DateFormat.yMMMMd().format(endDate)),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: BlocConsumer<AddBudgetBloc, AddBudgetState>(
                      listener: (context, state) {
                        if (state is AddBudgetSuccessState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );

                          setState(() {
                            _amountController.clear();
                            _selectedCategory = null;
                            startDate = DateTime.now();
                            endDate = DateTime.now();
                          });
                        } else if (state is AddBudgetFailureState) {
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
                          onPressed: state is AddBudgetLoadingState 
                          ? null
                          : () {
                            context.read<AddBudgetBloc>().add(
                              CreateBudgetEvent(
                                budget: Budget(
                                  category: _selectedCategory ?? '',
                                  amount: double.tryParse(_amountController.text) ?? 0.0,
                                  startDate: startDate,
                                  endDate: endDate,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.greenAccent,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text(
                            'Create Budget',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
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
}
