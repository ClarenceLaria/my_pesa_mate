import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kurerefinancialplanner_app/apis/apis.dart';
import 'package:kurerefinancialplanner_app/components/budget_category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int incomeTotal = 0;
  int expenseTotal = 0;
  int budgetTotal = 0;
  List<dynamic> expensesByCategory = [];
  List<dynamic> budgetsByName = [];
  List<dynamic> categoryRatios = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getTotals();
  }

  Future<void> getTotals() async {
    try {
      final result = await APIService.getTotals();

      if (!mounted) return;
      setState(() {
        incomeTotal = result['incomeTotal']?.toInt() ?? 0;
        expenseTotal = result['expenseTotal']?.toInt() ?? 0;
        budgetTotal = result['budgetTotal']?.toInt() ?? 0;
        expensesByCategory = result['expensesByCategory'] ?? [];
        budgetsByName = result['budgetsByName'] ?? [];
        categoryRatios = result['categoryRatios'] ?? [];
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching totals: $e');
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching totals: $e'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.chevron_left, color: Colors.black),
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.black),
        ),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                        ),
                        height: 330,
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Income',
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'KSh. $incomeTotal',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const Divider(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Expenses',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'KSh. $expenseTotal',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                                  child: SizedBox(
                                    height: 180,
                                    width: 180,
                                    child: PieChart(
                                      PieChartData(
                                        sections: [
                                          PieChartSectionData(
                                            color: const Color.fromARGB(255, 103, 188, 152),
                                            value: (incomeTotal - expenseTotal).toDouble().clamp(0, double.infinity),
                                            radius: 40,
                                            title: 'Balance',
                                            titleStyle: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                          PieChartSectionData(
                                            color: const Color.fromARGB(255, 86, 226, 168),
                                            value: expenseTotal.toDouble(),
                                            radius: 40,
                                            title: 'Spent',
                                            titleStyle: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Budget by category',
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 20),
                            ...categoryRatios.map((ratio) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: BudgetCategoryCard(
                                  category: ratio['name'] ?? '',
                                  amount: (ratio['budget'] ?? 0.0).toDouble(),
                                  percentageUsed: ratio['ratio'] != null
                                      ? (ratio['ratio'] as num).toDouble().clamp(0.0, 1.0)
                                      : 0.0,
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
