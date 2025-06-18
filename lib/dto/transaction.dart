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
      transactionAmount:
          double.tryParse(json['transactionAmount'] as String) ?? 0,
      date: DateTime.parse(json['date'] as String),
      transactionType: json['transactionType'] as String,
    );
  }

  factory Transaction.createNew(double amount) {
    return Transaction(
      id: '',
      transactionId: 'TX${DateTime.now().millisecondsSinceEpoch}',
      // or user input
      transactionAmount: amount,
      date: DateTime.now(),
      transactionType: 'deposit', // or 'payment'
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transactionId': transactionId,
      'transactionAmount': transactionAmount.toStringAsFixed(2),
      'date': date.toIso8601String(),
      'transactionType': transactionType,
    };
  }
}
