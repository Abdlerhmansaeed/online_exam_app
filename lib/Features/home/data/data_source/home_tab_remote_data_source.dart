import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/home/domain/entity/all_exams_entity.dart';
import 'package:online_exam_app/Features/home/domain/repository/data_source_contract/remote/hom_remote_data_source_cont.dart';
import 'package:online_exam_app/core/Constant/app_constant.dart';
import 'package:online_exam_app/core/Error/failure.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@Injectable(as: HomRemoteDataSourceContract)
class HomeTabRemoteImpl implements HomRemoteDataSourceContract {
  @override
  Future<Either<Failures, ExamsEntity>> getAllExams() async {
    Dio dio = Dio();
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ));
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      final response = await dio.get(AppConstant.allExamsEndPoint);
      if (response.statusCode == 200) {
        return Right(response.data);
      } else {
        return Left(ServerFailure(errorMessage: response.statusMessage!));
      }
    }else{
      return const Left(NetWorkError(errorMessage: "No Internet Connection"));
    }
  }
}
