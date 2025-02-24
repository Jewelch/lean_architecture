import 'package:file_picker/file_picker.dart' as picker;

import '../../../../api/data_source.dart' show CancelToken, FileOperationRequest;
import '../../../../base/bloc/exports.dart';
import '../../domain/enums/file_type.dart';
import '../../domain/usecases/upload_file_uc.dart';
import 'events/upload_events.dart';
import 'states/upload_states.dart';

final class UploadBloc extends BaseBloc<UploadEvents, UploadStates> {
  final UploadFileUC _uploadFileUC;
  CancelToken? _cancelToken;
  FileType _selectedType = FileType.pdf;

  FileType get selectedType => _selectedType;

  UploadBloc(this._uploadFileUC) : super(const UploadTypeSelected(FileType.pdf)) {
    on<StartUpload>(_handleStartUpload);
    on<CancelUpload>(_handleCancelUpload);
    on<UpdateSelectedType>(_handleUpdateSelectedType);
    on<PickAndUploadFile>(_handlePickAndUploadFile);
  }

  void _handleUpdateSelectedType(UpdateSelectedType event, Emitter<UploadStates> emit) {
    _selectedType = event.type ?? _selectedType;
    if (state is! UploadProgressing) {
      emit(UploadTypeSelected(_selectedType));
    }
  }

  Future<void> _handlePickAndUploadFile(PickAndUploadFile event, Emitter<UploadStates> emit) async {
    final result = await picker.FilePicker.platform.pickFiles(
      type: picker.FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      add(StartUpload(result.files.single.path!));
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
        fileType: _selectedType,
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
    emit(UploadTypeSelected(_selectedType));
  }

  @override
  Future<void> onDispose() async {
    _cancelToken?.cancel();
    super.onDispose();
  }
}
