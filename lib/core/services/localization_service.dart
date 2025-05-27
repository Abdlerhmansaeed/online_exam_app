import 'package:shared_preferences/shared_preferences.dart';

class ApiLocalizationService {
  static final ApiLocalizationService _instance = ApiLocalizationService._();
  factory ApiLocalizationService() => _instance;
  ApiLocalizationService._();

  String _currentLanguage = 'en';

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _currentLanguage = prefs.getString('language') ?? 'en';
  }

  Future<void> setLanguage(String lang) async {
    if (lang != 'ar' && lang != 'en') return;
    _currentLanguage = lang;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', lang);
  }

  bool get isArabic => _currentLanguage == 'ar';

  String translate(String key, [Map<String, String>? params]) {
    final text = isArabic ? _arabicMessages[key] : _englishMessages[key] ?? key;

    if (params != null && params.isNotEmpty) {
      String result = text ?? '';
      params.forEach((key, value) {
        result = result.replaceAll('{$key}', value);
      });
      return result;
    }

    return text ?? '';
  }

  static const Map<String, String> _arabicMessages = {
    'errors.no_internet':
        'لا يوجد اتصال بالإنترنت. يرجى التحقق من شبكتك والمحاولة مرة أخرى.',
    'errors.socket_exception':
        'مشكلة في الاتصال بالخادم. يرجى التحقق من الإنترنت.',
    'errors.format_exception': 'تعذر قراءة البيانات المستلمة.',
    'errors.timeout': 'انتهت مدة الانتظار. يرجى المحاولة مرة أخرى.',
    'errors.unexpected_error': 'حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.',
    'errors.request_cancelled': 'تم إلغاء الطلب.',
    'errors.connection_error': 'خطأ في الاتصال بالشبكة.',
    'errors.unauthorized': 'فشل تسجيل الدخول. يرجى المحاولة مرة أخرى.',
    'errors.forbidden': 'لا تملك صلاحية الوصول.',
    'errors.not_found': 'لم يتم العثور على البيانات المطلوبة.',
    'errors.server_error': 'خطأ في الخادم. يرجى المحاولة لاحقاً.',
    'errors.validation': 'البيانات المدخلة غير صحيحة.',
    'errors.bad_request': 'طلب غير صحيح.',
    'errors.unknown': 'حدث خطأ: {message}',
    'errors.status_code': 'حدث خطأ (كود: {status}).',
  };

  static const Map<String, String> _englishMessages = {
    'errors.no_internet':
        'No internet connection. Please check your network and try again.',
    'errors.socket_exception':
        'Connection problem. Please check your internet.',
    'errors.format_exception': 'Could not read the received data.',
    'errors.timeout': 'Connection timeout. Please try again.',
    'errors.unexpected_error':
        'An unexpected error occurred. Please try again.',
    'errors.request_cancelled': 'Request was cancelled.',
    'errors.connection_error': 'Connection error \n please check your network.',
    'errors.unauthorized': 'Login failed. Please try again.',
    'errors.forbidden': 'You do not have permission to access.',
    'errors.not_found': 'Requested data was not found.',
    'errors.server_error': 'Server error. Please try again later.',
    'errors.validation': 'The provided data is invalid.',
    'errors.bad_request': 'Invalid request.',
    'errors.unknown': 'Error occurred: {message}',
    'errors.status_code': 'Error occurred (code: {status}).',
  };
}
