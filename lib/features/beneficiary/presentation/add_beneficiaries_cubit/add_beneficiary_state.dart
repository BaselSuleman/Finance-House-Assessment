import 'package:finance_house_assessment/features/beneficiary/data/model/beneficiaryModel.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/failures/base_failure.dart';

enum AddBeneficiaryStatus { initial, loading, error, success, addedSuccess }

class AddBeneficiaryState {
  final AddBeneficiaryStatus status;
  final Failure? failure;
  final BeneficiaryModel? newBeneficiary;
  final List<BeneficiaryModel>? beneficiaryList;
  final bool validateField;
  GlobalKey<FormState> formKey;

  AddBeneficiaryState._({
    required this.status,
    this.failure,
    this.newBeneficiary,
    required this.formKey,
    this.validateField = false,
    required this.beneficiaryList,
  });

  AddBeneficiaryState.initial()
    : status = AddBeneficiaryStatus.initial,
      failure = null,
      newBeneficiary = null,
      formKey = GlobalKey<FormState>(),
      validateField = false,
      beneficiaryList = [];

  AddBeneficiaryState enableValidation() {
    return copyWith(validateField: true);
  }

  AddBeneficiaryState disableValidation() {
    return copyWith(validateField: false, formKey: GlobalKey<FormState>());
  }

  AddBeneficiaryState copyWith({
    AddBeneficiaryStatus? status,
    Failure? failure,
    BeneficiaryModel? newBeneficiary,
    List<BeneficiaryModel>? beneficiaryList,
    GlobalKey<FormState>? formKey,
    bool? validateField,
  }) {
    return AddBeneficiaryState._(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      formKey: formKey ?? this.formKey,
      newBeneficiary: newBeneficiary ?? this.newBeneficiary,
      beneficiaryList: beneficiaryList ?? this.beneficiaryList,
      validateField: validateField ?? this.validateField,
    );
  }
}
