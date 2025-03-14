// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
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
import '../../Features/exams/data/data_sources/local_data_source/exam_local_data_base.dart'
    as _i486;
import '../../Features/exams/data/data_sources/remote_data_source/exam_remote_data_source.dart'
    as _i551;
import '../../Features/exams/data/data_sources/remote_data_source/exam_remote_data_source_impl.dart'
    as _i583;
import '../../Features/exams/data/repositories/exam_repo_impl.dart' as _i846;
import '../../Features/exams/domain/repositories/exam_repo.dart' as _i334;
import '../../Features/exams/domain/use_cases/check_user_answers_use_case.dart'
    as _i345;
import '../../Features/exams/domain/use_cases/exam_quetions_use_case.dart'
    as _i590;
import '../../Features/exams/presentation/manager/exam_veiw_model.dart'
    as _i337;
import '../../Features/home/data/data_source/home_tab_remote_data_source.dart'
    as _i250;
import '../../Features/home/data/repository/home_tab_impl.dart' as _i781;
import '../../Features/home/domain/repository/contract/home_tab_repo.dart'
    as _i577;
import '../../Features/home/domain/repository/data_source_contract/remote/home_remote_data_source_cont.dart'
    as _i898;
import '../../Features/home/domain/use_case/get_exams_on_subject_use_case.dart'
    as _i259;
import '../../Features/home/domain/use_case/home_tab_use_cse.dart' as _i174;
import '../../Features/home/presentation/cubit/home_cubit.dart' as _i996;
import '../../Features/user_profile/data/data_sources/user_profile_remote_data_source.dart'
    as _i379;
import '../../Features/user_profile/data/data_sources/user_profile_remote_data_source_impl.dart'
    as _i883;
import '../../Features/user_profile/data/repositories/user_profile_repo_impl.dart'
    as _i242;
import '../../Features/user_profile/domain/repositories/user_profile_repo.dart'
    as _i464;
import '../../Features/user_profile/domain/use_cases/change_user_password_use_case.dart'
    as _i197;
import '../../Features/user_profile/domain/use_cases/edit_profile_use_case.dart'
    as _i583;
import '../../Features/user_profile/domain/use_cases/get_user_profile_use_case.dart'
    as _i100;
import '../../Features/user_profile/presentation/manager/profile_view_model_cubit.dart'
    as _i604;
import '../services/dio_module.dart' as _i870;
import '../services/hive_local_storage.dart' as _i46;
import '../services/web_services.dart' as _i460;

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
    final dioModule = _$DioModule();
    gh.factory<int>(() => _i870.DioModule.connectionTimeOut);
    gh.factory<_i46.HiveLocalStorage>(() => _i46.HiveLocalStorage());
    gh.singleton<_i361.LogInterceptor>(() => dioModule.provideLogger());
    gh.factory<_i486.ExamLocalDataSource>(
        () => _i486.ExamLocalDataSource(gh<_i46.HiveLocalStorage>()));
    gh.factory<_i51.AuthDataSource>(() => _i172.AuthDataSourceImp());
    gh.factory<_i898.HomRemoteDataSourceContract>(
        () => _i250.HomeTabRemoteImpl());
    gh.singleton<_i361.Dio>(
        () => dioModule.provideDio(gh<_i361.LogInterceptor>()));
    gh.factory<_i577.HomeTabRepoContract>(() => _i781.HomeTabImpl(
        remoteDataSourceContract: gh<_i898.HomRemoteDataSourceContract>()));
    gh.factory<_i1049.AuthRepo>(
        () => _i1013.AuthRepoImp(gh<_i51.AuthDataSource>()));
    gh.singleton<_i460.WebServices>(
        () => dioModule.provideWebServices(gh<_i361.Dio>()));
    gh.factory<_i95.ForgetPasswordUseCase>(
        () => _i95.ForgetPasswordUseCase(gh<_i1049.AuthRepo>()));
    gh.factory<_i747.LoginUseCase>(
        () => _i747.LoginUseCase(gh<_i1049.AuthRepo>()));
    gh.factory<_i25.OtpResetUseCase>(
        () => _i25.OtpResetUseCase(gh<_i1049.AuthRepo>()));
    gh.factory<_i179.SignupUseCase>(
        () => _i179.SignupUseCase(gh<_i1049.AuthRepo>()));
    gh.factory<_i174.GetAllSubjectsUseCase>(
        () => _i174.GetAllSubjectsUseCase(gh<_i577.HomeTabRepoContract>()));
    gh.factory<_i551.ExamRemoteDataSource>(
        () => _i583.ExamRemoteDataSourceImpl(gh<_i460.WebServices>()));
    gh.factory<_i259.GetExamsOnSubjectUseCase>(
        () => _i259.GetExamsOnSubjectUseCase(gh<_i577.HomeTabRepoContract>()));
    gh.factory<_i379.UserProfileRemoteDataSource>(
        () => _i883.UserProfileRemoteDataSourceImpl(gh<_i460.WebServices>()));
    gh.factory<_i464.UserProfileRepo>(() => _i242.UserProfileRepoImpl(
        userProfileRemoteDataSource: gh<_i379.UserProfileRemoteDataSource>()));
    gh.factory<_i447.ResetPasswordUseCase>(
        () => _i447.ResetPasswordUseCase(authRepo: gh<_i1049.AuthRepo>()));
    gh.factory<_i197.ChangeUserPasswordUseCase>(
        () => _i197.ChangeUserPasswordUseCase(gh<_i464.UserProfileRepo>()));
    gh.factory<_i583.EditProfileUseCase>(
        () => _i583.EditProfileUseCase(gh<_i464.UserProfileRepo>()));
    gh.factory<_i334.ExamRepo>(() => _i846.ExamRepoImpl(
        examRemoteDataSource: gh<_i551.ExamRemoteDataSource>()));
    gh.factory<_i996.HomeCubit>(() => _i996.HomeCubit(
          gh<_i174.GetAllSubjectsUseCase>(),
          gh<_i259.GetExamsOnSubjectUseCase>(),
        ));
    gh.factory<_i239.AuthCubit>(() => _i239.AuthCubit(
          gh<_i747.LoginUseCase>(),
          gh<_i179.SignupUseCase>(),
          gh<_i95.ForgetPasswordUseCase>(),
          gh<_i25.OtpResetUseCase>(),
          gh<_i447.ResetPasswordUseCase>(),
        ));
    gh.factory<_i590.ExamQuestionsUseCase>(
        () => _i590.ExamQuestionsUseCase(gh<_i334.ExamRepo>()));
    gh.factory<_i345.CheckUserAnswersUseCase>(
        () => _i345.CheckUserAnswersUseCase(gh<_i334.ExamRepo>()));
    gh.factory<_i100.GetUserProfileUseCase>(() => _i100.GetUserProfileUseCase(
        userProfileRepo: gh<_i464.UserProfileRepo>()));
    gh.factory<_i337.ExamViewModel>(() => _i337.ExamViewModel(
          gh<_i590.ExamQuestionsUseCase>(),
          gh<_i486.ExamLocalDataSource>(),
          gh<_i345.CheckUserAnswersUseCase>(),
        ));
    gh.factory<_i604.ProfileViewModelCubit>(() => _i604.ProfileViewModelCubit(
          gh<_i100.GetUserProfileUseCase>(),
          gh<_i197.ChangeUserPasswordUseCase>(),
          gh<_i583.EditProfileUseCase>(),
        ));
    return this;
  }
}

class _$DioModule extends _i870.DioModule {}
