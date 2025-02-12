import 'dart:math';

import 'package:cg_core_defs/helpers/debugging_printer.dart';
import 'package:lean_requester/lean_requester.dart';

class JwtAuthentication extends AuthenticationStrategy {
  JwtAuthentication();

  Map<String, dynamic> _cachedHeaders = {};
  DateTime? _tokenExpiry;

  @override
  Future<Map<String, dynamic>> getAuthorizationHeader() async {
    Debugger.white('Actual time: ${DateTime.now().toLocal().toString().split(' ')[1].substring(0, 8)}');

    if (_isTokenExpired()) {
      Debugger.red('Token expired. Generating a new token...');
      String newToken = _generateRandomToken();
      _cachedHeaders = {'Authorization': 'Bearer $newToken'};
      _tokenExpiry = DateTime.now().add(const Duration(seconds: 7));
      Debugger.white('New token generated: $newToken');
    } else {
      Debugger.green('Token is still valid. Current headers: $_cachedHeaders');
    }
    Debugger.black('Token will expire at: ${_tokenExpiry?.toLocal().toString().split(' ')[1].substring(0, 8)}');

    return _cachedHeaders;
  }

  bool _isTokenExpired() => (_cachedHeaders.isEmpty || _tokenExpiry == null) || DateTime.now().isAfter(_tokenExpiry!);

  String _generateRandomToken() {
    final random = Random();
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return List.generate(20, (index) => characters[random.nextInt(characters.length)]).join();
  }
}
