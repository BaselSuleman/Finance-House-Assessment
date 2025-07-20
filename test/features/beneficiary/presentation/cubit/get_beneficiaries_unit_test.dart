import 'package:bloc_test/bloc_test.dart';
import 'package:finance_house_assessment/core/domain/usecase/usecase.dart';
import 'package:finance_house_assessment/features/beneficiary/data/model/beneficiaryModel.dart';
import 'package:finance_house_assessment/features/beneficiary/data/model/user_model.dart';
import 'package:finance_house_assessment/features/beneficiary/domain/usecase/active_beneficiary_usecase.dart';
import 'package:finance_house_assessment/features/beneficiary/domain/usecase/delete_beneficiary_usecase.dart';
import 'package:finance_house_assessment/features/beneficiary/domain/usecase/get_beneficiaries_list_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:finance_house_assessment/features/beneficiary/domain/usecase/get_user_usecase.dart';
import 'package:finance_house_assessment/features/beneficiary/presentation/beneficiaries_list_cubit/beneficiaries_list_cubit.dart';
import 'package:finance_house_assessment/features/beneficiary/presentation/beneficiaries_list_cubit/beneficiaries_list_state.dart';
import 'package:finance_house_assessment/core/utils/failures/failures.dart';

class MockGetUserInfoUseCase extends Mock implements GetUserInfoUseCase {}
class MockDeleteBeneficiaryUseCase extends Mock implements DeleteBeneficiaryUseCase {}
class MockGetBeneficiariesUseCase extends Mock implements GetBeneficiariesUseCase {}
class MockActiveBeneficiaryUseCase extends Mock implements ActiveBeneficiaryUseCase {}
class FakeNoParams extends Fake implements NoParams {}

void main() {
  late MockGetUserInfoUseCase mockGetUserInfoUseCase;
  late MockDeleteBeneficiaryUseCase mockDeleteBeneficiaryUseCase;
  late MockGetBeneficiariesUseCase mockGetBeneficiariesUseCase;
  late MockActiveBeneficiaryUseCase mockActiveBeneficiaryUseCase;

  setUpAll(() {
    registerFallbackValue(FakeNoParams());
    mockGetUserInfoUseCase = MockGetUserInfoUseCase();
    mockDeleteBeneficiaryUseCase = MockDeleteBeneficiaryUseCase();
    mockGetBeneficiariesUseCase = MockGetBeneficiariesUseCase();
    mockActiveBeneficiaryUseCase = MockActiveBeneficiaryUseCase();
    GetIt.instance.registerSingleton<GetUserInfoUseCase>(mockGetUserInfoUseCase);
    GetIt.instance.registerSingleton<DeleteBeneficiaryUseCase>(mockDeleteBeneficiaryUseCase);
    GetIt.instance.registerSingleton<GetBeneficiariesUseCase>(mockGetBeneficiariesUseCase);
    GetIt.instance.registerSingleton<ActiveBeneficiaryUseCase>(mockActiveBeneficiaryUseCase);
  });

  group('BeneficiariesListCubit', () {
    final mockBeneficiariesList = [
      BeneficiaryModel(
        id: '1',
        nickname: 'Beneficiary One',
        phoneNumber: '+123456789',
        active: true,
        topUps: [],
      ),
      BeneficiaryModel(
        id: '2',
        nickname: 'Beneficiary Two',
        phoneNumber: '+987654321',
        active: true,
        topUps: [],
      ),
    ];

    blocTest<BeneficiariesListCubit, BeneficiariesListState>(
      'should emit loading and success when getting beneficiaries',
      build: () {
        when(() => mockGetBeneficiariesUseCase.call(any()))
            .thenAnswer((_) async => mockBeneficiariesList);
        return BeneficiariesListCubit(forTest: true);
      },
      act: (cubit) => cubit.getBeneficiaries(),
    );
  });
}
