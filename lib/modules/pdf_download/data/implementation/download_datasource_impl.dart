import 'package:path_provider/path_provider.dart';

import '../../../../api/data_source.dart';
import '../../domain/enums/pdf_size.dart';
import '../definition/download_datasouce.dart';

export '../definition/download_datasouce.dart';

final class DownloadDataSourceImpl extends FileDownloader implements DownloadDataSource {
  DownloadDataSourceImpl({
    required Dio client,
    required CacheManager cacheManager,
    required ConnectivityMonitor connectivityMonitor,
  }) : super(client, cacheManager, connectivityMonitor);

  @override
  Future<DownloadResult> downloadFile(
    FileOperationRequest request, {
    required PdfSize pdfSize,
  }) async {
    return await executeRequest(
      DownloadConfiguration(
        urlPath: "https://link.testfile.org/PDF${pdfSize.size}MB",
        savePath: '${(await getApplicationDocumentsDirectory()).path}/sample_${pdfSize.label}.pdf',
        onReceiveProgress: request.onProgress,
        cancelToken: request.cancelToken,
        debugIt: true,
      ),
    );
  }
}
