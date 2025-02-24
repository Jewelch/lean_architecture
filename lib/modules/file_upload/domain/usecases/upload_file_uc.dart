import 'package:lean_requester/usecase_exp.dart';

import '../../data/definition/upload_datasource.dart';
import '../../data/models/upload_response_model.dart';
import '../entities/upload_info.dart';

class UploadFileUC {
  final UploadDataSource _dataSource;

  UploadFileUC(this._dataSource);

  UseCaseResult<UploadInfo> call(UploadUseCaseParams params) async => await _dataSource
      .uploadFile(
        params.request,
        filePath: params.filePath,
      )
      .then((result) => result.fold(
            (failure) => Left(failure),
            (response) => Right(UploadInfo.fromModel(response as UploadResponseModel)),
          ));
}

class UploadUseCaseParams extends Equatable {
  final FileOperationRequest request;
  final String filePath;

  const UploadUseCaseParams({
    required this.request,
    required this.filePath,
  });

  @override
  List<Object?> get props => [request, filePath];
}
