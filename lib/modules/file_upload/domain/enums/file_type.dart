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
