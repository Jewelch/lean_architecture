import 'package:equatable/equatable.dart';

import '../../../domain/enums/file_type.dart';

sealed class UploadEvents extends Equatable {
  const UploadEvents();

  @override
  List<Object?> get props => [];
}

final class StartUpload extends UploadEvents {
  final String filePath;
  const StartUpload(this.filePath);

  @override
  List<Object> get props => [filePath];
}

final class CancelUpload extends UploadEvents {
  const CancelUpload();
}

final class ShowPickerOptions extends UploadEvents {
  const ShowPickerOptions();
}

final class PickAndUploadFile extends UploadEvents {
  final PickerSource source;
  const PickAndUploadFile(this.source);

  @override
  List<Object?> get props => [source];
}
