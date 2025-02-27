import '../app/environment/app_environment.dart';
import 'authentication/jwt_authentication.dart';
import 'data_source.dart';

export 'package:cg_core_defs/cg_core_defs.dart' show CacheManager, ConnectivityMonitor;
export 'package:lean_requester/datasource_exp.dart';
export 'package:lean_requester/models_exp.dart';

part 'config/requester_config.dart';

abstract base class RestfulConsumer extends _RequesterConfig with RestfulMixin {
  RestfulConsumer(
    super.dio,
    super.cacheManager,
    super.connectivityMonitor,
  );
}

abstract base class FileDownloaderImpl extends FileDownloader {
  FileDownloaderImpl(
    Dio dio,
    CacheManager cacheManager,
    ConnectivityMonitor connectivityMonitor,
  ) : super(_RequesterConfig(dio, cacheManager, connectivityMonitor));
}

abstract base class FileUploaderImpl extends FileUploader {
  FileUploaderImpl(
    Dio dio,
    CacheManager cacheManager,
    ConnectivityMonitor connectivityMonitor,
  ) : super(_RequesterConfig(dio, cacheManager, connectivityMonitor));
}
