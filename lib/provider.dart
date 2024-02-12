import 'package:flutter/material.dart';
import 'package:justnote/screens/main_screen.dart';
import 'models/boxes.dart';
import 'models/notes_model.dart';

class NotesProvider with ChangeNotifier {

  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  Future addNoteToBase(context) async {
    final note = NotesModel()
      ..title = titleController.text
      ..body = bodyController.text
      ..photo = '0'
      ..audio = '0'
      ..dateTime = DateTime.now().toString();
    final box = Boxes.addNoteToBase();
    box.add(note);
    titleController.clear();
    bodyController.clear();
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) =>
        const MainScreen()));
  }


}