import 'package:lean_requester/usecase_exp.dart';

import '../../data/definition/download_datasouce.dart';
import '../entities/download_info.dart';
import '../enums/pdf_size.dart';

class DownloadFileUC {
  final DownloadDataSource _dataSource;

  DownloadFileUC(this._dataSource);

  UseCaseResult<DownloadInfo> call(DownloadUseCaseParams params) async => await _dataSource
      .downloadFile(
        params.request,
        pdfSize: params.pdfSize,
      )
      .then((result) => result.fold(
            (failure) => Left(failure),
            (file) => Right(DownloadInfo.fromFile(file)),
          ));
}

class DownloadUseCaseParams extends Equatable {
  final FileOperationRequest request;
  final PdfSize pdfSize;

  const DownloadUseCaseParams({
    required this.request,
    required this.pdfSize,
  });

  @override
  List<Object?> get props => [request, pdfSize];
}
