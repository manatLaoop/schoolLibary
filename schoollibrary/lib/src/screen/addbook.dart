// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:developer';

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'package:schoollibrary/src/BLOC/bookImage_bloc/bookimage_bloc.dart';
import 'package:schoollibrary/src/constant/getBook_type.dart';
import 'package:schoollibrary/src/constant/getbook.dart';
import 'package:schoollibrary/src/model/book_model.dart';
import 'package:image_picker_windows/image_picker_windows.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:schoollibrary/src/model/book_type.dart';
import 'package:schoollibrary/src/util/deleta_image.dart';
import 'package:schoollibrary/src/util/paintCustom/addbook_paint.dart';

class Addbook extends StatefulWidget {
  const Addbook({super.key});

  @override
  State<Addbook> createState() => _AddbookState();
}

class _AddbookState extends State<Addbook> {
  // List<Map<String, String>> booktype = [
  //   {'name': 'ภาษาไทย', 'key': 'TH'},
  //   {'name': 'ภาษาอังกฤษ', 'key': 'ENG'},
  //   {'name': 'สังคมศีกษา', 'key': 'SOS'},
  //   {'name': 'คณิตศาสตร์', 'key': 'MAT'},
  //   {'name': 'ประวัตศาสตร์', 'key': 'HIS'},
  //   {'name': 'วิทยาศาสตร์', 'key': 'SCI'},
  //   {'name': 'คอมพิวเตอร์', 'key': 'COM'},
  //   {'name': 'ความรู้ทั่วไป', 'key': 'GET'},
  // ];

  ImagePickerWindows picker = ImagePickerWindows();
  final formKey = GlobalKey<FormState>();

  final GlobalKey _cardBookey = GlobalKey();

  TextEditingController bookname = TextEditingController();
  TextEditingController bookcode = TextEditingController();
  TextEditingController booktypes = TextEditingController();
  TextEditingController bookdtail = TextEditingController();
  TextEditingController bookimage = TextEditingController();
  TextEditingController date = TextEditingController();

  File? _image;

  @override
  @override
  Path getClip(Size size) {
    Path path = Path(); // the starting point is the 0,0 position of the widget.
    path.lineTo(0,
        size.height); // this draws the line from current point to the left bottom position of widget
    path.lineTo(size.width,
        size.height); // this draws the line from current point to the right bottom position of the widget.
    path.lineTo(size.width,
        0); // this draws the line from current point to the right top position of the widget
    path.close();
    // this closes the loop from current position to the starting point of widget
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }

  getBookType GetBookType = getBookType();

