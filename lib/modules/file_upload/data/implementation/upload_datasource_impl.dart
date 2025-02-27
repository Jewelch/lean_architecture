import '../../../../api/data_source.dart';
import '../definition/upload_datasource.dart';
import '../models/upload_response_model.dart';

final class UploadDataSourceImpl extends FileUploaderImpl implements UploadDataSource {
  UploadDataSourceImpl({
    required Dio client,
    required CacheManager cacheManager,
    required ConnectivityMonitor connectivityMonitor,
  }) : super(client, cacheManager, connectivityMonitor);

  @override
  Future<UploadResult> uploadFile(
    FileOperationRequest request, {
    required String filePath,
  }) async =>
      await upload(
        UploadConfiguration(
          responseModel: UploadResponseModel(),
          urlPath: '${UploadDataSource.uploadUrl}/files/upload',
          filePath: filePath,
          onProgress: request.onProgress,
          cancelToken: request.cancelToken,
        ),
      );
}
