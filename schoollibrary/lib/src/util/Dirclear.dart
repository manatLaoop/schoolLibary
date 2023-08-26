import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<bool> Dirclear() async {
  Directory appSupportDir = (await getApplicationSupportDirectory());
  String path = '${appSupportDir.path}/image';
  Directory dir = Directory(path);
  List<FileSystemEntity?> files = dir.listSync();
  for (var file in files) {
    if (file is File) {
      await file.delete();
    } else {
      continue;
    }
  }
  return true;
}
