import 'package:equatable/equatable.dart';

/// Entity containing an authorization token and a refresh token.
///
/// This model is used by the AuthenticationService and TokenRepository to
/// save both these tokens in a single representation.
class Token extends Equatable {
  /// Creates a new [Token] entity
  const Token({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
  });

  /// The access token.
  final String accessToken;

  /// The refresh token.
  final String refreshToken;

  /// The date the token expires.
  final DateTime expiresAt;

  /// Returns true if the token is expired.
  bool get isExpired => DateTime.now().isAfter(expiresAt);

  @override
  List<Object?> get props => <Object?>[accessToken, refreshToken, expiresAt];
}
