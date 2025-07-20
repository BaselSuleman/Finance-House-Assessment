import 'package:bloc/bloc.dart';
import 'package:finance_house_assessment/features/beneficiary/domain/usecase/add_beneficiary_usecase.dart';
import 'package:finance_house_assessment/features/beneficiary/presentation/beneficiaries_list_cubit/beneficiaries_list_cubit.dart';

import '../../../../../core/utils/failures/base_failure.dart';
import '../../../../../di/injection.dart';
import '../../data/model/beneficiaryModel.dart';
import 'add_beneficiary_state.dart';

class AddBeneficiaryCubit extends Cubit<AddBeneficiaryState> {
  final BeneficiariesListCubit beneficiaryListCubit;

  AddBeneficiaryCubit(this.beneficiaryListCubit)
    : super(AddBeneficiaryState.initial()) {
    _addBeneficiaryUseCase = getIt<AddBeneficiaryUseCase>();
    getBeneficiaries(beneficiaryListCubit.state.beneficiaryList!);
  }

  late AddBeneficiaryUseCase _addBeneficiaryUseCase;

  Future<void> addBeneficiary({
    required String name,
    required String phoneNumber,
  }) async {
    if (!(state.formKey.currentState!.validate())) {
      emit(state.enableValidation());
    } else {
      emit(state.copyWith(status: AddBeneficiaryStatus.loading));
      await Future.delayed(const Duration(milliseconds: 500));

      try {
        var res = await _addBeneficiaryUseCase(
          BeneficiaryModel(
            id: state.beneficiaryList!.isEmpty
                ? "0"
                : (int.parse(state.beneficiaryList!.last.id) + 1).toString(),
            nickname: name,
            phoneNumber: phoneNumber,
            active: true,
          ),
        );
        await beneficiaryListCubit.addBeneficiary(res);
        emit(
          state.copyWith(
            status: AddBeneficiaryStatus.addedSuccess,
            newBeneficiary: res,
          ),
        );
      } on Failure catch (l) {
        emit(state.copyWith(status: AddBeneficiaryStatus.error, failure: l));
      }
    }
  }

  Future<void> getBeneficiaries(List<BeneficiaryModel> beneficiaryList) async {
    emit(state.copyWith(beneficiaryList: beneficiaryList));
  }

}
