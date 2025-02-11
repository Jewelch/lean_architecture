import 'package:lean_requester/datasource_exp.dart';
import 'package:lean_requester/lean_requester.dart';

import '../app/environment/app_environment.dart';
import 'authentication/jwt_authentication.dart';

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
  int get maxRetriesPerRequest => 2;

  @override
  AuthenticationStrategy? get authenticationStrategy => JwtAuthentication();
}
