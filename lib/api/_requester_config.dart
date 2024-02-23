part of "./data_source.dart";

abstract base class _LeanRequesterImpl extends LeanRequester {
  _LeanRequesterImpl(super.dio);

  @override
  BaseOptions baseOptions = BaseOptions(
    baseUrl: AppEnvironment.current.baseUrl,
    connectTimeout: const Duration(milliseconds: 20000),
    sendTimeout: const Duration(milliseconds: 20000),
    receiveTimeout: const Duration(milliseconds: 20000),
    contentType: ContentType.json.mimeType,
  );

  @override
  int mockAwaitDuraitonInMilliseconds = 500;

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
      Debugger.yellow(options.path.toString());
      handler.next(options);
    },
    onResponse: (response, handler) {
      Debugger.green(response.requestOptions.path.toString());
      handler.next(response);
    },
    onError: (error, handler) => handler.next(error),
  );
}
