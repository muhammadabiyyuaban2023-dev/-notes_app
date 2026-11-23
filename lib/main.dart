import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'blocs/notes_list_bloc/notes_list_bloc.dart';
import 'blocs/notes_list_bloc/notes_list_event.dart';
import 'repositories/notes_repository.dart';
import 'screens/notes_list_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('notesBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => NotesRepository(Hive.box('notesBox')),
      child: Builder(
        builder: (context) => BlocProvider(
          create: (_) => NotesListBloc(context.read<NotesRepository>())
            ..add(LoadNotes()),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Notes App',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              useMaterial3: true,
            ),
            home: const NotesListScreen(),
          ),
        ),
      ),
    );
  }
}
