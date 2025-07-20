import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:finance_house_assessment/core/domain/usecase/usecase.dart';
import 'package:finance_house_assessment/core/utils/failures/failures.dart';
import 'package:finance_house_assessment/features/beneficiary/data/model/beneficiaryModel.dart';
import 'package:finance_house_assessment/features/beneficiary/domain/usecase/active_beneficiary_usecase.dart';
import 'package:finance_house_assessment/features/beneficiary/domain/usecase/delete_beneficiary_usecase.dart';
import 'package:finance_house_assessment/features/beneficiary/domain/usecase/get_beneficiaries_list_usecase.dart';
import 'package:finance_house_assessment/features/beneficiary/domain/usecase/get_user_usecase.dart';
import 'package:finance_house_assessment/features/home/data/model/top_up_model.dart';

import '../../../../../di/injection.dart';
import 'beneficiaries_list_state.dart';

class BeneficiariesListCubit extends Cubit<BeneficiariesListState> {
  final bool forTest;

  BeneficiariesListCubit({this.forTest = false})
    : super(BeneficiariesListState.initial()) {
    _getUserInfoUseCase = getIt<GetUserInfoUseCase>();
    _deleteBeneficiaryUseCase = getIt<DeleteBeneficiaryUseCase>();
    _getBeneficiariesUseCase = getIt<GetBeneficiariesUseCase>();
    _activeBeneficiaryUseCase = getIt<ActiveBeneficiaryUseCase>();
    if (!forTest) {
      getUserInfo();
    }
  }

  late GetUserInfoUseCase _getUserInfoUseCase;
  late DeleteBeneficiaryUseCase _deleteBeneficiaryUseCase;
  late GetBeneficiariesUseCase _getBeneficiariesUseCase;
  late ActiveBeneficiaryUseCase _activeBeneficiaryUseCase;

  Future getUserInfo() async {
    emit(state.copyWith(status: BeneficiariesListStatus.loading));
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      var res = await _getUserInfoUseCase(NoParams());
      emit(
        state.copyWith(status: BeneficiariesListStatus.success, userModel: res),
      );
      if (!forTest) {
        await getBeneficiaries();
      }
    } on Failure catch (l) {
      emit(state.copyWith(status: BeneficiariesListStatus.error, failure: l));
    }
  }

  Future getBeneficiaries() async {
    if (state.beneficiaryList!.isNotEmpty) {
      return;
    }
    emit(state.copyWith(status: BeneficiariesListStatus.loading));
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      var res = await _getBeneficiariesUseCase(NoParams());
      emit(
        state.copyWith(
          status: BeneficiariesListStatus.success,
          beneficiaryList: res,
        ),
      );
    } on Failure catch (l) {
      emit(state.copyWith(status: BeneficiariesListStatus.error, failure: l));
    }
  }

  Future<void> deleteBeneficiaries(BeneficiaryModel item) async {
    emit(state.copyWith(status: BeneficiariesListStatus.loading));
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      await _deleteBeneficiaryUseCase(item);
      emit(state.copyWith(status: BeneficiariesListStatus.deleted));
    } on Failure catch (l) {
      emit(state.copyWith(status: BeneficiariesListStatus.error, failure: l));
    }
  }

  Future<void> addBeneficiary(BeneficiaryModel beneficiary) async {
    List<BeneficiaryModel> updatedList = state.beneficiaryList!
      ..add(beneficiary);
    emit(state.copyWith(beneficiaryList: updatedList));
  }

  Future<void> deleteBeneficiary(BeneficiaryModel item) async {
    await deleteBeneficiaries(item);
    final updatedList = List<BeneficiaryModel>.from(state.beneficiaryList!)
      ..removeWhere((beneficiary) => beneficiary.id == item.id);
    emit(
      state.copyWith(
        beneficiaryList: updatedList,
        status: BeneficiariesListStatus.success,
      ),
    );
  }

  Future<void> toggleBeneficiaryActivation(BeneficiaryModel beneficiary) async {
    emit(state.copyWith(status: BeneficiariesListStatus.loading));

    try {
      if (!canAddBeneficiary()) {
        throw CustomFailure(
          message: "beneficiaries.limit5ActiveBeneficiaries".tr(),
        );
      }
      final toggledBeneficiary = beneficiary.copyWith(
        active: !beneficiary.active,
      );

      final updatedBeneficiary = await _activeBeneficiaryUseCase(
        toggledBeneficiary,
      );

      final updatedList = List<BeneficiaryModel>.from(state.beneficiaryList!);
      final index = updatedList.indexWhere((b) => b.id == beneficiary.id);
      if (index != -1) {
        updatedList[index] = updatedBeneficiary;
      }

      emit(
        state.copyWith(
          status: BeneficiariesListStatus.updated,
          beneficiaryList: updatedList,
        ),
      );
    } on Failure catch (l) {
      emit(state.copyWith(status: BeneficiariesListStatus.error, failure: l));
    }
  }

  bool canAddBeneficiary() {
    final activeList = state.beneficiaryList
        ?.where((beneficiary) => beneficiary.active)
        .toList();

    return (activeList?.length ?? 0) < 5;
  }

  void updateBeneficiaryAndUserInfo({
    required String beneficiaryId,
    required double topUpAmount,
  }) {
    if (state.userModel == null || state.beneficiaryList == null) {
      throw CustomFailure(message: 'User or beneficiary list is missing.');
    }

    final updatedUser = state.userModel!.addTopUpEntry(topUpAmount);

    final oldBeneficiary = state.beneficiaryList!.firstWhere(
      (b) => b.id == beneficiaryId,
      orElse: () => throw CustomFailure(message: 'Beneficiary not found.'),
    );

    final updatedBeneficiary = oldBeneficiary.copyWith(
      topUps: [
        ...oldBeneficiary.topUps,
        TopUpModel(amount: topUpAmount, date: DateTime.now()),
      ],
    );

    final updatedList = List<BeneficiaryModel>.from(state.beneficiaryList!);
    final index = updatedList.indexOf(oldBeneficiary);
    updatedList[index] = updatedBeneficiary;

    emit(state.copyWith(userModel: updatedUser, beneficiaryList: updatedList));
  }
}
