import 'package:injectable/injectable.dart';

import '../../../../../core/data/datasource/base_remote_datasource.dart';
import '../../../../../core/data/model/base_response_model.dart';
import '../../../../core/utils/constants.dart';
import '../model/beneficiaryModel.dart';
import '../model/user_model.dart';
import 'beneficiary_remote_datasource.dart';

@Singleton(as: BeneficiaryRemoteDataSource)
class BeneficiaryRemoteDataSourceImpl extends BaseRemoteDataSourceImpl
    implements BeneficiaryRemoteDataSource {
  String getUserBEndPoint = '${AppConstant.baseUrl}/api/app/user/info';
  String getAddBeneficiaryEndPoint =
      '${AppConstant.baseUrl}/api/app/beneficiary/add';
  String getDeleteBeneficiaryEndPoint =
      '${AppConstant.baseUrl}/api/app/beneficiary/delete';
  String activateBeneficiaryEndPoint =
      '${AppConstant.baseUrl}/api/app/beneficiary/active';

  BeneficiaryRemoteDataSourceImpl({required super.dio});

  @override
  Future<BaseResponse<UserModel>> getUserData() async {
    // final res = await get(
    //   url: getUserBEndPoint,
    //   decoder: (json) => UserModel.fromJson(json),
    //   requiredToken: true,
    // );

    final mockJson = {
      "status": true,
      "code": 200,
      "message": "Success",
      "data": {
        "result": {
          "id": "u1",
          "name": "Bassel",
          "phone": "+971557557560",
          "balance": 10000,
          "isVerified": true,
          "totalTopUpAmountThisMonth": 0,
        },
      },
    };

    return BaseResponse.fromJson(
      data: mockJson,
      decoder: (json) => UserModel.fromJson(json),
    );
  }

  @override
  Future<BaseResponse<BeneficiaryModel>> addBeneficiary(
    BeneficiaryModel beneficiary,
  ) async {
    // final res = await post(
    //   url: getAddBeneficiaryEndPoint,
    //   decoder: (json) => BeneficiaryModel.fromJson(json),
    //   requiredToken: true,
    // );
    final beneficiaryMockJson = {
      "status": true,
      "code": 200,
      "message": "Success",
      "data": {
        "result": {
          "id": beneficiary.id,
          "nickname": beneficiary.nickname,
          "phoneNumber": beneficiary.phoneNumber,
          "active": beneficiary.active,
          "topUpAmountThisMonth": 0,
        },
      },
    };
    return BaseResponse.fromJson(
      data: beneficiaryMockJson,
      decoder: (json) => BeneficiaryModel.fromJson(json),
    );
  }

  @override
  Future<BaseResponse<BeneficiaryModel>> deleteBeneficiary(
    BeneficiaryModel beneficiary,
  ) async {
    // final res = await post(
    //   url: getDeleteBeneficiaryEndPoint,
    //   decoder: (json) => BeneficiaryModel.fromJson(json),
    //   requiredToken: true,
    // );
    final beneficiaryMockJson = {
      "status": true,
      "code": 200,
      "message": "Success",
      "data": {
        "result": {
          "id": beneficiary.id,
          "active": beneficiary.active,
          "nickname": beneficiary.nickname,
          "phoneNumber": beneficiary.phoneNumber,
          "topUpAmountThisMonth": 0,
        },
      },
    };
    return BaseResponse.fromJson(
      data: beneficiaryMockJson,
      decoder: (json) => BeneficiaryModel.fromJson(json),
    );
  }

  @override
  Future<BaseResponse<List<BeneficiaryModel>>> getBeneficiaries() async {
    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    final mockJson = {
      "status": true,
      "code": 200,
      "message": "Success",
      "data": {
        "result": [
          {
            "id": "1",
            "nickname": "Beneficiary One",
            "phoneNumber": "+123456789",
            "active": true,
            "topUps":[]
          },
          {
            "id": "2",
            "nickname": "Beneficiary Two",
            "phoneNumber": "+987654321",
            "active": true,
            "topUps":[]
          },
        ],
      },
    };

    return BaseResponse.fromJson(
      data: mockJson,
      decoder: (json) =>
          (json as List).map((e) => BeneficiaryModel.fromJson(e)).toList(),
    );
  }

  @override
  Future<BaseResponse<BeneficiaryModel>> activateBeneficiary(
    BeneficiaryModel beneficiary,
  )async {
    final beneficiaryMockJson = {
      "status": true,
      "code": 200,
      "message": "Success",
      "data": {
        "result": {
          "id": beneficiary.id,
          "active": beneficiary.active,
          "nickname": beneficiary.nickname,
          "phoneNumber": beneficiary.phoneNumber,
          "topUpAmountThisMonth": 0,
        },
      },
    };
    return BaseResponse.fromJson(
      data: beneficiaryMockJson,
      decoder: (json) => BeneficiaryModel.fromJson(json),
    );
  }
}
