import 'package:finance_house_assessment/core/domain/usecase/usecase.dart';
import 'package:finance_house_assessment/features/home/domain/repository/home_repository.dart';
import 'package:injectable/injectable.dart';

import '../../data/model/top_up_options.dart';

@injectable
class GetTopUpOptionsListUseCase
    extends UseCase<List<TopUpOptionModel>, NoParams> {
  final HomeRepository repository;

  GetTopUpOptionsListUseCase({required this.repository});

  @override
  Future<List<TopUpOptionModel>> call(params) async {
    return repository.getTopUpOptions();
  }
}
