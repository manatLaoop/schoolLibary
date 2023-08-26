import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

Future<File> getBookTypeImage({required String imagename}) async {
  String path = (await getApplicationSupportDirectory()).path;
  File image = File('$path/imagetype/$imagename');
  return image;
}
