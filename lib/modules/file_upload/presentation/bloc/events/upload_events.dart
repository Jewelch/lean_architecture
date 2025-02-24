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

final class UpdateSelectedType extends UploadEvents {
  final FileType? type;
  const UpdateSelectedType(this.type);

  @override
  List<Object?> get props => [type];
}

final class PickAndUploadFile extends UploadEvents {
  const PickAndUploadFile();
}
