import '../../../../api/data_source.dart' show DownloadRequest, Equatable;
import '../enums/pdf_size.dart';

class DownloadParams extends Equatable {
  final DownloadRequest request;
  final PdfSize pdfSize;

  const DownloadParams({
    required this.request,
    required this.pdfSize,
  });

  @override
  List<Object?> get props => [request, pdfSize];
}
