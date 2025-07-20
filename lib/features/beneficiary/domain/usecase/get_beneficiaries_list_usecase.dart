import 'package:finance_house_assessment/core/domain/usecase/usecase.dart';
import 'package:finance_house_assessment/features/beneficiary/data/model/beneficiaryModel.dart';
import 'package:injectable/injectable.dart';

import '../repository/beneficiary_repository.dart';

@injectable
class GetBeneficiariesUseCase
    extends UseCase<List<BeneficiaryModel>, NoParams> {
  final BeneficiaryRepository repository;

  GetBeneficiariesUseCase({required this.repository});

  @override
  Future<List<BeneficiaryModel>> call(params) async {
    return repository.getBeneficiaries();
  }
}
