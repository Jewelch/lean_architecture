enum PdfSize {
  mb10(10),
  mb20(20),
  mb30(30),
  mb40(40),
  mb50(50),
  mb100(100),
  mb200(200);

  final int size;
  const PdfSize(this.size);

  String get label => '${size}MB';
}
