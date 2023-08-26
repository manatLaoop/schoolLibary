import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:schoollibrary/src/BLOC/SnackBar_noimage/snackbar_bloc_bloc.dart';
import 'package:schoollibrary/src/BLOC/bloc/update_booktype_bloc.dart';
// import 'package:schoollibrary/src/BLOC/bloc/book_type_edit_bloc.dart';
import 'package:schoollibrary/src/BLOC/bookImage_bloc/bookimage_bloc.dart';
import 'package:schoollibrary/src/BLOC/booktype_editbloc1_bloc/booktype_editbloc1_bloc.dart';
import 'package:schoollibrary/src/BLOC/booktype_image_edit/book_type_edit_bloc.dart';
import 'package:schoollibrary/src/BLOC/editbook2/editbook2_bloc.dart';
import 'package:schoollibrary/src/BLOC/imageBook_type_bloc/image_piker_booktype_bloc.dart';
import 'package:schoollibrary/src/BLOC/setcode_bloc/setcode_bloc.dart';
import 'package:schoollibrary/src/export/page_export.dart';
import 'package:schoollibrary/src/model/book_model.dart';
import 'package:schoollibrary/src/model/book_type.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var directory = await getApplicationSupportDirectory();
  Hive.init(directory.path);
  print(directory);
  Hive.registerAdapter(BookmodelAdapter());

  if (Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(BookTypeAdapter());
  } else {
    Hive.registerAdapter(BookTypeAdapter());
  }
  await Hive.openBox<BookType>('booktype');
  await Hive.openBox<Bookmodel>('book');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Code = BlocProvider<SetcodeBloc>(
      create: (context) => SetcodeBloc(),
    );
    final imageBook = BlocProvider<BookimageBloc>(
      create: (context) => BookimageBloc(),
    );
    final imagePikerBooktypeBloc = BlocProvider<ImagePikerBooktypeBloc>(
        create: (context) => ImagePikerBooktypeBloc());

    final snackbarBlocBloc = BlocProvider<SnackbarBlocBloc>(
      create: (context) => SnackbarBlocBloc(),
    );
    // final imageBooktype = BlocProvider<BookTypeEditBloc>(
    //   create: (context) => BookTypeEditBloc(),
    // );
    final BooktypeEditbloc1Bloc1 = BlocProvider<BooktypeEditbloc1Bloc>(
      create: (context) => BooktypeEditbloc1Bloc(),
    );
    final editbook2Bloc = BlocProvider<Editbook2Bloc>(
      create: (context) => Editbook2Bloc(),
    );
    final updateBooktypeBloc = BlocProvider<UpdateBooktypeBloc>(
      create: (context) => UpdateBooktypeBloc(),
    );

    return MultiBlocProvider(
      providers: [
        Code,
        imageBook,
        imagePikerBooktypeBloc,
        snackbarBlocBloc,
        BooktypeEditbloc1Bloc1,
        editbook2Bloc,
        updateBooktypeBloc

        // imageBooktype
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        // darkTheme: ThemeData.dark(),
        home: const Homepage(),
      ),
    );
  }
}
