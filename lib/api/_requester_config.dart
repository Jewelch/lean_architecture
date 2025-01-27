part of "./data_source.dart";

abstract base class _LeanRequesterImpl extends LeanRequester {
  _LeanRequesterImpl(
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
  int mockAwaitDuraitonInMilliseconds = 500;

  @override
  bool deuggingEnabled = false;
  @override
  bool mockingModeEnabled = false;
  @override
  bool logRequestHeaders = false;
  @override
  bool logResponseHeaders = false;
  @override
  bool logRequestTimeout = false;

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
}
