import 'package:finance_house_assessment/core/data/model/base_response_model.dart';
import 'package:finance_house_assessment/features/home/data/model/top_up_options.dart';
import 'package:finance_house_assessment/features/home/domain/params/top_up_params.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/data/datasource/base_remote_datasource.dart';
import '../../../../core/utils/constants.dart';
import 'home_remote_datasource.dart';

@Singleton(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl extends BaseRemoteDataSourceImpl
    implements HomeRemoteDataSource {
  String getTopUpOptionsEndPoint = '${AppConstant.baseUrl}/api/topUp/options';

  HomeRemoteDataSourceImpl({required super.dio});

  @override
  Future<BaseResponse<List<TopUpOptionModel>>> getTopUpOptions() async {
    final mockJson = {
      "status": true,
      "code": 200,
      "message": "Success",
      "data": {
        "result": [
          {"amount": 5.0},
          {"amount": 10.0},
          {"amount": 20.0},
          {"amount": 30.0},
          {"amount": 50.0},
          {"amount": 75.0},
          {"amount": 100.0},
        ],
      },
    };

    return BaseResponse.fromJson(
      data: mockJson,
      decoder: (json) =>
          (json as List).map((e) => TopUpOptionModel.fromJson(e)).toList(),
    );
  }

  @override
  Future<BaseResponse<bool>> performTopUp(TopUpParams request) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final mockJson = {
      "status": true,
      "code": 200,
      "message": "Top-up successful",
      "data": {"result": true},
    };

    return BaseResponse.fromJson(
      data: mockJson,
      decoder: (json) => json as bool,
    );
  }
}
