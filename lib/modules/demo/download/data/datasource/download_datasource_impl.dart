import 'package:path_provider/path_provider.dart';

import '../../../../../api/data_source.dart';
import '../../domain/enums/pdf_size.dart';
import '../interface/download_datasouce.dart';

export '../interface/download_datasouce.dart';

final class DownloadDataSourceImpl extends LeanRequesterConfig implements DownloadDataSource {
  DownloadDataSourceImpl({
    required Dio client,
    required CacheManager cacheManager,
    required ConnectivityMonitor connectivityMonitor,
  }) : super(client, cacheManager, connectivityMonitor);

  @override
  Future<DownloadResult> downloadFile(
    DownloadRequest request, {
    required PdfSize pdfSize,
  }) async {
    return await download(
      configuration: DownloadConfiguration(
        urlPath: "https://link.testfile.org/PDF${pdfSize.size}MB",
        savePath: '${(await getApplicationDocumentsDirectory()).path}/sample_${pdfSize.label}.pdf',
        onReceiveProgress: request.onProgress,
        cancelToken: request.cancelToken,
        debugIt: true,
      ),
    );
  }
}
