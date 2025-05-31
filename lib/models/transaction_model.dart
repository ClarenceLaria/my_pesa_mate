class Transaction {
  final String type;
  final String category;
  final double amount;
  final DateTime date;

  Transaction({
    required this.type,
    required this.category,
    required this.amount,
    required this.date,
  });
}

class FetchedTransaction {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String type; // e.g., "Income" or "Expense"
  final double amount;
  final DateTime txnDate;
  final String category;

  FetchedTransaction({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
    required this.amount,
    required this.txnDate,
    required this.category,
  });

  factory FetchedTransaction.fromJson(Map<String, dynamic> json) {
    return FetchedTransaction(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      type: json['type'] as String,
      amount: (json['amount'] as num).toDouble(),
      txnDate: DateTime.parse(json['txnDate']),
      category: json['category'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'type': type,
      'amount': amount,
      'txnDate': txnDate.toIso8601String(),
      'category': category,
    };
  }
}

