import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker_windows/image_picker_windows.dart';
import 'package:path_provider/path_provider.dart';
import 'package:schoollibrary/src/BLOC/editbook2/editbook2_bloc.dart';
import 'package:schoollibrary/src/constant/getBook_type.dart';
import 'package:schoollibrary/src/constant/getbook.dart';
import 'package:schoollibrary/src/model/book_model.dart';
import 'package:schoollibrary/src/model/book_type.dart';
import 'package:schoollibrary/src/screen/Excel_export/export_excel.dart';
import 'package:schoollibrary/src/util/getbooImage.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:mime/mime.dart';

class BookAll extends StatefulWidget {
  const BookAll({super.key});

  @override
  State<BookAll> createState() => _BookAllState();
}

class _BookAllState extends State<BookAll> {
  Bookmodel _bookmodels = Bookmodel();
  final _formkey = GlobalKey<FormState>();
  TextEditingController Booksearch = TextEditingController();
  ImagePickerWindows _piker = ImagePickerWindows();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Form(
              //   child: TextField(),
              // )
            ],
          ),
        ),
        ValueListenableBuilder(
          valueListenable: Book.boxes().listenable(),
          builder: (context, box, _) {
            List<Bookmodel> data = box.values.toList().cast<Bookmodel>();

            return ListView.builder(
              shrinkWrap: true,
              reverse: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {},
                  leading: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text('${index + 1}'),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text('${data[index].bookname}'),
                          )),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('รหัสหนังสือ: ${data[index].bookcode}'),
                              data[index].status == true
                                  ? const Icon(
                                      Icons.done,
                                      color: Colors.green,
                                    )
                                  : const Icon(
                                      Icons.remove,
                                      color: Colors.red,
                                    )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  tooltip: 'รายละเอียด',
                                  onPressed: () {
                                    editbook(context, data[index]);
                                  },
                                  icon: const Icon(
                                    Icons.edit_note,
                                    size: 30,
                                    color: Colors.blue,
                                  )),
                              const SizedBox(
                                width: 15,
                              ),
                              IconButton(
                                  tooltip: 'ลบ',
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('ยืนยันการลบ'),
                                          content: Row(
                                            children: [
                                              Text(
                                                data[index].bookname.toString(),
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              const Icon(
                                                Icons.delete,
                                                color: Colors.grey,
                                              )
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('ยกเลิก')),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  delete(data[index]);
                                                  deleteBookimage(
                                                      images: data[index]
                                                          .image
                                                          .toString());
                                                },
                                                child: const Text('ยืนยัน')),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.redAccent,
                                  )),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  subtitle: Text('${data[index].dtail}'),
                );
              },
            );
          },
        ),
      ],
    ));
  }

  void delete(Bookmodel data) async {
    await data.delete();
  }

  Future<dynamic> editbook(BuildContext context, Bookmodel books) {
    TextEditingController booktypes = TextEditingController();
    TextEditingController booknames = TextEditingController();
    TextEditingController images = TextEditingController();
    TextEditingController bookscodes = TextEditingController();
    TextEditingController dtails = TextEditingController();
    TextEditingController Authors = TextEditingController();
    bool imageStatus = false;
    String? NewImage;

    booktypes.text = books.Booktype.toString();
    booknames.text = books.bookname.toString();
    images.text = books.image.toString();
    dtails.text = books.dtail.toString();
    Authors.text = books.Author.toString();
    bookscodes.text = books.bookcode.toString();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('รายละเอียด'),
          content: MediaQuery.of(context).size.width < 560.4
              ? Container(
                  child: Center(
                    child: Text('กรุณาขยาย popup ให้กว้างกว่านี้'),
                  ),
                )
              : Container(
                  // Specify some width
                  width: MediaQuery.of(context).size.width * .4,
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formkey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: FutureBuilder<File>(
                                  future: getImage(
                                      imagename: books.image.toString(),
                                      path: 'image'),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      context.read<Editbook2Bloc>().add(
                                          Addimg(images: snapshot.data!.path));

                                      return BlocBuilder<Editbook2Bloc,
                                          Editbook2State>(
                                        builder: (context, state) {
                                          if (state is Editbook2State) {
                                            if (state.imagePath != null) {
                                              return Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .2,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .2,
                                                child: Image(
                                                    fit: BoxFit.scaleDown,
                                                    image: FileImage(File(
                                                        state.imagePath!))),
                                              );
                                            }
                                            return Container();
                                          } else {
                                            return Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .2,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .2,
                                              child: Image(
                                                  fit: BoxFit.scaleDown,
                                                  image: FileImage(
                                                      snapshot.data!)),
                                            );
                                          }
                                        },
                                      );
                                    }
                                    return Container();
                                  }),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextButton(
                              onPressed: () async {
                                _piker
                                    .getImage(source: ImageSource.gallery)
                                    .then((img) {
                                  if (img != null || img != '') {
                                    imageStatus = true;
                                    NewImage = img!.path;
                                    context
                                        .read<Editbook2Bloc>()
                                        .add(Addimg(images: NewImage));
                                  } else {
                                    return;
                                  }
                                });
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(10),
                                child: Text('เปลี่ยนรูปภาพ'),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * .2,
                              child: Form(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: booknames,
                                      decoration:
                                          bookinputStyle(lable: 'ชื่อหนังสือ'),
                                    ),

                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ValueListenableBuilder(
                                      valueListenable:
                                          getBookType.gettype().listenable(),
                                      builder: (context, box, _) {
                                        List<BookType> typeData = box.values
                                            .toList()
                                            .cast<BookType>();
                                        return DropdownButtonFormField(
                                          onChanged: (value) {},
                                          items: typeData
                                              .map((e) => DropdownMenuItem(
                                                    child: Text(
                                                      e.bookname.toString(),
                                                    ),
                                                  ))
                                              .toList(),
                                          decoration:
                                              bookinputStyle(lable: 'ตัวย่อ'),
                                        );
                                      },
                                    ),

                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: bookscodes,
                                      decoration: bookinputStyle(lable: 'รหัส'),
                                    ),

                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: dtails,
                                      decoration:
                                          bookinputStyle(lable: 'รายละเอียด'),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: Authors,
                                      decoration:
                                          bookinputStyle(lable: 'ผู้เขียน'),
                                    ),

                                    // Text('ชื่อหนังสือ  : ${books.bookname}'),
                                    // Text('รหัส  : ${books.bookcode}'),
                                    // Text('รายละเอียด  : ${books.dtail}'),
                                    // Text('สถานะ  : ${books.status}'),
                                  ],
                                ),
                              ),
                            )
                          ]),
                    ),
                  ),
                ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text('ปิด')),
            TextButton(
                onPressed: () {
                  // if (!_formkey.currentState!.validate()) {
                  if (imageStatus == true) {
                    String date =
                        'img-${DateTime.now().toUtc().millisecondsSinceEpoch}.png'
                            .toString();

                    books.bookname = booknames.text;
                    books.Booktype = booktypes.text;
                    books.bookcode = bookscodes.text;
                    books.image = date;
                    books.dtail = dtails.text;
                    books.Author = Authors.text;
                    imageChange(
                        imageCurent: images.text,
                        newImagePath: NewImage.toString(),
                        newname: date);
                    // books.save();
                  } else {
                    books.bookname = booknames.text;
                    books.Booktype = booktypes.text;
                    books.bookcode = bookscodes.text;
                    books.image = images.text;
                    books.dtail = dtails.text;
                    books.Author = Authors.text;
                  }
                  // }
                  // books.save();

                  Navigator.pop(context);
                },
                child: Text('บันทึก')),
          ],
        );
      },
    );
  }

  Future<void> imageChange(
      {required String imageCurent,
      required String newImagePath,
      required String newname}) async {
    String Dir = (await getApplicationSupportDirectory()).path;

    File curentiimg = File('${Dir}/image/$imageCurent');
    File NewImage = File(newImagePath);

    print(imageCurent);
    print(newImagePath);
    print(newname);

    final imageAdd = await NewImage.copy('${Dir}/image/$newname');
    imageAdd.path;
    final imageDelate = await curentiimg.delete();
  }

  InputDecoration bookinputStyle({required String lable}) {
    return InputDecoration(
      label: Text(lable),
      border: OutlineInputBorder(),
    );
  }

  Future<void> deleteBookimage({required String images}) async {
    String dir = (await getApplicationSupportDirectory()).path;
    File image = File('${dir}/image/$images');

    await image.delete();
  }

  InputDecoration inputdecuration(
          {required String label, required IconData icons}) =>
      InputDecoration(
          label: Text(label),
          border: OutlineInputBorder(),
          suffixIcon: Icon(icons));
}
