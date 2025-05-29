import 'dart:convert';

import 'package:http/http.dart' as http;

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
    required String amount,
    required String startDate,
    required String endDate,
    required String userId,
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
          'startDate': startDate,
          'endDate': endDate,
          'userId': userId,
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
}