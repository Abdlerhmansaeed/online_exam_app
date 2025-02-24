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
    gh.factory<_i51.AuthDataSource>(
        () => _i172.AuthDataSourceImp(gh<_i82.NetworkServices>()));
    gh.factory<_i1049.AuthRepo>(
        () => _i1013.AuthRepoImp(gh<_i51.AuthDataSource>()));
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
