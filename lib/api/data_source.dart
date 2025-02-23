import 'package:lean_requester/datasource_exp.dart';
import 'package:lean_requester/lean_requester.dart';

import '../app/environment/app_environment.dart';
import 'authentication/jwt_authentication.dart';

export 'package:cg_core_defs/cg_core_defs.dart' show CacheManager, ConnectivityMonitor;
export 'package:lean_requester/datasource_exp.dart';
export 'package:lean_requester/models_exp.dart';

part 'config/requester_config.dart';

abstract base class RestfulConsumer extends _RequesterConfig with RestfulMixin {
  RestfulConsumer(super.dio, super.cacheManager, super.connectivityMonitor);
}

abstract base class FileDownloader extends _RequesterConfig with DownloadMixin {
  FileDownloader(super.dio, super.cacheManager, super.connectivityMonitor);
}

abstract base class FileUploader extends _RequesterConfig with UploadMixin {
  FileUploader(super.dio, super.cacheManager, super.connectivityMonitor);
}
