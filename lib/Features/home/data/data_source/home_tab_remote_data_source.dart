import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/home/data/model/get_subjects_response.dart';
import 'package:online_exam_app/Features/home/domain/repository/data_source_contract/remote/home_remote_data_source_cont.dart';
import 'package:online_exam_app/core/di/di.dart';
import 'package:online_exam_app/core/helper/api_result.dart';
import 'package:online_exam_app/core/helper/retrofit_handler.dart';
import 'package:online_exam_app/core/services/web_services.dart';

@Injectable(as: HomRemoteDataSourceContract)
class HomeTabRemoteImpl implements HomRemoteDataSourceContract {
  final webServices = getIt<WebServices>();

  @override
  Future<ApiResult <GetSubjectsResponse>> getAllSubjects() async {
    return await RetrofitHandler.handle(() => webServices.getAllSubjects());
  }

}