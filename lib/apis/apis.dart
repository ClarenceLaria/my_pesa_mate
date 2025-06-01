import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kurerefinancialplanner_app/models/transaction_model.dart';

class APIService {
  static const String baseUrl = 'https://the-kureres-backend.onrender.com/api/';

  static Future<String> createTransaction ({
    required String type,
    required String category,
    required double amount,
    required DateTime date,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}create-transaction'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'type': type,
          'category': category,
          'amount': amount,
          'txndate': date.toIso8601String(),
        }),
      );

      if (response.statusCode == 201) {
        return 'Transaction created successfully';
      } else {
        throw Exception('Failed to create transaction');
      }
    }catch (e){
      return 'Failed to create transaction';
    }
  }
  
  static Future<String> createBudget ({
    required String name,
    required double amount,
    required DateTime startDate,
    required DateTime endDate,
  })async{
    try{
      final response = await http.post(
        Uri.parse('${baseUrl}create-budget'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'amount': amount,
          'startDate': startDate.toIso8601String(),
          'endDate': endDate.toIso8601String(),
        }),
      );

      if(response.statusCode == 201){
        return 'Budget created successfully';
      } else {
        throw Exception('Failed to create budget');
      }
    }catch(e){
      return 'Failed to create transaction';
    }
  }

  static Future<List<FetchedTransaction>> getTransactions() async {
    try {
      final response = await http.get(Uri.parse('${baseUrl}get-transactions'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => FetchedTransaction.fromJson(item)).toList(); // cast to List<Map<String, dynamic>>
      } else {
        throw Exception('Failed to fetch transactions');
      }
    } catch (e) {
      throw Exception('Error fetching transactions: $e');
    }
  }
}