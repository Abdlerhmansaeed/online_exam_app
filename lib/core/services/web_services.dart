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

  @POST(ApiConstants.signInEndPoint)
  Future<RegisterResponse> login(@Body() LoginRequest data);

  @POST(ApiConstants.signupEndPoint)
  Future<RegisterResponse> signup(@Body() SignUpRequest data);

  @POST(ApiConstants.forgotPasswordEndPoint)
  Future<ResetPasswordVerify> forgetPasswordEmailVerify(
      @Body() ForgetPasswordEmailRequest data);

  @PUT(ApiConstants.resetPasswordEndPoint)
  Future<ResetPasswordResponse> resetPassword(
      @Body() ResetPasswordRequest data);

  @POST(ApiConstants.verifyResetCodeEndPoint)
  Future<OtpCodeResponse> resetCodeVerify(@Body() OtpCodeVerifyRequset data);

  @GET(ApiConstants.allSubjectsEndPoint)
  Future<GetSubjectsResponse> getAllSubjects();

  @GET(ApiConstants.examsEndPoint)
  Future<GetExamsOnSubject> getExamsOnSubject(
      @Query("subject") String subjectId);

  @GET(ApiConstants.questionEndPoint)
  Future<ExamQuestionsResponse> getExamsQuestions(@Query("exam") String examId);

  @POST(ApiConstants.checkAnswerEndPoint)
  Future<CheckQuestionsResponse> checkAnswers(
      @Body() CheckQuestionsRequest data);

  @GET(ApiConstants.getUserDetailsEndPoint)
  Future<GetUserProfileResponse> getUserDetails();

  @PUT(ApiConstants.editUserDetailsEndPoint)
  Future<EditProfileResponse> editUserDetails(@Body() EditProfileRequest data);

  @PATCH(ApiConstants.changePasswordEndPoint)
  Future<ChangePasswordResponse> changePassword(
      @Body() ChangePasswordRequest data);
}
