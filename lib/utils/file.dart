// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
import 'package:slugify/slugify.dart';

Future<String> fileLocation(String imageUrl) async {
  final directory = await getApplicationDocumentsDirectory();
  final fileDirectory = directory.path;
  return "$fileDirectory/${slugify('Image-$imageUrl')}.webp";
}
