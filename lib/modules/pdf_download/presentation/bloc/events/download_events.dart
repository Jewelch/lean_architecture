import 'package:equatable/equatable.dart';

import '../../../domain/enums/pdf_size.dart';

sealed class DownloadEvents extends Equatable {
  const DownloadEvents();

  @override
  List<Object?> get props => [];
}

final class StartDownload extends DownloadEvents {
  const StartDownload();
}

final class CancelDownload extends DownloadEvents {
  const CancelDownload();
}

final class UpdateSelectedSize extends DownloadEvents {
  final PdfSize size;

  const UpdateSelectedSize(this.size);

  @override
  List<Object?> get props => [size];
}
