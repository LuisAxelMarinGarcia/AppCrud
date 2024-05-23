import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TransactionQueue {
  final SharedPreferences sharedPreferences;

  TransactionQueue(this.sharedPreferences);

  Future<void> addTransaction(Map<String, dynamic> transaction) async {
    final transactions = await _getTransactions();
    transactions.add(transaction);
    await sharedPreferences.setString('transactions', jsonEncode(transactions));
  }

  Future<List<Map<String, dynamic>>> getTransactions() async {
    return await _getTransactions();
  }

  Future<void> clearTransactions() async {
    await sharedPreferences.remove('transactions');
  }

  Future<List<Map<String, dynamic>>> _getTransactions() async {
    final transactionsString = sharedPreferences.getString('transactions');
    if (transactionsString != null) {
      return List<Map<String, dynamic>>.from(jsonDecode(transactionsString));
    }
    return [];
  }
}
