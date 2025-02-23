import 'package:lean_requester/lean_requester.dart';

import '../../data/interface/download_datasouce.dart';
import '../entities/download_info.dart';
import 'download_params.dart';

export '../../../../../api/data_source.dart' show DownloadRequest, DownloadError, CancelToken;
export 'download_params.dart';

class DownloadFileUC {
  final DownloadDataSource _dataSource;

  DownloadFileUC(this._dataSource);

  UseCaseResult<DownloadInfo> call(DownloadParams params) async => _dataSource
      .downloadFile(
        params.request,
        pdfSize: params.pdfSize,
      )
      .then((result) => result.fold(
            (failure) => Left(failure),
            (file) => Right(DownloadInfo.fromFile(file)),
          ));
}
