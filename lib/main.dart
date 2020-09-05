
import 'package:bloc_hive_example/StudentBloc.dart';
import 'package:bloc_hive_example/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'ToDoModel.dart';


const String studentBoxName = 'StudentBox';

void main() async
{

  WidgetsFlutterBinding.ensureInitialized();

  final documents = await getApplicationDocumentsDirectory();
  Hive.init(documents.path);
  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox<Todo>('StudentBox');

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Hive with Bloc',
    home: BlocProvider(
      create: (context) => StudentBloc(InitialState()),
      child: Home(),
    ),
  ));
}
