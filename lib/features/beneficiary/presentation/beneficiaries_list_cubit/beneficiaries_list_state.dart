import 'package:finance_house_assessment/features/beneficiary/data/model/beneficiaryModel.dart';
import 'package:finance_house_assessment/features/beneficiary/data/model/user_model.dart';

import '../../../../../core/utils/failures/base_failure.dart';

enum BeneficiariesListStatus { initial, loading, error, success, deleted,updated }

class BeneficiariesListState {
  final BeneficiariesListStatus status;
  final Failure? failure;
  final UserModel? userModel;
  final List<BeneficiaryModel>? beneficiaryList;

  BeneficiariesListState._({
    required this.status,
    this.failure,
    required this.userModel,
    required this.beneficiaryList,
  });

  BeneficiariesListState.initial()
    : status = BeneficiariesListStatus.initial,
      failure = null,
      userModel = null,
      beneficiaryList = [];

  BeneficiariesListState copyWith({
    BeneficiariesListStatus? status,
    Failure? failure,
    UserModel? userModel,
    List<BeneficiaryModel>? beneficiaryList,
  }) {
    return BeneficiariesListState._(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      userModel: userModel ?? this.userModel,
      beneficiaryList: beneficiaryList ?? this.beneficiaryList,
    );
  }
}
