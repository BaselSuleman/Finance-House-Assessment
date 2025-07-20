import 'package:finance_house_assessment/features/home/data/model/top_up_options.dart';
import 'package:finance_house_assessment/features/home/domain/params/top_up_params.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repository/home_repository.dart';
import '../remote_datasource/home_remote_datasource.dart';

@Singleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource dataSource;

  const HomeRepositoryImpl(this.dataSource);

  @override
  Future<List<TopUpOptionModel>> getTopUpOptions() async {
    final res = await dataSource.getTopUpOptions();
    return res.data!;
  }

  @override
  Future<bool> performTopUp(TopUpParams request) async {
    await dataSource.getTopUpOptions();
    return true;
  }
}
