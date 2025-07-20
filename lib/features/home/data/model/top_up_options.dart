class TopUpOptionModel {
  final double amount;

  TopUpOptionModel({required this.amount});

  factory TopUpOptionModel.fromJson(Map<String, dynamic> json) {
    return TopUpOptionModel(amount: json['amount']);
  }
}
