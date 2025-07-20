import 'package:finance_house_assessment/features/home/data/model/top_up_model.dart';

class BeneficiaryModel {
  final String id;
  final String nickname;
  final String phoneNumber;
  final bool active;
  final List<TopUpModel> topUps; 

  BeneficiaryModel({
    required this.id,
    required this.nickname,
    required this.phoneNumber,
    required this.active,
    this.topUps = const [],
  });

  factory BeneficiaryModel.fromJson(Map<String, dynamic> json) {
    return BeneficiaryModel(
      id: json['id'],
      active: json['active'],
      nickname: json['nickname'],
      phoneNumber: json['phoneNumber'],
      topUps: (json['topUps'] as List<dynamic>?)
          ?.map((e) => TopUpModel.fromJson(e))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'active': active,
    'nickname': nickname,
    'phoneNumber': phoneNumber,
    'topUps': topUps.map((e) => e.toJson()).toList(),
  };

  double get topUpAmountThisMonth {
    final now = DateTime.now();
    return topUps
        .where((e) => e.date.year == now.year && e.date.month == now.month)
        .fold(0.0, (sum, e) => sum + e.amount);
  }

  BeneficiaryModel copyWith({
    String? id,
    String? nickname,
    String? phoneNumber,
    bool? active,
    List<TopUpModel>? topUps,
  }) {
    return BeneficiaryModel(
      id: id ?? this.id,
      nickname: nickname ?? this.nickname,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      active: active ?? this.active,
      topUps: topUps ?? this.topUps,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BeneficiaryModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
