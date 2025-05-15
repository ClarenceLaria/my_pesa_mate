import 'package:flutter/material.dart';

class BudgetCategoryCard extends StatelessWidget {
  final String category;
  final double amount;
  final double percentageUsed;

  const BudgetCategoryCard({
    super.key,
    required this.category,
    required this.amount,
    required this.percentageUsed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(category, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            Text("KSh. ${amount.toStringAsFixed(2)}", style: const TextStyle(fontSize: 16)),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: percentageUsed,
            minHeight: 15,
            backgroundColor: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.teal),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
