import '../../../../../core/data/model/base_response_model.dart';
import '../model/beneficiaryModel.dart';
import '../model/user_model.dart';

abstract class BeneficiaryRemoteDataSource {
  Future<BaseResponse<UserModel>> getUserData();

  Future<BaseResponse<List<BeneficiaryModel>>> getBeneficiaries();

  Future<BaseResponse<BeneficiaryModel>> addBeneficiary(
    BeneficiaryModel beneficiary,
  );

  Future<BaseResponse<BeneficiaryModel>> deleteBeneficiary(
    BeneficiaryModel item,
  );

  Future<BaseResponse<BeneficiaryModel>> activateBeneficiary(
    BeneficiaryModel item,
  );
}
