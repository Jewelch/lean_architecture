import 'package:lean_requester/datasource_exp.dart';
import 'package:lean_requester/lean_requester.dart';

import '../app/environment/app_environment.dart';

export 'package:cg_core_defs/cg_core_defs.dart' show CacheManager, ConnectivityMonitor;
export 'package:lean_requester/datasource_exp.dart';
export 'package:lean_requester/models_exp.dart';

abstract base class LeanRequesterConfig extends LeanRequester {
  LeanRequesterConfig(
    super.dio,
    super.cacheManager,
    super.connectivityMonitor,
  );

  @override
  int get maxRetriesPerRequest => 2;

  @override
  BaseOptions baseOptions = BaseOptions(
    baseUrl: AppEnvironment.current.baseUrl,
    connectTimeout: Duration(milliseconds: AppEnvironment.current.connectTimeout),
    sendTimeout: Duration(milliseconds: AppEnvironment.current.sendTimeout),
    receiveTimeout: Duration(milliseconds: AppEnvironment.current.receiveTimeout),
    contentType: ContentType.json.mimeType,
  );

  @override
  QueuedInterceptorsWrapper? queuedInterceptorsWrapper = QueuedInterceptorsWrapper(
    onRequest: (options, handler) {
      handler.next(options);
    },
    onResponse: (response, handler) {
      handler.next(response);
    },
    onError: (error, handler) {
      handler.next(error);
    },
  );

  @override
  AuthenticationStrategy? get authenticationStrategy => JwtAuthentication();
}

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
