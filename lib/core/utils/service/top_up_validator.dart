import 'package:easy_localization/easy_localization.dart';
import '../../../features/beneficiary/data/model/beneficiaryModel.dart';
import '../../../features/beneficiary/data/model/user_model.dart';

class TopUpValidator {
  static const double verifiedLimit = 1000;
  static const double unverifiedLimit = 500;
  static const double totalMonthlyLimit = 3000;
  static const double transactionFee = 3;

  static String? validate({
    required UserModel user,
    required BeneficiaryModel beneficiary,
    required double amount,
  }) {
    final double totalWithFee = amount + transactionFee;

    if (totalWithFee > user.balance) {
      return "top_up.insufficient_balance".tr(namedArgs: {
        'amount': totalWithFee.toStringAsFixed(2),
      });
    }

    final double userMonthlyTotal = user.totalTopUpAmountThisMonth;
    if (userMonthlyTotal + amount > totalMonthlyLimit) {
      return "top_up.total_limit_exceeded".tr();
    }

    final double beneficiaryLimit = user.isVerified
        ? verifiedLimit
        : unverifiedLimit;

    final double beneficiaryMonthlyTotal = beneficiary.topUpAmountThisMonth;
    if (beneficiaryMonthlyTotal + amount > beneficiaryLimit) {
      return "top_up.beneficiary_limit_exceeded".tr(namedArgs: {
        'limit': beneficiaryLimit.toInt().toString()},
      );
    }

    return null;
  }
}
