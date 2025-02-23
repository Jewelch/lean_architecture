import '../../../../../api/data_source.dart';
import '../../domain/entities/download_info.dart';
import '../../domain/enums/pdf_size.dart';

sealed class DownloadStates extends Equatable {
  final DownloadState state;

  const DownloadStates({this.state = DownloadState.notStarted});

  @override
  List<Object?> get props => [state];
}

final class DownloadInitial extends DownloadStates {
  const DownloadInitial();
}

final class DownloadSizeSelected extends DownloadStates {
  final PdfSize selectedSize;

  const DownloadSizeSelected(this.selectedSize);

  @override
  List<Object> get props => [selectedSize, state];
}

final class DownloadProgressing extends DownloadStates {
  final DownloadProgress progress;

  const DownloadProgressing(this.progress) : super(state: DownloadState.downloading);

  @override
  List<Object> get props => [progress, state];
}

final class DownloadCompleted extends DownloadStates {
  final DownloadInfo downloadInfo;

  const DownloadCompleted(this.downloadInfo) : super(state: DownloadState.completed);

  @override
  List<Object> get props => [downloadInfo, state];
}

final class DownloadFailed extends DownloadStates {
  final String message;
  final DownloadError error;

  const DownloadFailed({
    required this.message,
    this.error = DownloadError.unexpectedError,
  }) : super(state: DownloadState.failed);

  @override
  List<Object> get props => [message, error, state];
}
