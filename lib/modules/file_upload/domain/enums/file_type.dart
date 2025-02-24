enum FileType {
  pdf('pdf'),
  image('image'),
  document('document');

  final String endpoint;
  const FileType(this.endpoint);

  String get label => name.toUpperCase();
}
