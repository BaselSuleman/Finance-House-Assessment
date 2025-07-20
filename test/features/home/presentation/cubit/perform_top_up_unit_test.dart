import 'package:bloc_test/bloc_test.dart';
import 'package:finance_house_assessment/core/domain/usecase/usecase.dart';
import 'package:finance_house_assessment/core/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'package:finance_house_assessment/features/beneficiary/data/model/beneficiaryModel.dart';
import 'package:finance_house_assessment/features/beneficiary/data/model/user_model.dart';
import 'package:finance_house_assessment/features/beneficiary/domain/usecase/active_beneficiary_usecase.dart';
import 'package:finance_house_assessment/features/beneficiary/domain/usecase/delete_beneficiary_usecase.dart';
import 'package:finance_house_assessment/features/beneficiary/domain/usecase/get_beneficiaries_list_usecase.dart';
import 'package:finance_house_assessment/features/beneficiary/domain/usecase/get_user_usecase.dart';
import 'package:finance_house_assessment/features/beneficiary/presentation/beneficiaries_list_cubit/beneficiaries_list_cubit.dart';
import 'package:finance_house_assessment/features/home/domain/params/top_up_params.dart';
import 'package:finance_house_assessment/features/home/domain/usecase/get_top_up_option_list_usecase.dart';
import 'package:finance_house_assessment/features/home/domain/usecase/perform_topup_usecase.dart';
import 'package:finance_house_assessment/features/home/presentation/home_cubit/home_cubit.dart';
import 'package:finance_house_assessment/features/home/presentation/home_cubit/home_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockGetUserInfoUseCase extends Mock implements GetUserInfoUseCase {}

class MockDeleteBeneficiaryUseCase extends Mock
    implements DeleteBeneficiaryUseCase {}

class MockGetBeneficiariesUseCase extends Mock
    implements GetBeneficiariesUseCase {}

class MockActiveBeneficiaryUseCase extends Mock
    implements ActiveBeneficiaryUseCase {}

class MockGetTopUpOptionsListUseCase extends Mock
    implements GetTopUpOptionsListUseCase {}

class MockPerformTopUpUseCase extends Mock implements PerformTopUpUseCase {}

class MockThemeBloc extends Mock implements ThemeBloc {}

class FakeNoParams extends Fake implements NoParams {}
class FakeTopUpParams extends Fake implements TopUpParams {}

class MockBeneficiariesListCubit extends Mock implements BeneficiariesListCubit {}

void main() {
  late MockGetTopUpOptionsListUseCase mockGetTopUpOptionsListUseCase;
  late MockPerformTopUpUseCase mockPerformTopUpUseCase;
  late MockThemeBloc mockThemeBloc;
  late MockGetUserInfoUseCase mockGetUserInfoUseCase;
  late MockDeleteBeneficiaryUseCase mockDeleteBeneficiaryUseCase;
  late MockGetBeneficiariesUseCase mockGetBeneficiariesUseCase;
  late MockActiveBeneficiaryUseCase mockActiveBeneficiaryUseCase;
  late BeneficiariesListCubit beneficiariesListCubit;
  late MockBeneficiariesListCubit mockBeneficiariesListCubit;

  setUpAll(() {
    registerFallbackValue(FakeNoParams());
    registerFallbackValue(FakeTopUpParams());
    mockGetTopUpOptionsListUseCase = MockGetTopUpOptionsListUseCase();
    mockPerformTopUpUseCase = MockPerformTopUpUseCase();
    mockThemeBloc = MockThemeBloc();
    mockGetUserInfoUseCase = MockGetUserInfoUseCase();
    mockDeleteBeneficiaryUseCase = MockDeleteBeneficiaryUseCase();
    mockGetBeneficiariesUseCase = MockGetBeneficiariesUseCase();
    mockActiveBeneficiaryUseCase = MockActiveBeneficiaryUseCase();
    GetIt.instance.registerSingleton<GetUserInfoUseCase>(mockGetUserInfoUseCase);
    GetIt.instance.registerSingleton<DeleteBeneficiaryUseCase>(mockDeleteBeneficiaryUseCase);
    GetIt.instance.registerSingleton<GetBeneficiariesUseCase>(mockGetBeneficiariesUseCase);
    GetIt.instance.registerSingleton<ActiveBeneficiaryUseCase>(mockActiveBeneficiaryUseCase);

    GetIt.instance.registerSingleton<GetTopUpOptionsListUseCase>(mockGetTopUpOptionsListUseCase);

    GetIt.instance.registerSingleton<PerformTopUpUseCase>(mockPerformTopUpUseCase);
    GetIt.instance.registerSingleton<ThemeBloc>(mockThemeBloc);
    mockBeneficiariesListCubit = MockBeneficiariesListCubit();

    beneficiariesListCubit = BeneficiariesListCubit(forTest: true);
  });

  group('HomeCubit', () {
    final beneficiary = BeneficiaryModel(
      id: '1',
      nickname: 'Beneficiary One',
      phoneNumber: '+123456789',
      active: true,
      topUps: [],
    );
    final user = UserModel(
      id: 'u1',
      name: 'Bassel',
      balance: 1000,
      isVerified: true,
      phone: '+971557557560',
    );

    blocTest<HomeCubit, HomeState>(
      'should emit loading, success, and perform top-up successfully when top-up is valid',
      build: () {
        when(() => mockPerformTopUpUseCase.call(any())).thenAnswer((_) async => true);

        final state = beneficiariesListCubit.state.copyWith(
          userModel: user,
          beneficiaryList: [beneficiary],
        );
        when(() => mockBeneficiariesListCubit.state).thenReturn(state);

        return HomeCubit(mockBeneficiariesListCubit, forTest: true);
      },
      act: (cubit) => cubit.performTopUp(beneficiary: beneficiary, amount: 100),
    );
  });
}