  @override
  Widget build(BuildContext context) {
    double screenWith = MediaQuery.of(context).size.width;
    double screenhight = MediaQuery.of(context).size.height;
    List<BookType> dataLIst = getBookType.gettype().values.toList().cast();

    return Scaffold(
      body: Row(
        children: [
          Expanded(
              flex: 4,
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      child: Container(
                        // color: Colors.grey,
                        child: CustomPaint(
                          size: Size(screenWith * 0.2, screenhight),
                          painter: addBookPiant(),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            decoration: ShapeDecoration(
                                shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'เพิ่มหนังสือ',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 200,
                                              height: 200,
                                              decoration: BoxDecoration(
                                                  image: _image == null
                                                      ? DecorationImage(
                                                          image: AssetImage(
                                                              'assets/No-Image.png'))
                                                      : DecorationImage(
                                                          image: FileImage(
                                                              _image!))),
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            TextButton(
                                                onPressed: () async {
                                                  picker
                                                      .getImage(
                                                          source: ImageSource
                                                              .gallery)
                                                      .then((value) {
                                                    if (value != null) {
                                                      setState(() {
                                                        _image =
                                                            File(value.path);
                                                      });

                                                      return;
                                                    }
                                                    return;
                                                  });
                                                },
                                                child: Text('เพิ่มรูปภาพ')),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 45),
                                        child: Container(
                                          child: Form(
                                            key: formKey,
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .3,
                                                  child: TextFormField(
                                                    controller: bookname,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return '';
                                                      }
                                                      return null;
                                                    },
                                                    decoration: InputDecoration(
                                                      labelText: 'ชื่อหนังสือ',
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                ValueListenableBuilder(
                                                  valueListenable:
                                                      Book.boxes().listenable(),
                                                  builder: (context, box, _) {
                                                    List<Bookmodel> data = box
                                                        .values
                                                        .toList()
                                                        .cast<Bookmodel>();
                                                    return Container(
                                                        width:
                                                            MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .3,
                                                        child:
                                                            DropdownButtonFormField(
                                                                validator:
                                                                    (value) {
                                                                  if (value ==
                                                                          null ||
                                                                      booktypes
                                                                              .text ==
                                                                          null ||
                                                                      bookcode.text ==
                                                                          null) {
                                                                    return '';
                                                                  }
                                                                  return null;
                                                                },
                                                                onChanged:
                                                                    (value) {
                                                                  print(value);
                                                                  String code =
                                                                      '${value}-${data.length}${Random().nextInt(1000)}';

                                                                  booktypes
                                                                          .text =
                                                                      value!;
                                                                  bookcode.text =
                                                                      code;
                                                                },
                                                                items: dataLIst
                                                                    .map((e) {
                                                                  return DropdownMenuItem(
                                                                    child: Text(
                                                                        '${e.bookname}'),
                                                                    value: e
                                                                        .booktype,
                                                                  );
                                                                }).toList(),
                                                                decoration:
                                                                    InputDecoration(
                                                                  labelText:
                                                                      'หมวด',
                                                                  filled: true,
                                                                  fillColor:
                                                                      Colors.grey[
                                                                          200],
                                                                )));
                                                  },
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .3,
                                                  child: TextFormField(
                                                    controller: bookdtail,
                                                    maxLines: 5,
                                                    minLines: 5,
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          'รายละเอียดอื่น',
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                      child: TextButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.lightGreen)),
                                    onPressed: () {
                                      setState(() {});
                                      if (formKey.currentState!.validate() &&
                                          _image != null) {
                                        date.text =
                                            'img-${DateTime.now().toUtc().millisecondsSinceEpoch}.png'
                                                .toString();
                                        var data = Bookmodel(
                                            status: true,
                                            bookname: bookname.text,
                                            dtail: bookdtail.text,
                                            bookcode: bookcode.text,
                                            Booktype: booktypes.text,
                                            image: date.text);
                                        final box = Book.boxes();
                                        formKey.currentState!.save();
                                        Saveimage(
                                            image: _image!.path,
                                            date: date.text);
                                        box.add(data);
                                        data.save();

                                        resetFrom(
                                            bookname: bookname,
                                            bookcode: bookcode,
                                            bookdate: date,
                                            booktype: booktypes);
                                        formKey.currentState!.reset();
                                        _image = null;

                                        return;
                                      }

                                      if (_image == null) {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: Row(
                                                children: const [
                                                  Text(
                                                      'คุณยังไม่ได้เลือกรูปหนังสือ'),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Icon(
                                                    Icons.note,
                                                    color: Colors.grey,
                                                  )
                                                ],
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child: Text('ปิด'))
                                              ],
                                            );
                                          },
                                        );
                                      }

                                      return;
                                    },
                                    child: Text(
                                      'บันทึก',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 2,
              child: ValueListenableBuilder(
                valueListenable: Book.boxes().listenable(),
                builder: (context, boxs, _) {
                  List<Bookmodel> data = boxs.values.toList().cast<Bookmodel>();

                  return Container(
                    color: Colors.grey,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 0),
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            color: Material.of(context).color,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'เพิ่มล่าสุด',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GridView.builder(
                              reverse: true,
                              itemCount: data.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                crossAxisCount: 2,
                              ),
                              itemBuilder: (_, int index) {
                                return Card(
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                    width: 30,
                                                    height: 30,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8, top: 8),
                                                      child:
                                                          Text('${index + 1}'),
                                                    )),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text('${data[index].bookname}')
                                              ],
                                            ),
                                            FutureBuilder<File>(
                                              future: getImagePath(
                                                  imagenName: data[index]
                                                      .image
                                                      .toString()),
                                              builder: (context,
                                                  AsyncSnapshot<File>
                                                      snapshot) {
                                                if (snapshot.hasData) {
                                                  return SingleChildScrollView(
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .5,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .1,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Visibility(
                                                          child: Image.file(
                                                              snapshot.data!,
                                                              fit:
                                                                  BoxFit.cover),
                                                        ),
                                                      ),
                                                      decoration:
                                                          BoxDecoration(),
                                                    ),
                                                  );
                                                }

                                                if (snapshot.hasError) {}

                                                return CircularProgressIndicator();
                                              },
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                    onPressed: () {},
                                                    child: Text('แก้ไข')),
                                                TextButton(
                                                    onPressed: () async {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            content: Row(
                                                              children: [
                                                                Text(
                                                                    'ยืนยันการลบ ${data[index].bookname}'),
                                                                Icon(Icons
                                                                    .delete)
                                                              ],
                                                            ),
                                                            actions: [
                                                              InkWell(
                                                                onTap: () {
                                                                  deleteBookImage(
                                                                      imageNmae: data[
                                                                              index]
                                                                          .image
                                                                          .toString(),
                                                                      bookmodel:
                                                                          data[
                                                                              index]);

                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Text(
                                                                    'ยืนยัน'),
                                                              )
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Text('ลบ')),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ))
        ],
      ),
    );
  }

  void Saveimage({required String image, required String date}) async {
    final directory = await getApplicationSupportDirectory();
    File imageData = File(image);
    String path = '${directory.path}/image/';

    Directory dri = Directory(path);
    if (await dri.exists()) {
      final saveimg = await imageData.copy('${directory.path}/image/${date}');
      saveimg.path;
    } else {
      dri.create(recursive: false);
      final saveimg = await imageData.copy('${directory.path}/image/${date}');
      saveimg.path;
    }
  }

  void resetFrom({
    required TextEditingController bookname,
    required TextEditingController booktype,
    required TextEditingController bookcode,
    required TextEditingController bookdate,
  }) {
    bookname.clear();
    booktype.clear();
    bookcode.clear();
    bookimage.clear();
    bookdate.clear();
  }

  Future<File> getImagePath({required String imagenName}) async {
    final directory = await getApplicationSupportDirectory();

    String imagePath = (await getApplicationSupportDirectory()).path;
    print(imagePath);
    File Image = new File('$imagePath/image/$imagenName');
    return Image;
  }
}
