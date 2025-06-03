import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kurerefinancialplanner_app/skeleton/budget_category_skeleton.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreenSkeleton extends StatelessWidget {
  const HomeScreenSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryRatios = List.generate(3, (index) => {});

    Widget skeletonBox(
        {double width = 100, double height = 16, double radius = 8}) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Column(
              children: [
                // Income and Pie Chart Card
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(top: 16),
                  height: 330,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      skeletonBox(width: 80),
                      const SizedBox(height: 4),
                      skeletonBox(width: 140),
                      const Divider(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              skeletonBox(width: 100),
                              const SizedBox(height: 10),
                              skeletonBox(width: 120),
                            ],
                          ),
                          const Spacer(),
                          SizedBox(
                            height: 180,
                            width: 180,
                            child: PieChart(
                              PieChartData(
                                sections: [
                                  PieChartSectionData(
                                    color: Colors.grey.shade300,
                                    value: 70,
                                    radius: 40,
                                    title: '',
                                  ),
                                  PieChartSectionData(
                                    color: Colors.grey.shade400,
                                    value: 30,
                                    radius: 40,
                                    title: '',
                                  ),
                                ],
                                sectionsSpace: 0,
                                centerSpaceRadius: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Budget Category Skeletons
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      skeletonBox(width: 160, height: 18),
                      const SizedBox(height: 20),
                      ...categoryRatios.map((_) {
                        return const Padding(
                          padding: EdgeInsets.only(bottom: 16.0),
                          child: BudgetCategoryShimmer(),
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
