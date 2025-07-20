import 'package:bloc/bloc.dart';
import 'package:finance_house_assessment/core/utils/failures/failures.dart';
import 'package:finance_house_assessment/features/beneficiary/presentation/beneficiaries_list_cubit/beneficiaries_list_cubit.dart';

import '../../../../../di/injection.dart';
import '../../../../core/domain/usecase/usecase.dart';
import '../../../../core/presentation/blocs/theme_bloc/theme_bloc.dart';
import '../../../../core/presentation/blocs/theme_bloc/theme_event.dart';
import '../../../../core/utils/service/top_up_validator.dart';
import '../../../beneficiary/data/model/beneficiaryModel.dart';
import '../../domain/params/top_up_params.dart';
import '../../domain/usecase/get_top_up_option_list_usecase.dart';
import '../../domain/usecase/perform_topup_usecase.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final BeneficiariesListCubit beneficiariesCubit;
  final bool forTest;

  HomeCubit(this.beneficiariesCubit, {this.forTest = false})
    : super(HomeState.initial()) {
    _getTopUpOptionsListUseCase = getIt<GetTopUpOptionsListUseCase>();
    _performTopUpUseCase = getIt<PerformTopUpUseCase>();
    themeBloc = getIt<ThemeBloc>();
    if (!forTest) {
      getTopUpOptions();
    }
  }

  late GetTopUpOptionsListUseCase _getTopUpOptionsListUseCase;
  late PerformTopUpUseCase _performTopUpUseCase;
  late final ThemeBloc themeBloc;

  Future getTopUpOptions() async {
    emit(state.copyWith(status: HomeStatus.loading));
    await Future.delayed(const Duration(milliseconds: 600));

    try {
      var res = await _getTopUpOptionsListUseCase(NoParams());
      await getInfo();
      emit(state.copyWith(status: HomeStatus.success, topUpOptionList: res));
    } on Failure catch (l) {
      emit(state.copyWith(status: HomeStatus.error, failure: l));
    }
  }

  Future<void> performTopUp({
    required BeneficiaryModel beneficiary,
    required double amount,
  }) async {
    emit(state.copyWith(status: HomeStatus.loading));
    await Future.delayed(const Duration(milliseconds: 500));

    final user = beneficiariesCubit.state.userModel;

    if (user == null) {
      emit(state.copyWith(status: HomeStatus.error));
      return;
    }

    String? validationError = TopUpValidator.validate(
      user: user,
      beneficiary: beneficiary,
      amount: amount,
    );

    if (validationError != null) {
      emit(
        state.copyWith(
          status: HomeStatus.error,
          failure: CustomFailure(message: validationError),
        ),
      );
      throw CustomFailure(message: validationError);
    }

    try {
      final result = await _performTopUpUseCase(
        TopUpParams(beneficiaryId: beneficiary.id, amount: amount),
      );

      if (result) {
        beneficiariesCubit.updateBeneficiaryAndUserInfo(
          beneficiaryId: beneficiary.id,
          topUpAmount: amount,
        );
        emit(
          state.copyWith(
            status: HomeStatus.topUpSuccess,
            userModel: beneficiariesCubit.state.userModel,
          ),
        );
      } else {
        emit(state.copyWith(status: HomeStatus.topUpFailed));
      }
      emit(state.copyWith(status: HomeStatus.success));
    } on Failure catch (e) {
      emit(state.copyWith(status: HomeStatus.error, failure: e));
    }
  }

  Future<void> getInfo() async {
    emit(state.copyWith(status: HomeStatus.loading));
    await Future.delayed(const Duration(milliseconds: 1000));
    emit(
      state.copyWith(
        beneficiaryList: beneficiariesCubit.state.beneficiaryList,
        userModel: beneficiariesCubit.state.userModel,
        status: HomeStatus.success,
      ),
    );
  }

  void updateSelectedAmount(double amount) {
    emit(state.copyWith(selectedAmount: amount));
  }

  void updateBeneficiaries() {
    emit(
      state.copyWith(beneficiaryList: beneficiariesCubit.state.beneficiaryList),
    );
  }

  void changeTheme(bool isDark) {
    themeBloc.add(ChangeThemeEvent(!isDark));
  }
}
