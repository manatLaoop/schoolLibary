import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:schoollibrary/src/model/book_model.dart';

Future<void> deleteBookImage(
    {required String imageNmae, required Bookmodel bookmodel}) async {
  final appDir = (await getApplicationSupportDirectory()).path;
  final imagePath = '${appDir}/image/$imageNmae';
  File image = File(imagePath);

  if (image.existsSync()) {
    bookmodel.delete();
    image.deleteSync(recursive: true);
  }
}
