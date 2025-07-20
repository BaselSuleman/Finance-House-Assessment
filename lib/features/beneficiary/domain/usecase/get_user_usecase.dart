import 'package:finance_house_assessment/core/domain/usecase/usecase.dart';
import 'package:injectable/injectable.dart';

import '../../data/model/user_model.dart';
import '../repository/beneficiary_repository.dart';

@injectable
class GetUserInfoUseCase extends UseCase<UserModel, NoParams> {
  final BeneficiaryRepository repository;

  GetUserInfoUseCase({required this.repository});

  @override
  Future<UserModel> call(params) async {
    return repository.getUserData();
  }
}
