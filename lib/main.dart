import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:justnote/provider.dart';
import 'package:justnote/screens/main_screen.dart';
import 'package:provider/provider.dart';
import 'models/notes_model.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NotesModelAdapter());
  await Hive.openBox<NotesModel>('notes');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<NotesProvider>(create: (_) => NotesProvider()),
        ],
          builder: (_, child){
            return const MainScreen();
          },
        ),
    );
  }
}

