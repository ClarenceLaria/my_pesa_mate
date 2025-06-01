class Budget{
  const Budget({
    required this.category,
    required this.amount,
    required this.startDate,
    required this.endDate,
  });

  final String category;
  final double amount;
  final DateTime startDate;
  final DateTime endDate;
}