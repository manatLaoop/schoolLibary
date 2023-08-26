// import 'dart:io';

// import 'package:syncfusion_flutter_xlsio/xlsio.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:open_file/open_file.dart';

// Future<void> ExportExcel() async {
//   final Workbook workbook = Workbook();

//   final Worksheet sheet = workbook.worksheets[0];

//   sheet.getRangeByName('A1').setText('ลำดับ');
//   sheet.getRangeByName('A1').setBuiltInStyle(
//         BuiltInStyles.accent5_60,
//       );
//   sheet.getRangeByName('B1').setText('ชื่อหนังสือ');
//   sheet.getRangeByName('C1').setText('หมวดหมู่');
//   sheet.getRangeByName('D1').setText('รหัส');

//   final List<int> bytes = workbook.saveAsStream();
//   workbook.dispose();
//   final String path = (await getApplicationSupportDirectory()).path;

//   final String filename = '$path/ouput.xlsx';
//   final File file = File(filename);
//   await file.writeAsBytes(bytes, flush: true);
//   OpenFile.open(filename);
// }
