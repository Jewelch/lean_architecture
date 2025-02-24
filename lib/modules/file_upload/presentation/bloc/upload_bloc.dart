import 'package:file_picker/file_picker.dart' as picker;
import 'package:image_picker/image_picker.dart' as image_picker;
import 'package:lean_architecture/app/app_widget.dart';

import '../../../../api/data_source.dart' show CancelToken, FileOperationRequest;
import '../../../../base/bloc/exports.dart';
import '../../domain/enums/file_type.dart';
import '../../domain/usecases/upload_file_uc.dart';
import '../screen/widgets/source_picker_sheet.dart';
import 'events/upload_events.dart';
import 'states/upload_states.dart';

final class UploadBloc extends BaseBloc<UploadEvents, UploadStates> {
  final UploadFileUC _uploadFileUC;
  CancelToken? _cancelToken;

  UploadBloc(this._uploadFileUC) : super(const UploadTypeSelected(FileType.pdf)) {
    on<StartUpload>(_handleStartUpload);
    on<CancelUpload>(_handleCancelUpload);
    on<PickAndUploadFile>(_handlePickAndUploadFile);
    on<ShowPickerOptions>(_handleShowPickerOptions);
  }

  Future<void> _handlePickAndUploadFile(PickAndUploadFile event, Emitter<UploadStates> emit) async {
    String? filePath;

    switch (event.source) {
      case PickerSource.gallery:
        final image = await image_picker.ImagePicker().pickImage(
          source: image_picker.ImageSource.gallery,
        );
        filePath = image?.path;

      case PickerSource.camera:
        final image = await image_picker.ImagePicker().pickImage(
          source: image_picker.ImageSource.camera,
        );
        filePath = image?.path;

      case PickerSource.document:
        final result = await picker.FilePicker.platform.pickFiles(
          type: picker.FileType.custom,
          allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
        );
        filePath = result?.files.single.path;
    }

    if (filePath != null) {
      add(StartUpload(filePath));
    }
  }

  Future<void> _handleStartUpload(StartUpload event, Emitter<UploadStates> emit) async {
    _cancelToken = CancelToken();

    final result = await _uploadFileUC(
      UploadUseCaseParams(
        request: FileOperationRequest(
          cancelToken: _cancelToken,
          onProgress: (progress, total) => emit(UploadProgressing((progress, total))),
        ),
        filePath: event.filePath,
      ),
    );

    result.fold(
      (failure) => emit(UploadFailed(message: failure.message)),
      (uploadInfo) => emit(UploadCompleted(uploadInfo)),
    );
  }

  void _handleCancelUpload(CancelUpload event, Emitter<UploadStates> emit) {
    _cancelToken?.cancel('Upload cancelled by user');
    _cancelToken = null;
  }

  void _handleShowPickerOptions(ShowPickerOptions event, Emitter<UploadStates> emit) {
    SourcePickerSheet.show(
      AppWidget.globalContext!,
      (source) => add(PickAndUploadFile(source)),
    );
  }

  @override
  Future<void> onDispose() async {
    _cancelToken?.cancel();
    super.onDispose();
  }
}
