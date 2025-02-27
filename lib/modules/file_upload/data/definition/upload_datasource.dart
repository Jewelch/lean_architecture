import '../../../../api/data_source.dart' show FileOperationRequest, UploadResult;

export '../implementation/upload_datasource_impl.dart';

abstract interface class UploadDataSource {
  static const String uploadUrl = 'https://api.escuelajs.co/api/v1';

  /// Uploads a file to the remote server
  /// Supports different file types: PDF, Image, Document
  ///
  /// Base endpoint: https://api.escuelajs.co/api/v1/files/upload
  /// The endpoint will handle different file types internally
  ///
  /// Parameters:
  /// - [request]: Contains metadata about the file operation
  /// - [filePath]: The local path to the file that needs to be uploaded
  ///
  /// Returns:
  /// - [UploadResult] containing the upload status and remote file URL
  ///
  /// Throws:
  /// - [NetworkException] if there's a connection error
  /// - [InvalidFileException] if the file type is not supported
  /// - [UploadException] for other upload-related errors
  Future<UploadResult> uploadFile(
    FileOperationRequest request, {
    required String filePath,
  });
}
