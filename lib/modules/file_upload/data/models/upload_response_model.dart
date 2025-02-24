import 'package:lean_requester/models_exp.dart';

class UploadResponseModel extends DAO<UploadResponseModel> {
  final String? originalName;
  final String? filename;
  final String? location;

  UploadResponseModel({
    this.originalName,
    this.filename,
    this.location,
  });

  @override
  UploadResponseModel fromJson(dynamic json) => UploadResponseModel(
        originalName: json?['originalname'],
        filename: json?['filename'],
        location: json?['location'],
      );

  @override
  Map<String, dynamic> toJson() => {};
}
