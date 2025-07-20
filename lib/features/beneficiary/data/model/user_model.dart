import 'package:finance_house_assessment/features/home/data/model/top_up_model.dart';

class UserModel {
  final String id;
  final String name;
  final String phone;
  final bool isVerified;

  final List<TopUpModel> topUps;
  double balance;

  UserModel({
    required this.id,
    required this.name,
    required this.balance,
    required this.isVerified,
    required this.phone,
    this.topUps = const [],
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      phone: json['phone'],
      name: json['name'],
      balance: (json['balance'] as num).toDouble(),
      isVerified: json['isVerified'] ?? false,
      topUps:
          (json['topUps'] as List<dynamic>?)
              ?.map((e) => TopUpModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  double get totalTopUpAmountThisMonth {
    final now = DateTime.now();
    return topUps
        .where((e) => e.date.year == now.year && e.date.month == now.month)
        .fold(0.0, (sum, e) => sum + e.amount);
  }
  UserModel addTopUpEntry(double amount) {
    return copyWith(
      balance: balance - (amount + 3),
      topUps: [...topUps, TopUpModel(amount: amount, date: DateTime.now())],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'balance': balance,
    'isVerified': isVerified,
    'phone': phone,
    'topUps': topUps.map((e) => e.toJson()).toList(),
  };

  UserModel copyWith({
    String? id,
    String? name,
    String? phone,
    double? balance,
    bool? isVerified,
    List<TopUpModel>? topUps,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      balance: balance ?? this.balance,
      isVerified: isVerified ?? this.isVerified,
      topUps: topUps ?? this.topUps,
    );
  }
}
