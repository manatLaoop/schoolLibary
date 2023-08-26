import 'dart:io';
import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart';
import 'package:schoollibrary/src/model/book_type.dart';



Future<void> deleteBooktypeImage(
    {required String imageNmae, required BookType booktypemodel}) async {
  final appDir = (await getApplicationSupportDirectory()).path;
  final imagePath = '${appDir}/imagetype/$imageNmae';
  File image = File(imagePath);

  if (image.existsSync()) {
    booktypemodel.delete();

    image.deleteSync(recursive: true);
  }
}
