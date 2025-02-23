import 'dart:io';

class DownloadInfo {
  final File file;
  final String fileName;
  final int size;
  final DateTime downloadedAt;

  DownloadInfo({
    required this.file,
    required this.fileName,
    required this.size,
    required this.downloadedAt,
  });

  factory DownloadInfo.fromFile(File? file) => DownloadInfo(
        file: file ?? File(''),
        fileName: file?.path.split('/').last ?? '',
        size: file?.lengthSync() ?? 0,
        downloadedAt: DateTime.now(),
      );

  bool get exists => file.existsSync();
  String get path => file.path;
  String get formattedSize => '${(size / 1024 / 1024).toStringAsFixed(1)} MB';
}
