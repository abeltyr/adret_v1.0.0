// ignore: file_names
class ApiException implements Exception {
  String msg;

  ApiException(this.msg);

  @override
  String toString() {
    return msg;
  }
}
