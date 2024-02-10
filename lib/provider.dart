import 'package:flutter/material.dart';
import 'models/boxes.dart';
import 'models/notes_model.dart';

class NotesProvider with ChangeNotifier {

  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  final TextEditingController photoController = TextEditingController();
  final TextEditingController audioController = TextEditingController();

  Future addNoteToBase() async {
    final note = NotesModel()
      ..title = titleController.text
      ..body = bodyController.text
      ..photo = photoController.text
      ..audio = audioController.text
      ..dateTime = DateTime.now().toString();
    final box = Boxes.addNoteToBase();
    box.add(note);
  }

}