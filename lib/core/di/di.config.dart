// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../Features/home/data/data_source/home_tab_remote_data_source.dart'
    as _i250;
import '../../Features/home/data/repository/home_tab_impl.dart' as _i781;
import '../../Features/home/domain/repository/contract/home_tab_repo.dart'
    as _i577;
import '../../Features/home/domain/repository/data_source_contract/remote/hom_remote_data_source_cont.dart'
    as _i580;
import '../../Features/home/domain/use_case/home_tab_use_cse.dart'
    as _i242;

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
    gh.factory<_i580.HomRemoteDataSourceContract>(
        () => _i250.HomeTabRemoteImpl());
    gh.factory<_i577.HomeTabRepoContract>(() => _i781.HomeTabImpl(
        remoteDataSourceContract: gh<_i580.HomRemoteDataSourceContract>()));
    gh.factory<_i242.GetAllExamsUseCase>(
        () => _i242.GetAllExamsUseCase(gh<_i577.HomeTabRepoContract>()));
    return this;
  }
}
