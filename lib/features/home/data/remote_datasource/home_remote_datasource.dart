import 'package:finance_house_assessment/core/data/model/base_response_model.dart';

import '../../domain/params/top_up_params.dart';
import '../model/top_up_options.dart';

abstract class HomeRemoteDataSource {
  Future<BaseResponse<List<TopUpOptionModel>>> getTopUpOptions();

  Future<BaseResponse<bool>> performTopUp(TopUpParams request);
}
