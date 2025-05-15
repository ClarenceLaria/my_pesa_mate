import 'package:flutter/material.dart';

class FinancialTipsScreen extends StatelessWidget {
  FinancialTipsScreen({super.key});
  
  final List<Map<String, String>> tips = [
    {
      'title': 'Track Your Expenses',
      'description': 'Know where your money goes. Use a budget tracker or app.',
      'icon': '💰',
    },
    {
      'title': 'Save Before You Spend',
      'description': 'Pay yourself first. Set aside at least 10% of your income.',
      'icon': '💼',
    },
    {
      'title': 'Avoid Unnecessary Debt',
      'description': 'Only borrow for things that add value (like education or business).',
      'icon': '🚫',
    },
    {
      'title': 'Build an Emergency Fund',
      'description': 'Save for at least 3–6 months of living expenses.',
      'icon': '🛟',
    },
    {
      'title': 'Invest Early and Consistently',
      'description': 'Even small investments grow over time thanks to compounding.',
      'icon': '📈',
    },
    {
      'title': 'Live Below Your Means',
      'description': 'Don’t try to impress. Spend less than you earn.',
      'icon': '🏠',
    },
    {
      'title': 'Set Financial Goals',
      'description': 'Short-term and long-term goals give direction to your spending.',
      'icon': '🎯',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Financial Literacy Tips'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: tips.length,
        itemBuilder: (context, index) {
          final tip = tips[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                radius: 24,
                backgroundColor: Colors.green.shade100,
                child: Text(tip['icon']!, style: const TextStyle(fontSize: 22)),
              ),
              title: Text(
                tip['title']!,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  tip['description']!,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
