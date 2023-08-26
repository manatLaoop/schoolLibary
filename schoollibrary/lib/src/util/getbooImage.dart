import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<File> getImage({required String imagename, required String path}) async {
  String dir = (await getApplicationSupportDirectory()).path;

  File imageFile = File('${dir}/$path/$imagename');
  return imageFile;
}
