enum FileType {
  pdf('pdf'),
  image('image'),
  document('document');

  final String endpoint;
  const FileType(this.endpoint);

  String get label => name.toUpperCase();
}

enum PickerSource {
  gallery,
  camera,
  document;

  String get label => switch (this) {
        gallery => 'Photo Gallery',
        camera => 'Take Photo',
        document => 'Browse Files',
      };
}
