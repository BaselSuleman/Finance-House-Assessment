class TopUpParams {
  final String beneficiaryId;
  final double amount;

  TopUpParams({required this.beneficiaryId, required this.amount});

  Map<String, dynamic> toJson() {
    return {'beneficiaryId': beneficiaryId, 'amount': amount};
  }
}
