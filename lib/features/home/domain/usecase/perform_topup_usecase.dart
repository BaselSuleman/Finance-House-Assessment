import 'package:finance_house_assessment/core/domain/usecase/usecase.dart';
import 'package:finance_house_assessment/features/home/domain/repository/home_repository.dart';
import 'package:injectable/injectable.dart';

import '../params/top_up_params.dart';


@injectable
class PerformTopUpUseCase extends UseCase<bool, TopUpParams> {
  final HomeRepository repository;

  PerformTopUpUseCase({required this.repository});

  @override
  Future<bool> call(TopUpParams params) async {
    return repository.performTopUp(params);
  }
}
