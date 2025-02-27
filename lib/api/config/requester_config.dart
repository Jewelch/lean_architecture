part of '../data_source.dart';

class _RequesterConfig extends RequesterConfiguration {
  _RequesterConfig(
    super.dio,
    super.cacheManager,
    super.connectivityMonitor,
  ) : super(
          authenticationStrategy: JwtAuthentication(),
          baseOptions: BaseOptions(
            baseUrl: AppEnvironment.current.baseUrl,
            connectTimeout: Duration(milliseconds: AppEnvironment.current.connectTimeout),
            sendTimeout: Duration(milliseconds: AppEnvironment.current.sendTimeout),
            receiveTimeout: Duration(milliseconds: AppEnvironment.current.receiveTimeout),
            contentType: ContentType.json.mimeType,
          ),
          commonHeaders: {
            "language": 'Ar',
          },
          queuedInterceptorsWrapper: QueuedInterceptorsWrapper(
            onRequest: (options, handler) => handler.next(options),
            onResponse: (response, handler) => handler.next(response),
            onError: (error, handler) => handler.next(error),
          ),
          maxRetriesPerRequest: 2,
          debuggingEnabled: true,
          logRequestHeaders: true,
        );
}
