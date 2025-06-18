
//routes
import 'package:intl/intl.dart';

enum SMRoute {
  login('/'),
  home('/home'),
  sendMoney('/sendMoney'),
  transaction('/transaction');

  final String path;
  const SMRoute(this.path);
}

//status
enum SendMoneyStatus {
  notStarted,
  loading,
  done,
}

//constants
final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

//helpers
String formatMoney(double amount) {
  final formatCurrency = NumberFormat.currency(
    locale: 'en_PH',
    symbol: '₱',
    decimalDigits: 2,
  );
  return formatCurrency.format(amount);
}