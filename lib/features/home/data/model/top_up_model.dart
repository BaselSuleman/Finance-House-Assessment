class TopUpModel {
  final double amount;
  final DateTime date;

  TopUpModel({required this.amount, required this.date});

  factory TopUpModel.fromJson(Map<String, dynamic> json) {
    return TopUpModel(
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() => {
    'amount': amount,
    'date': date.toIso8601String(),
  };
}
