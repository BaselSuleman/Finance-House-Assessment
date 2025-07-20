import '../../data/model/beneficiaryModel.dart';
import '../../data/model/user_model.dart';

abstract class BeneficiaryRepository {
  Future<UserModel> getUserData();

  Future<BeneficiaryModel> addBeneficiary(BeneficiaryModel beneficiary);

  Future<BeneficiaryModel> deleteBeneficiary(BeneficiaryModel item);

  Future<BeneficiaryModel> activeBeneficiary(BeneficiaryModel item);

  Future<List<BeneficiaryModel>> getBeneficiaries();
}
