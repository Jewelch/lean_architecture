import '../../../../../api/data_source.dart';
import '../../../domain/entities/download_info.dart';
import '../../../domain/enums/pdf_size.dart';

sealed class DownloadStates extends Equatable {
  final FileOperationState state;

  const DownloadStates({this.state = FileOperationState.notStarted});

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
  final OperationProgress progress;

  const DownloadProgressing(this.progress) : super(state: FileOperationState.downloading);

  @override
  List<Object> get props => [progress, state];
}

final class DownloadCompleted extends DownloadStates {
  final DownloadInfo downloadInfo;

  const DownloadCompleted(this.downloadInfo) : super(state: FileOperationState.completed);

  @override
  List<Object> get props => [downloadInfo, state];
}

final class DownloadFailed extends DownloadStates {
  final String message;
  final FileOperationError error;

  const DownloadFailed({
    required this.message,
    this.error = FileOperationError.unexpectedError,
  }) : super(state: FileOperationState.failed);

  @override
  List<Object> get props => [message, error, state];
}
