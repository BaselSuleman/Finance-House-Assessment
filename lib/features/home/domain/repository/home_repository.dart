import '../../data/model/top_up_options.dart';
import '../params/top_up_params.dart';

abstract class HomeRepository {
  Future<List<TopUpOptionModel>> getTopUpOptions();
  Future<bool> performTopUp(TopUpParams request);

}
