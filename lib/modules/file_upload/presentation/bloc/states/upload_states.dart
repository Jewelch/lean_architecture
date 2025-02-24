import 'package:lean_requester/lean_requester.dart';

import '../../../domain/entities/upload_info.dart';
import '../../../domain/enums/file_type.dart';

sealed class UploadStates extends Equatable {
  final FileOperationState state;

  const UploadStates({this.state = FileOperationState.notStarted});

  @override
  List<Object?> get props => [state];
}

final class UploadTypeSelected extends UploadStates {
  final FileType selectedType;

  const UploadTypeSelected(this.selectedType);

  @override
  List<Object> get props => [selectedType, state];
}

final class UploadProgressing extends UploadStates {
  final (int, int) progress;

  const UploadProgressing(this.progress) : super(state: FileOperationState.processing);

  @override
  List<Object> get props => [progress, state];
}

final class UploadCompleted extends UploadStates {
  final UploadInfo uploadInfo;

  const UploadCompleted(this.uploadInfo) : super(state: FileOperationState.completed);

  @override
  List<Object> get props => [uploadInfo, state];
}

final class UploadFailed extends UploadStates {
  final String message;

  const UploadFailed({required this.message}) : super(state: FileOperationState.failed);

  @override
  List<Object> get props => [message, state];
}
