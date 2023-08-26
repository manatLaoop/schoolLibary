import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:schoollibrary/src/model/book_model.dart';
import 'package:schoollibrary/src/model/book_type.dart';

Future<void> changeBookTypeImage(
    {required String imagePath, required String newImage}) async {
  final appDir = (await getApplicationSupportDirectory()).path;
  File image = File(imagePath);
  if (image.existsSync()) {
    image.deleteSync(recursive: true);

    
  }
}
