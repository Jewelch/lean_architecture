import '../../../../api/data_source.dart';
import '../../domain/enums/file_type.dart';
import '../definition/upload_datasource.dart';
import '../models/upload_response_model.dart';

final class UploadDataSourceImpl extends FileUploader implements UploadDataSource {
  UploadDataSourceImpl({
    required Dio client,
    required CacheManager cacheManager,
    required ConnectivityMonitor connectivityMonitor,
  }) : super(client, cacheManager, connectivityMonitor);

  @override
  Future<UploadResult> uploadFile(
    FileOperationRequest request, {
    required String filePath,
    required FileType fileType,
  }) async =>
      await executeRequest(
        UploadConfiguration(
          responseModel: UploadResponseModel(),
          urlPath: '${UploadDataSource.uploadUrl}/files/upload',
          filePath: filePath,
          onProgress: request.onProgress,
          cancelToken: request.cancelToken,
          debugIt: true,
          // mockResponse: {
          //   'url': 'https://cdn.example.com/files/${DateTime.now().millisecondsSinceEpoch}',
          //   'name': filePath.split('/').last,
          //   'size': await File(filePath).length(),
          //   'type': fileType.endpoint,
          //   'uploaded_at': DateTime.now().toIso8601String(),
          // },
        ),
      );
}
