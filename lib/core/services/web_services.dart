import 'package:dio/dio.dart';
import 'package:online_exam_app/Features/auth/data/models/request_model/forget_password_email_request.dart';
import 'package:online_exam_app/Features/auth/data/models/request_model/login_request.dart';
import 'package:online_exam_app/Features/auth/data/models/request_model/otp_code_verify_request.dart';
import 'package:online_exam_app/Features/auth/data/models/request_model/reset_passowrd_request.dart';
import 'package:online_exam_app/Features/auth/data/models/request_model/signup_request.dart';
import 'package:online_exam_app/Features/exams/data/models/exam_questions_response.dart';
import 'package:online_exam_app/Features/user_profile/data/models/change_password_response.dart';
import 'package:online_exam_app/Features/user_profile/data/models/edit_profile_response.dart';
import 'package:online_exam_app/Features/user_profile/data/models/get_user_profile_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../Features/auth/data/models/response/otp_code_response.dart';
import '../../Features/auth/data/models/response/register_response.dart';
import '../../Features/auth/data/models/response/reset_password.dart';
import '../../Features/auth/data/models/response/reset_password_verify.dart';
import '../../Features/exams/data/models/check_questions_request.dart';
import '../../Features/exams/data/models/check_questions_response.dart';
import '../../Features/home/data/model/get_exams_on_subject.dart';
import '../../Features/home/data/model/get_subjects_response.dart';
import '../../Features/user_profile/data/models/change_password_request.dart';
import '../../Features/user_profile/data/models/edit_profile_request.dart';
import '../Constant/app_constant.dart';

part 'web_services.g.dart';

@RestApi()
abstract class WebServices {
  factory WebServices(Dio dio) = _WebServices;

  @POST(AppConstant.signInEndPoint)
  Future<RegisterResponse> login(@Body() LoginRequest data);

  @POST(AppConstant.signupEndPoint)
  Future<RegisterResponse> signup(@Body() SignUpRequest data);

  @POST(AppConstant.forgotPasswordEndPoint)
  Future<ResetPasswordVerify> forgetPasswordEmailVerify(
      @Body() ForgetPasswordEmailRequest data);

  @POST(AppConstant.resetPasswordEndPoint)
  Future<ResetPasswordResponse> resetPassword(
      @Body() ResetPasswordRequest data);

  @POST(AppConstant.verifyResetCodeEndPoint)
  Future<OtpCodeResponse> resetCodeVerify(@Body() OtpCodeVerifyRequset data);

  @GET(AppConstant.allSubjectsEndPoint)
  Future<GetSubjectsResponse> getAllSubjects(@Header("token") String token);

  @GET(AppConstant.examsEndPoint)
  Future<GetExamsOnSubject> getExamsOnSubject(
    @Query("subject") String subjectId,
    @Header("token") String token,
  );
  @GET(AppConstant.questionEndPoint)
  Future<ExamQuestionsResponse> getExamsQuestions(
    @Header("token") String token,
    @Query("exam") String examId,
  );

  @POST(AppConstant.checkAnswerEndPoint)
  Future<CheckQuestionsResponse> checkAnswers(
      @Header('token') String token, @Body() CheckQuestionsRequest data);

  @GET(AppConstant.getUserDetailsEndPoint)
  Future<GetUserProfileResponse> getUserDetails(@Header("token") String token);
  @PUT(AppConstant.editUserDetailsEndPoint)
  Future<EditProfileResponse> editUserDetails(
      @Header("token") String token, @Body() EditProfileRequest data);
  
  @PATCH(AppConstant.changePasswordEndPoint)
  Future<ChangePasswordResponse> changePassword(
    @Header("token") String token,
    @Body() ChangePasswordRequest data,
  );
}
