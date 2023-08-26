// ignore_for_file: unnecessary_new, sort_child_properties_last, unnecessary_const

import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker_windows/image_picker_windows.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:schoollibrary/src/BLOC/SnackBar_noimage/snackbar_bloc_bloc.dart';
import 'package:schoollibrary/src/BLOC/bookImage_bloc/bookimage_bloc.dart';
import 'package:schoollibrary/src/BLOC/booktype_editbloc1_bloc/booktype_editbloc1_bloc.dart';
import 'package:schoollibrary/src/BLOC/imageBook_type_bloc/image_piker_booktype_bloc.dart';
import 'package:schoollibrary/src/constant/getBook_type.dart';
import 'package:schoollibrary/src/model/book_type.dart';
import 'package:schoollibrary/src/util/addbookType.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:schoollibrary/src/util/delate_book_Type.dart';
import 'package:schoollibrary/src/util/getBook_type_image.dart';

class BookPage extends StatefulWidget {
  const BookPage({super.key});
  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  TextEditingController bookname = TextEditingController();
  TextEditingController booktype = TextEditingController();
  TextEditingController imagename = TextEditingController();
  TextEditingController imagePath = TextEditingController();

  TextEditingController imageFordelete = TextEditingController();

  bool imageStatus = false;

  File? _image;
  File? _image2;
  ImagePickerWindows _piker = ImagePickerWindows();

