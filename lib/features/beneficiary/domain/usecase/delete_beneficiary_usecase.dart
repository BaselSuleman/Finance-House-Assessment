import 'package:finance_house_assessment/core/domain/usecase/usecase.dart';
import 'package:injectable/injectable.dart';

import '../../data/model/beneficiaryModel.dart';
import '../repository/beneficiary_repository.dart';

@injectable
class DeleteBeneficiaryUseCase
    extends UseCase<BeneficiaryModel, BeneficiaryModel> {
  final BeneficiaryRepository repository;

  DeleteBeneficiaryUseCase({required this.repository});

  @override
  Future<BeneficiaryModel> call(BeneficiaryModel params) async {
    return repository.deleteBeneficiary(params);
  }
}
