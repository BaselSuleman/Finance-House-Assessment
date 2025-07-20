import 'package:finance_house_assessment/features/beneficiary/data/model/beneficiaryModel.dart';
import 'package:finance_house_assessment/features/beneficiary/data/model/user_model.dart';
import 'package:finance_house_assessment/features/home/data/model/top_up_options.dart';

import '../../../../../core/utils/failures/base_failure.dart';

enum HomeStatus { initial, loading, error, success, topUpSuccess, topUpFailed }

class HomeState {
  final HomeStatus status;
  final Failure? failure;
  final UserModel? userModel;
  final List<BeneficiaryModel>? beneficiaryList;
  final List<TopUpOptionModel>? topUpOptionList;
  final BeneficiaryModel? selectedBeneficiary;
  final double selectedAmount;

  HomeState._({
    required this.status,
    this.failure,
    required this.userModel,
    required this.beneficiaryList,
    required this.selectedBeneficiary,
    required this.topUpOptionList,
    required this.selectedAmount,
  });

  HomeState.initial()
    : status = HomeStatus.initial,
      failure = null,
      userModel = null,
      selectedAmount = 0.0,
      selectedBeneficiary = null,
      topUpOptionList = [],
      beneficiaryList = [];

  HomeState copyWith({
    HomeStatus? status,
    Failure? failure,
    UserModel? userModel,
    List<BeneficiaryModel>? beneficiaryList,
    List<TopUpOptionModel>? topUpOptionList,
    BeneficiaryModel? selectedBeneficiary,
    double? selectedAmount,
  }) {
    return HomeState._(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      userModel: userModel ?? this.userModel,
      selectedBeneficiary: selectedBeneficiary ?? this.selectedBeneficiary,
      topUpOptionList: topUpOptionList ?? this.topUpOptionList,
      beneficiaryList: beneficiaryList ?? this.beneficiaryList,
      selectedAmount: selectedAmount ?? this.selectedAmount,
    );
  }
}
