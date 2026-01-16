import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'token_manager.g.dart';

/// Token data model
class TokenData {
  final String accessToken;
  final String? refreshToken;
  final DateTime? expiresAt;

  const TokenData({
    required this.accessToken,
    this.refreshToken,
    this.expiresAt,
  });

  bool get isExpired {
    if (expiresAt == null) return false;
    // Consider token expired 30 seconds before actual expiry
    return DateTime.now().isAfter(
      expiresAt!.subtract(const Duration(seconds: 30)),
    );
  }

  TokenData copyWith({
    String? accessToken,
    String? refreshToken,
    DateTime? expiresAt,
  }) {
    return TokenData(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }
}

/// Provider for TokenManager
@Riverpod(keepAlive: true)
TokenManager tokenManager(Ref ref) {
  return TokenManager();
}

/// Manages authentication tokens
///
/// Note: For production, integrate with secure storage (flutter_secure_storage)
/// This is a basic implementation that can be extended
class TokenManager {
  TokenData? _tokenData;

  /// Get current access token
  String? get accessToken => _tokenData?.accessToken;

  /// Get current refresh token
  String? get refreshToken => _tokenData?.refreshToken;

  /// Check if user has a valid token
  bool get hasValidToken => _tokenData != null && !_tokenData!.isExpired;

  /// Check if token is expired
  bool get isTokenExpired => _tokenData?.isExpired ?? true;

  /// Check if user is authenticated
  bool get isAuthenticated => _tokenData != null;

  /// Set tokens after login/refresh
  Future<void> setTokens({
    required String accessToken,
    String? refreshToken,
    DateTime? expiresAt,
  }) async {
    _tokenData = TokenData(
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiresAt: expiresAt,
    );

    // TODO: Persist to secure storage
    // await _secureStorage.write(key: 'access_token', value: accessToken);
    // await _secureStorage.write(key: 'refresh_token', value: refreshToken);
  }

  /// Update only the access token (after refresh)
  Future<void> updateAccessToken({
    required String accessToken,
    DateTime? expiresAt,
  }) async {
    if (_tokenData != null) {
      _tokenData = _tokenData!.copyWith(
        accessToken: accessToken,
        expiresAt: expiresAt,
      );

      // TODO: Persist to secure storage
    }
  }

  /// Clear all tokens (logout)
  Future<void> clearTokens() async {
    _tokenData = null;

    // TODO: Clear from secure storage
    // await _secureStorage.delete(key: 'access_token');
    // await _secureStorage.delete(key: 'refresh_token');
  }

  /// Load tokens from storage (call on app startup)
  Future<void> loadTokens() async {
    // TODO: Load from secure storage
    // final accessToken = await _secureStorage.read(key: 'access_token');
    // final refreshToken = await _secureStorage.read(key: 'refresh_token');
    // if (accessToken != null) {
    //   _tokenData = TokenData(
    //     accessToken: accessToken,
    //     refreshToken: refreshToken,
    //   );
    // }
  }
}
