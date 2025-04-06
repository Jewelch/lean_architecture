import 'package:path_provider/path_provider.dart';

import '../../../../api/data_source.dart';
import '../../domain/enums/pdf_size.dart';
import '../definition/download_datasouce.dart';

export '../definition/download_datasouce.dart';

final class DownloadDataSourceImpl extends FileDownloaderImpl implements DownloadDataSource {
  DownloadDataSourceImpl({
    required Dio client,
    required CacheManager cacheManager,
    required ConnectivityMonitor connectivityMonitor,
  }) : super(client, cacheManager, connectivityMonitor);

  @override
  Future<DownloadResult> downloadFile(
    FileOperationRequest request, {
    required PdfSize pdfSize,
  }) async =>
      download(
        DownloadConfiguration(
          urlPath: "${DownloadDataSource.pdfDownloadUrl}${pdfSize.size}MB",
          savePath: '${(await getApplicationDocumentsDirectory()).path}/sample_${pdfSize.label}.pdf',
          onProgress: request.onProgress,
          cancelToken: request.cancelToken,
          debugIt: true,
        ),
      );
}
