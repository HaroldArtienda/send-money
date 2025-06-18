
import 'package:dio/dio.dart';
import 'package:send_money/dto/transaction.dart';

abstract class TransactionService{
  Future<List<Transaction>> getTransactions();
}