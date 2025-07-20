// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:finance_house_assessment/core/data/datasource/base_remote_datasource.dart'
    as _i951;
import 'package:finance_house_assessment/core/data/datasource/theme_local_datasource.dart'
    as _i346;
import 'package:finance_house_assessment/core/presentation/blocs/authentication/authentication_cubit.dart'
    as _i695;
import 'package:finance_house_assessment/core/presentation/blocs/theme_bloc/theme_bloc.dart'
    as _i809;
import 'package:finance_house_assessment/core/utils/handler/auth_handler.dart'
    as _i815;
import 'package:finance_house_assessment/di/modules/injectable_module.dart'
    as _i414;
import 'package:finance_house_assessment/features/beneficiary/data/remote_datasource/beneficiary_remote_datasource.dart'
    as _i635;
import 'package:finance_house_assessment/features/beneficiary/data/remote_datasource/beneficiary_remote_datasource_impl.dart'
    as _i560;
import 'package:finance_house_assessment/features/beneficiary/data/repository/beneficiary_repository_impl.dart'
    as _i265;
import 'package:finance_house_assessment/features/beneficiary/domain/repository/beneficiary_repository.dart'
    as _i484;
import 'package:finance_house_assessment/features/beneficiary/domain/usecase/active_beneficiary_usecase.dart'
    as _i978;
import 'package:finance_house_assessment/features/beneficiary/domain/usecase/add_beneficiary_usecase.dart'
    as _i582;
import 'package:finance_house_assessment/features/beneficiary/domain/usecase/delete_beneficiary_usecase.dart'
    as _i937;
import 'package:finance_house_assessment/features/beneficiary/domain/usecase/get_beneficiaries_list_usecase.dart'
    as _i705;
import 'package:finance_house_assessment/features/beneficiary/domain/usecase/get_user_usecase.dart'
    as _i25;
import 'package:finance_house_assessment/features/home/data/remote_datasource/home_remote_datasource.dart'
    as _i859;
import 'package:finance_house_assessment/features/home/data/remote_datasource/home_remote_datasource_impl.dart'
    as _i662;
import 'package:finance_house_assessment/features/home/data/repository/home_repository_impl.dart'
    as _i248;
import 'package:finance_house_assessment/features/home/domain/repository/home_repository.dart'
    as _i684;
import 'package:finance_house_assessment/features/home/domain/usecase/get_top_up_option_list_usecase.dart'
    as _i607;
import 'package:finance_house_assessment/features/home/domain/usecase/perform_topup_usecase.dart'
    as _i488;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final injectableModule = _$InjectableModule();
    gh.singleton<_i815.AuthHandler>(() => _i815.AuthHandler());
    gh.lazySingleton<_i973.InternetConnectionChecker>(
      () => injectableModule.connectionChecker,
    );
    await gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => injectableModule.sharedPref,
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(() => injectableModule.dioInstance);
    gh.singleton<_i695.AuthenticationCubit>(
      () => _i695.AuthenticationCubit(gh<_i815.AuthHandler>()),
    );
    gh.lazySingleton<_i346.ThemeLocalDataSource>(
      () => _i346.ThemeLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.singleton<_i809.ThemeBloc>(
      () => _i809.ThemeBloc(
        themeLocalDataSource: gh<_i346.ThemeLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i951.BaseRemoteDataSourceImpl>(
      () => _i951.BaseRemoteDataSourceImpl(dio: gh<_i361.Dio>()),
    );
    gh.singleton<_i859.HomeRemoteDataSource>(
      () => _i662.HomeRemoteDataSourceImpl(dio: gh<_i361.Dio>()),
    );
    gh.singleton<_i635.BeneficiaryRemoteDataSource>(
      () => _i560.BeneficiaryRemoteDataSourceImpl(dio: gh<_i361.Dio>()),
    );
    gh.singleton<_i484.BeneficiaryRepository>(
      () => _i265.BeneficiaryRepositoryImpl(
        gh<_i635.BeneficiaryRemoteDataSource>(),
      ),
    );
    gh.factory<_i582.AddBeneficiaryUseCase>(
      () => _i582.AddBeneficiaryUseCase(
        repository: gh<_i484.BeneficiaryRepository>(),
      ),
    );
    gh.factory<_i937.DeleteBeneficiaryUseCase>(
      () => _i937.DeleteBeneficiaryUseCase(
        repository: gh<_i484.BeneficiaryRepository>(),
      ),
    );
    gh.factory<_i705.GetBeneficiariesUseCase>(
      () => _i705.GetBeneficiariesUseCase(
        repository: gh<_i484.BeneficiaryRepository>(),
      ),
    );
    gh.factory<_i25.GetUserInfoUseCase>(
      () => _i25.GetUserInfoUseCase(
        repository: gh<_i484.BeneficiaryRepository>(),
      ),
    );
    gh.factory<_i978.ActiveBeneficiaryUseCase>(
      () => _i978.ActiveBeneficiaryUseCase(
        repository: gh<_i484.BeneficiaryRepository>(),
      ),
    );
    gh.singleton<_i684.HomeRepository>(
      () => _i248.HomeRepositoryImpl(gh<_i859.HomeRemoteDataSource>()),
    );
    gh.factory<_i607.GetTopUpOptionsListUseCase>(
      () => _i607.GetTopUpOptionsListUseCase(
        repository: gh<_i684.HomeRepository>(),
      ),
    );
    gh.factory<_i488.PerformTopUpUseCase>(
      () => _i488.PerformTopUpUseCase(repository: gh<_i684.HomeRepository>()),
    );
    return this;
  }
}

class _$InjectableModule extends _i414.InjectableModule {}
