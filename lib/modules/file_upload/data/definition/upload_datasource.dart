import '../../../../api/data_source.dart' show FileOperationRequest, UploadResult;

export '../implementation/upload_datasource_impl.dart';

abstract interface class UploadDataSource {
  static const String uploadUrl = 'https://api.escuelajs.co/api/v1';

  /// Uploads a file to a mock endpoint
  /// Supports different file types: PDF, Image, Document
  ///
  /// Example endpoint: https://example.com/upload/{fileType}
  ///
  /// [fileType] must be one of the supported FileType enum values
  Future<UploadResult> uploadFile(
    FileOperationRequest request, {
    required String filePath,
  });
}
