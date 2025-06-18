import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:send_money/dto/transaction.dart';
import 'package:send_money/service/transaction_service.dart';

class TransactionServiceImpl implements TransactionService {
  late final Dio _service;

  TransactionServiceImpl(this._service);

  @override
  Future<List<Transaction>> getTransactions() async {
    try {
      final response = await _service.get('transactions');
      final data = response.data as List;

      return data.map((json) => Transaction.fromJson(json)).toList();
    } on DioException catch (e) {
      return [];
    }
  }
}
