class ImageAttr {
  final String id;
  final String imagePath;
  final String tag;
  String altText = "Image";
  final DateTime createdAt;

  ImageAttr({
    required this.id,
    required this.imagePath,
    required this.tag,
    required this.createdAt,
  });
}
