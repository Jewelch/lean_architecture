import 'package:lean_requester/lean_requester.dart';

class JwtAuthentication implements AuthenticationStrategy {
  @override
  Future<Map<String, dynamic>> getAuthorizationHeader() async {
    final token = 'RSS99CERGRH242XVC2221LKM';
    return cachedHeaders ??= {'Authorization': 'Bearer $token'};
  }

  @override
  void invalidateAuthenticationHeadersWhen(bool Function() condition) {}

  @override
  Map<String, dynamic>? get cachedHeaders => {};

  @override
  set cachedHeaders(Map<String, dynamic>? value) {}
}
