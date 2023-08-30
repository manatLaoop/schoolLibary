import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:schoollibrary/src/BLOC/bloc/update_booktype_bloc.dart';
import 'package:schoollibrary/src/constant/getBook_type.dart';
import 'package:schoollibrary/src/model/book_type.dart';

class BookTypeDialog extends StatefulWidget {
  String? booktypedata;
  BookTypeDialog({super.key, String? this.booktypedata});

  @override
  State<BookTypeDialog> createState() => _BookTypeDialogState();
}

class _BookTypeDialogState extends State<BookTypeDialog> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: getBookType.gettype().listenable(),
      builder: (ctx, box, _) {
        List<BookType> data = box.values.toList().cast<BookType>();
        return DropdownButtonFormField(
          decoration: const InputDecoration(
            label: Text('หมวด(ไม่บังคับ)'),
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 2),
            ),
          ),
          items: data
              .map((e) => DropdownMenuItem(
                    child: Text(
                      e.bookname.toString(),
                    ),
                    value: e.booktype,
                  ))
              .toList(),
          onChanged: (String? value) {
            context
                .read<UpdateBooktypeBloc>()
                .add(UpdateBooktypeEvent(booktype: value.toString()));
          },
        );
      },
    );
  }
}
