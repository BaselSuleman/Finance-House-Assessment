import 'package:finance_house_assessment/features/beneficiary/data/model/beneficiaryModel.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repository/beneficiary_repository.dart';
import '../model/user_model.dart';
import '../remote_datasource/beneficiary_remote_datasource.dart';

@Singleton(as: BeneficiaryRepository)
class BeneficiaryRepositoryImpl implements BeneficiaryRepository {
  final BeneficiaryRemoteDataSource dataSource;

  const BeneficiaryRepositoryImpl(this.dataSource);

  @override
  Future<UserModel> getUserData() async {
    final res = await dataSource.getUserData();
    return res.data!;
  }

  @override
  Future<BeneficiaryModel> addBeneficiary(BeneficiaryModel beneficiary) async {
    final res = await dataSource.addBeneficiary(beneficiary);
    return res.data!;
  }

  @override
  Future<BeneficiaryModel> deleteBeneficiary(BeneficiaryModel item) async {
    final res = await dataSource.deleteBeneficiary(item);
    return res.data!;
  }
  @override
  Future<BeneficiaryModel> activeBeneficiary(BeneficiaryModel item) async {
    final res = await dataSource.activateBeneficiary(item);
    return res.data!;
  }
  @override
  Future<List<BeneficiaryModel>> getBeneficiaries() async {
    final res = await dataSource.getBeneficiaries();
    return res.data!;
  }

}