  @override
  void dispose() {
    bookname.dispose();
    booktype.dispose();
    imagename.dispose();
    imagePath.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double W = MediaQuery.of(context).size.width;
    double H = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              style: buttonStyleExcel(
                  colors: const Color.fromARGB(255, 5, 142, 87), padding: 17),
              onPressed: () {},
              child: const Text(
                'Export to excel',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            TextButton.icon(
                style: buttonStyle(
                    colors: const Color.fromARGB(221, 11, 108, 126),
                    padding: 15),
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text(
                  'เพิ่มหมวดวิชา',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  imagePath.clear();
                  imagename.clear();
                  bookname.clear();
                  booktype.clear();
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Row(children: const [
                          Icon(Icons.post_add),
                          Text('เพิ่มหมวดหนังสือ')
                        ]),
                        content: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Stack(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 200,
                                      height: 300,
                                      child: Column(
                                        children: [
                                          BlocConsumer<ImagePikerBooktypeBloc,
                                                  ImagePikerBooktypeState>(
                                              builder: (context, state) {
                                                if (state
                                                    is ImagePikerBooktypeState) {
                                                  if (state.image != null) {
                                                    _image =
                                                        File(state.image!.path);

                                                    return Container(
                                                      width: W * 0.1,
                                                      height: H * 0.2,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: FileImage(
                                                                _image!)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(32),
                                                      ),
                                                    );
                                                  }

                                                  return Container(
                                                    width: W * 0.1,
                                                    height: H * 0.2,
                                                    decoration: BoxDecoration(
                                                        image: const DecorationImage(
                                                            image: AssetImage(
                                                                'assets/No-Image.png')),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(32)),
                                                  );
                                                }
                                                return Container(
                                                  width: W * 0.1,
                                                  height: H * 0.2,
                                                  decoration: BoxDecoration(
                                                      image: const DecorationImage(
                                                          image: AssetImage(
                                                              'assets/No-Image.png')),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              32)),
                                                );
                                              },
                                              listener: (context, state) {}),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextButton(
                                              onPressed: () async {
                                                _piker
                                                    .getImage(
                                                        source:
                                                            ImageSource.gallery)
                                                    .then(
                                                  (imageValue) {
                                                    if (imageValue != null) {
                                                      XFile imageFile =
                                                          imageValue;
                                                      _image =
                                                          File(imageValue.path);
                                                      String date =
                                                          '${DateTime.now().toUtc().millisecondsSinceEpoch}.png';
                                                      imagename.text = date;
                                                      imagePath.text =
                                                          imageValue.path;

                                                      context
                                                          .read<
                                                              ImagePikerBooktypeBloc>()
                                                          .add(
                                                            ImagePikerBooktypeEvent(
                                                                imageEvent:
                                                                    imageFile),
                                                          );
                                                      context
                                                          .read<
                                                              SnackbarBlocBloc>()
                                                          .add(statusFalse());
                                                    } else {
                                                      imagePath.clear();
                                                      imagename.clear();
                                                    }
                                                  },
                                                );
                                              },
                                              child: Text('เพิ่มรูปภาพ'))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 300,
                                      height: 300,
                                      child: Form(
                                        key: _formKey,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            TextFormField(
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return '';
                                                }
                                                return null;
                                              },
                                              controller: bookname,
                                              decoration: inputStyles(
                                                  label: 'ชื่อหมวด',
                                                  icons: Icons.book),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            TextFormField(
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return '';
                                                }
                                                return null;
                                              },
                                              controller: booktype,
                                              decoration: inputStyles(
                                                  label: 'ตัวย่อ',
                                                  icons: Icons.book),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: BlocBuilder<SnackbarBlocBloc,
                                    SnackbarBlocState>(
                                  builder: (context, state) {
                                    if (state is SnackbarBlocState) {
                                      if (state.status == false) {
                                        return Container();
                                      } else {
                                        return Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: const [
                                                const Text(
                                                  'คุณยังไม่ได้เพิ่มรูปภาพ',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                const Icon(
                                                  Icons.error,
                                                  color: Colors.white,
                                                )
                                              ],
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              color: Colors.orange),
                                        );
                                      }
                                    }

                                    return Container();
                                  },
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            _image = null;
                                            context
                                                .read<ImagePikerBooktypeBloc>()
                                                .add(resetImage());
                                            context
                                                .read<SnackbarBlocBloc>()
                                                .add(statusFalse());

                                            imagename.clear();
                                            bookname.clear();
                                            booktype.clear();
                                            imagePath.clear();
                                            Navigator.pop(context);
                                          },
                                          child: Text('ยกเลิก')),
                                      TextButton(
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                    .validate() &&
                                                bookname.text != null &&
                                                booktype.text != null &&
                                                imagename != null &&
                                                imagePath != null &&
                                                _image != null) {
                                              try {
                                                final boxdata =
                                                    getBookType.gettype();
                                                var books = BookType(
                                                    bookname: bookname.text,
                                                    booktype: booktype.text,
                                                    typeImage:
                                                        '${booktype.text}-${imagename.text}');
                                                AddImg(
                                                    imagename:
                                                        '${booktype.text}-${imagename.text}',
                                                    image_path: imagePath.text);

                                                boxdata.add(books);
                                                books.save();
                                                _image = null;
                                                context
                                                    .read<SnackbarBlocBloc>()
                                                    .add(statusFalse());
                                                context
                                                    .read<
                                                        ImagePikerBooktypeBloc>()
                                                    .add(resetImage());
                                                imagename.clear();
                                                bookname.clear();
                                                booktype.clear();
                                                imagePath.clear();

                                                Navigator.pop(context);
                                                return;
                                              } catch (e) {
                                                print(e);
                                                return;
                                              }
                                            } else {
                                              if (_image == null) {
                                                context
                                                    .read<SnackbarBlocBloc>()
                                                    .add(statusTrue());
                                              }

                                              return;
                                            }
                                          },
                                          child: Text('บันทึก')),
                                    ],
                                  ))
                            ],
                          ),
                        ],
                      );
                    },
                  );
                }),
          ],
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: getBookType.gettype().listenable(),
        builder: (context, box, _) {
          List<BookType> data = box.values.toList().cast<BookType>();

          return GridView.builder(
            itemCount: data.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
            ),
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(5),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text('${data[index].bookname}'),
                        FutureBuilder<File>(
                            future: getBookTypeImage(
                                imagename: data[index].typeImage.toString()),
                            builder: (context, AsyncSnapshot<File> snapshot) {
                              if (snapshot.hasData) {
                                File? imageresult = snapshot.data;
                                return Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                  height:
                                      MediaQuery.of(context).size.height * 0.15,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: FileImage(imageresult!))),
                                );
                              }
                              return Container();
                            }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Editbooktype(
                                        Context: context,
                                        data: data[index],
                                        H: H,
                                        W: W);
                                  },
                                );
                              },
                              icon: const Icon(
                                Icons.settings,
                                color: Color.fromARGB(255, 4, 139, 127),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text(
                                          'ยืนยันการลบหมวด ${data[index].bookname}'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              deleteBooktypes(
                                                  Imagepath: data[index]
                                                      .typeImage
                                                      .toString());

                                              data[index].delete();
                                            },
                                            child: Text('ยืนยันการลบ'))
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.delete,
                                  color: Colors.redAccent),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  AlertDialog Editbooktype(
      {required BuildContext Context,
      required BookType data,
      required double W,
      required double H}) {
    TextEditingController imagecurent = TextEditingController();
    TextEditingController bookTypeName = TextEditingController();
    TextEditingController bookType = TextEditingController();
    TextEditingController selectImagePath = TextEditingController();
    bool imageStatus = false;
    bookTypeName.text = data.bookname!;
    bookType.text = data.booktype!;
    return AlertDialog(
      title: const Text('แก้ไขหมวด'),
      content: Container(
        width: W * 0.5,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FutureBuilder<File>(
                    future:
                        getBookTypeImage(imagename: data.typeImage.toString()),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        context
                            .read<BooktypeEditbloc1Bloc>()
                            .add(addimage(images: snapshot.data!.path));
                        imagecurent.text = snapshot.data!.path;
                        return BlocBuilder<BooktypeEditbloc1Bloc,
                            BooktypeEditbloc1State>(
                          builder: (context, state) {
                            if (state is BooktypeEditbloc1State) {
                              if (state.image != null) {
                                return Container(
                                  width: W * 0.1,
                                  height: H * 0.2,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(
                                        File(state.image!),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            }
                            return Container();
                          },
                        );
                      }
                      return Container();
                    }),
                TextButton(
                  onPressed: () {
                    _piker.getImage(source: ImageSource.gallery).then((value) {
                      if (value != null) {
                        selectImagePath.text = value.path;
                        imageStatus = true;
                        Context.read<BooktypeEditbloc1Bloc>()
                            .add(addimage(images: value.path));
                      }
                    });
                  },
                  child: const Text('แก้ไขรูปภาพ'),
                ),
                const SizedBox(
                  height: 60,
                ),
              ],
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(left: 20, right: W * 0.1),
                child: Form(
                  key: _formKey2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                          validator: (value) {
                            if (bookTypeName.text == null ||
                                bookTypeName.text == '') {
                              return '';
                            }

                            return null;
                          },
                          controller: bookTypeName,
                          decoration: inputStyles(
                              icons: Icons.book, label: 'ชื่อหมวด')),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (bookType.text == null || bookType.text == '') {
                            return '';
                          }
                          return null;
                        },
                        controller: bookType,
                        decoration:
                            inputStyles(icons: Icons.book, label: 'ตัวย่อ'),
                      ),
                      const SizedBox(
                        height: 90,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(Context);
          },
          child: const Text('ยกเลิก'),
        ),
        InkWell(
          onTap: () {
            if (_formKey2.currentState!.validate()) {
              String date =
                  '${DateTime.now().toUtc().millisecondsSinceEpoch}.png';
              String newimagename = '${bookType.text}-$date';

              if (imageStatus == true) {
                data.typeImage = newimagename;

                Changeimage(
                    imageSelectPath: selectImagePath.text,
                    imageNewname: newimagename,
                    curentimagepath: imagecurent.text);
                data.bookname = bookTypeName.text;
                data.booktype = bookType.text;
                data.typeImage = newimagename;
                data.save();
              } else {
                data.bookname = bookTypeName.text;
                data.booktype = bookType.text;
                data.typeImage = data.typeImage;
                // data.save();
              }

              Navigator.pop(Context);
              return;
            }

            return;
          },
          child: const Text('บันทึก'),
        ),
      ],
    );
  }

  AlertDialog deletebooktype(
      {required BuildContext ctx,
      required String imagepath,
      required String typename,
      required BookType bookType}) {
    return AlertDialog(
      title: Row(
        children: [
          Text(
            'ยืนยการลบหมวด  $typename',
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: Text('ยกเลิก')),
        TextButton(
            onPressed: () {
              deleteBooktypeImage(
                  imageNmae: imagepath, booktypemodel: bookType);

              Navigator.pop(ctx);
            },
            child: Text('ยืนยัน')),
      ],
    );
  }

  ButtonStyle buttonStyle({required Color colors, required double padding}) {
    return ButtonStyle(
        backgroundColor: MaterialStateProperty.all(colors),
        padding:
            MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(padding)));
  }

  ButtonStyle buttonStyleExcel(
      {required Color colors, required double padding}) {
    return ButtonStyle(
        backgroundColor: MaterialStateProperty.all(colors),
        padding:
            MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(padding)));
  }

  InputDecoration inputStyles(
      {required String label, required IconData icons}) {
    return InputDecoration(
        label: Text(label),
        suffixIcon: Icon(icons),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)));
  }

  Future<void> AddImg(
      {required String imagename, required String image_path}) async {
    final directory = await getApplicationSupportDirectory();
    String path = '${directory.path}/imagetype/';
    File imageresult = File(image_path);
    Directory dir = Directory(path);
    if (await dir.exists()) {
      final saveimage = await imageresult.copy('${path}/${imagename}');
      saveimage.path;
    } else {
      dir.create(recursive: false);
      final saveimage = await imageresult.copy('${path}/${imagename}');
      saveimage.path;
    }
  }

  Future<void> Changeimage({
    required String imageNewname,
    required String imageSelectPath,
    required String curentimagepath,
  }) async {
    String directory = (await getApplicationSupportDirectory()).path;

    File imageresult = File(imageSelectPath);

    final saveimage =
        await imageresult.copy('${directory}/imagetype/${imageNewname}');
    saveimage.path;
    File imageLast = File(curentimagepath);
    final imageRemove = await imageLast.delete();
  }

  Future<void> changeOfbooktypeChange(
      {required String imagecurentPath,
      required String imageNewpath,
      required String newName}) async {
    String directory = (await getApplicationSupportDirectory()).path;

    File NewImage = File(imageNewpath);
    final addImage = await NewImage.copy('${directory}/imagetype/${newName}');
    addImage.path;
    File imagefordelate = File(imagecurentPath);
    await imagefordelate.delete();
  }

  Future<void> deleteBooktypes({required String Imagepath}) async {
    String dir = (await getApplicationSupportDirectory()).path;

    File image = File('${dir}/imagetype/${Imagepath}');
    await image.delete();
  }
}
