import '../../../../base/bloc/exports.dart';
import '../../domain/enums/pdf_size.dart';
import '../../domain/usecases/download_file_uc.dart';
import 'events/download_events.dart';
import 'states/download_states.dart';

final class DownloadBloc extends BaseBloc<DownloadEvents, DownloadStates> {
  final DownloadFileUC _downloadFileUC;
  CancelToken? _cancelToken;
  PdfSize _selectedSize = PdfSize.mb10;

  PdfSize get selectedSize => _selectedSize;

  DownloadBloc(this._downloadFileUC) : super(const DownloadSizeSelected(PdfSize.mb10)) {
    on<StartDownload>(_handleStartDownload);
    on<CancelDownload>(_handleCancelDownload);
    on<UpdateSelectedSize>(_handleUpdateSelectedSize);
  }

  void _handleUpdateSelectedSize(UpdateSelectedSize event, Emitter<DownloadStates> emit) {
    _selectedSize = event.size ?? _selectedSize;
    if (state is! DownloadProgressing) {
      emit(DownloadSizeSelected(_selectedSize));
    }
  }

  Future<void> _handleStartDownload(
    StartDownload event,
    Emitter<DownloadStates> emit,
  ) async {
    _cancelToken = CancelToken();

    final result = await _downloadFileUC(
      DownloadParams(
        request: DownloadRequest(
          cancelToken: _cancelToken,
          onProgress: (progress) {
            emit(DownloadProgressing(progress));
          },
        ),
        pdfSize: _selectedSize,
      ),
    );

    result.fold(
      (failure) => emit(DownloadFailed(message: failure.message)),
      (downloadInfo) => emit(DownloadCompleted(downloadInfo)),
    );
  }

  void _handleCancelDownload(CancelDownload event, Emitter<DownloadStates> emit) {
    _cancelToken?.cancel('Download cancelled by user');
    _cancelToken = null;
    emit(DownloadSizeSelected(_selectedSize));
  }

  @override
  Future<void> onDispose() async {
    _cancelToken?.cancel();
    super.onDispose();
  }
}
