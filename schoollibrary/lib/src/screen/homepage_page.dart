// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:schoollibrary/src/BLOC/bookImage_bloc/bookimage_bloc.dart';
import 'package:schoollibrary/src/BLOC/setcode_bloc/setcode_bloc.dart';
import 'package:schoollibrary/src/constant/getbook.dart';
import 'package:schoollibrary/src/model/book_model.dart';
import 'package:schoollibrary/src/model/book_model.dart';
import 'package:schoollibrary/src/screen/addbook.dart';

import 'package:schoollibrary/src/screen/bookAll_page.dart';
import 'package:schoollibrary/src/screen/bookgroup_page.dart';
import 'package:schoollibrary/src/screen/returnOf_page.dart';
import 'package:image_picker_windows/image_picker_windows.dart';
import 'package:schoollibrary/src/util/Dirclear.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  static final _page = [
    BookPage(),
    Addbook(),
    Returnof(),
    BookAll(),
    Returnof()
  ];
  int pageIndex = 0;
  File? _imageFile;

  ImagePickerWindows picker = ImagePickerWindows();
  final _formkey = GlobalKey<FormState>();
  Bookmodel bookmodel = Bookmodel();

  void setPageIndex({required int index}) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    initcode.dispose();
  }

  final TextEditingController initcode = TextEditingController();
  final TextEditingController bookname = TextEditingController();
  final TextEditingController booktypes = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Text('School Library')
          ],
        ),
        actions: [
          width > 1173.6
              ? Row(
                  children: [
                    InkWell(
                      onTap: () => setPageIndex(index: 0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.home,
                                color: Color.fromARGB(246, 11, 201, 125)),
                            SizedBox(
                              width: 5,
                            ),
                            Text('หน้าแรก')
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: () {
                        setPageIndex(index: 1);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              size: 25,
                              Icons.add,
                              color: Colors.amber,
                            ),
                            Text('เพิ่มหนังสือ')
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: () {
                        setPageIndex(index: 2);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () => setPageIndex(index: 2),
                          child: Row(
                            children: [
                              Icon(Icons.book,
                                  color: Color.fromARGB(246, 242, 200, 10)),
                              SizedBox(
                                width: 5,
                              ),
                              Text('จำนวนหนังสือที่ถูกยืมทั้งหมด : 150 เล่ม')
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: () => setPageIndex(index: 3),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.library_books,
                              color: Colors.lightGreen,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ValueListenableBuilder(
                                valueListenable: Book.boxes().listenable(),
                                builder: (context, box, _) {
                                  var datal =
                                      box.values.toList().cast<Bookmodel>();
                                  return Text(
                                      'หนังสือที่เหลือในคลัง : ${datal.length} เล่ม');
                                }),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: () => setPageIndex(index: 4),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.arrow_circle_down),
                            SizedBox(
                              width: 5,
                            ),
                            Text('คืน')
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.arrow_circle_up),
                            SizedBox(
                              width: 5,
                            ),
                            Text('ยืม')
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                  ],
                )
              : Container()
        ],
      ),
      body: _page[pageIndex],
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text('โรงเรียนบ้านละอูบ'),
              currentAccountPicture: CircleAvatar(),
              accountName: null,
            ),
            width < 1173.6
                ? Column(
                    children: [
                      ListTile(
                        onTap: () {
                          setPageIndex(index: 0);
                        },
                        title: Text('หน้าแรก'),
                        leading: Icon(Icons.home,
                            color: Color.fromARGB(246, 201, 11, 43)),
                      ),
                      ListTile(
                        onTap: () {
                          setPageIndex(index: 1);
                          Navigator.pop(context);
                        },
                        title: Text('เพิ่มหนังสือ'),
                        leading: Icon(
                          size: 25,
                          Icons.add,
                          color: Colors.amber,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          setPageIndex(index: 2);
                        },
                        title: Text('จำนวนหนังสือที่ถูกยืม'),
                        leading: Icon(Icons.book,
                            color: Color.fromARGB(246, 242, 200, 10)),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          setPageIndex(index: 3);
                        },
                        title: Text('หนังสือที่เหลือในคลัง'),
                        leading: Icon(
                          Icons.library_books,
                          color: Colors.lightGreen,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        title: Text('คืน'),
                        leading: Icon(Icons.arrow_circle_down,
                            color: Colors.greenAccent),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        title: Text('ยืม'),
                        leading: Icon(
                          Icons.arrow_circle_up,
                          color: Colors.orangeAccent,
                        ),
                      ),
                    ],
                  )
                : Container(),
            ListTile(
                leading: Icon(Icons.settings, color: Colors.orangeAccent),
                title: Text('การตั้งค่า'),
                onTap: () {}),
            ListTile(
              leading: Icon(Icons.account_circle, color: Colors.lightGreen),
              title: Text('จัดการบัญชีผู้ดูแล'),
              onTap: () {},
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(),
                ListTile(
                  leading: Icon(Icons.delete, color: Colors.red),
                  title: Text('ล่างฐานข้อมูล'),
                  onTap: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (BuildContext ctx) {
                        return AlertDialog(
                          content: Text(
                              'หากทำงานยืนยัน จะไม่สามารถกู้คืนข้อมูลได้อีกต่อไป'),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: Text('ยกเลิก')),
                            TextButton(
                                onPressed: () {
                                  Book.boxes().clear();
                                  Dirclear();
                                  Navigator.pop(ctx);
                                },
                                child: Text('ยืนยัน'))
                          ],
                        );
                      },
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('ออกจากระบบ'),
                  onTap: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  InputDecoration inputdecuration(
          {required String label, required IconData icons}) =>
      InputDecoration(
        label: Text(label),
        border: OutlineInputBorder(),
        suffixIcon: Icon(icons),
      );

      
}
