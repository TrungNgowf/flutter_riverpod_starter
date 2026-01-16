/// API Endpoints constants
/// Organize endpoints by feature/module for better maintainability
abstract class Endpoints {
  // Base paths
  static const String api = '/api';
  static const String v1 = '/v1';
  static const String v2 = '/v2';

  // Auth endpoints
  static const String auth = '$api/auth';
  static const String login = '$auth/login';
  static const String register = '$auth/register';
  static const String logout = '$auth/logout';
  static const String refreshToken = '$auth/refresh';
  static const String forgotPassword = '$auth/forgot-password';
  static const String resetPassword = '$auth/reset-password';
  static const String verifyEmail = '$auth/verify-email';
  static const String resendVerification = '$auth/resend-verification';

  // User endpoints
  static const String users = '$api/users';
  static const String profile = '$users/profile';
  static const String updateProfile = '$users/profile';
  static const String changePassword = '$users/change-password';
  static const String deleteAccount = '$users/delete';

  // Example feature endpoints (customize as needed)
  static const String posts = '$api/posts';
  static const String comments = '$api/comments';
  static const String notifications = '$api/notifications';

  // Songs
  static const String songs = '$api/$v1/songs';
  static const String song = '$songs/:id';
}

/// Query parameters constants
abstract class QueryParams {
  static const String page = 'page';
  static const String perPage = 'per_page';
  static const String search = 'search';
  static const String sortBy = 'sort_by';
  static const String sortOrder = 'sort_order';
  static const String filter = 'filter';
}

/// Header constants
abstract class HttpHeaders {
  static const String authorization = 'Authorization';
  static const String contentType = 'Content-Type';
  static const String accept = 'Accept';
  static const String acceptLanguage = 'Accept-Language';
  static const String userAgent = 'User-Agent';
  static const String deviceId = 'X-Device-Id';
  static const String appVersion = 'X-App-Version';
  static const String platform = 'X-Platform';
}

/// Content types
abstract class ContentTypes {
  static const String json = 'application/json';
  static const String formUrlEncoded = 'application/x-www-form-urlencoded';
  static const String multipartFormData = 'multipart/form-data';
}
