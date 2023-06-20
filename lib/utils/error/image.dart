class ImageSizeException implements Exception {
  String msg;

  ImageSizeException(this.msg);

  @override
  String toString() {
    return msg;
  }
}
