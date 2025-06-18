class Transaction {
  final String id;
  final String transactionId;
  final double transactionAmount;
  final DateTime date;
  final String transactionType;

  Transaction({
    required this.id,
    required this.transactionId,
    required this.transactionAmount,
    required this.date,
    required this.transactionType,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as String,
      transactionId: json['transactionId'] as String,
      transactionAmount: double.tryParse(json['transactionAmount'] as String) ?? 0,
      date: DateTime.parse(json['date'] as String),
      transactionType: json['transactionType'] as String,
    );
  }
}
