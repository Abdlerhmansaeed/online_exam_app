// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../Features/auth/data/data_sources/auth_data_source.dart' as _i51;
import '../../Features/auth/data/data_sources/auth_data_source_imp.dart'
    as _i172;
import '../../Features/auth/data/repositories/auth_repo_imp.dart' as _i1013;
import '../../Features/auth/domain/repositories/auth_repo.dart' as _i1049;
import '../../Features/auth/domain/use_cases/forget_password_use_case.dart'
    as _i95;
import '../../Features/auth/domain/use_cases/login_use_case.dart' as _i747;
import '../../Features/auth/domain/use_cases/otp_reset_use_case.dart' as _i25;
import '../../Features/auth/domain/use_cases/reset_password_use_case.dart'
    as _i447;
import '../../Features/auth/domain/use_cases/signup_usecase.dart' as _i179;
import '../../Features/auth/presentation/manager/auth_cubit.dart' as _i239;
import '../../Features/home/data/data_source/home_tab_remote_data_source.dart'
    as _i250;
import '../../Features/home/data/repository/home_tab_impl.dart' as _i781;
import '../../Features/home/domain/repository/contract/home_tab_repo.dart'
    as _i577;
import '../../Features/home/domain/repository/data_source_contract/remote/hom_remote_data_source_cont.dart'
    as _i580;
import '../../Features/home/domain/use_case/home_tab_use_cse.dart' as _i174;
import '../services/network_srevices.dart' as _i82;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i82.NetworkServices>(() => _i82.NetworkServices());
    gh.factory<_i580.HomRemoteDataSourceContract>(
        () => _i250.HomeTabRemoteImpl());
    gh.factory<_i51.AuthDataSource>(
        () => _i172.AuthDataSourceImp(gh<_i82.NetworkServices>()));
    gh.factory<_i577.HomeTabRepoContract>(() => _i781.HomeTabImpl(
        remoteDataSourceContract: gh<_i580.HomRemoteDataSourceContract>()));
    gh.factory<_i1049.AuthRepo>(
        () => _i1013.AuthRepoImp(gh<_i51.AuthDataSource>()));
    gh.factory<_i174.GetAllSubjectsUseCase>(
        () => _i174.GetAllSubjectsUseCase(gh<_i577.HomeTabRepoContract>()));
    gh.factory<_i95.ForgetPasswordUseCase>(
        () => _i95.ForgetPasswordUseCase(gh<_i1049.AuthRepo>()));
    gh.factory<_i747.LoginUseCase>(
        () => _i747.LoginUseCase(gh<_i1049.AuthRepo>()));
    gh.factory<_i25.OtpResetUseCase>(
        () => _i25.OtpResetUseCase(gh<_i1049.AuthRepo>()));
    gh.factory<_i179.SignupUsecase>(
        () => _i179.SignupUsecase(gh<_i1049.AuthRepo>()));
    gh.factory<_i447.ResetPasswordUseCase>(
        () => _i447.ResetPasswordUseCase(authRepo: gh<_i1049.AuthRepo>()));
    gh.factory<_i239.AuthCubit>(() => _i239.AuthCubit(
          gh<_i747.LoginUseCase>(),
          gh<_i179.SignupUsecase>(),
          gh<_i95.ForgetPasswordUseCase>(),
          gh<_i25.OtpResetUseCase>(),
          gh<_i447.ResetPasswordUseCase>(),
        ));
    return this;
  }
}
