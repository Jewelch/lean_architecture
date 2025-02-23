import '../../../../api/data_source.dart';
import '../../domain/enums/pdf_size.dart';

export '../implementation/download_datasource_impl.dart';

abstract interface class DownloadDataSource {
  /// Downloads a sample PDF file from TestFile.org service
  ///
  /// Available PDF sizes: 10MB, 20MB, 30MB, 40MB, 50MB, 100MB
  /// Source: https://testfile.org/all-pdf-sample-test-file-download-direct/
  ///
  /// Example URLs:
  /// - 10MB PDF: https://link.testfile.org/PDF10MB
  /// - 50MB PDF: https://link.testfile.org/PDF50MB
  /// - 100MB PDF: https://link.testfile.org/PDF100MB
  ///
  /// [pdfFileSize] must be one of: 10, 20, 30, 40, 50, 100 or 200
  ///
  /// Throws [ArgumentError] if [pdfFileSize] is not one of the available sizes
  Future<DownloadResult> downloadFile(
    DownloadRequest request, {
    required PdfSize pdfSize,
  });
}
