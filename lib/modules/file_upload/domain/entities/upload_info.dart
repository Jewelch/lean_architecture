import '../../data/models/upload_response_model.dart';

class UploadInfo {
  final String originalName;
  final String filename;
  final String location;
  final DateTime uploadedAt;

  UploadInfo({
    required this.originalName,
    required this.filename,
    required this.location,
    required this.uploadedAt,
  });

  factory UploadInfo.fromModel(UploadResponseModel response) => UploadInfo(
        originalName: response.originalName ?? '',
        filename: response.filename ?? '',
        location: response.location ?? '',
        uploadedAt: DateTime.now(),
      );
}
