import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'models/boxes.dart';
import 'models/notes_model.dart';

class NotesProvider with ChangeNotifier {

  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  int editIndex = 0;
  bool isEdit = true;

  void editNote(int index, String title, String body){
    titleController.text = title;
    bodyController.text = body;
    editIndex = index;
    notifyListeners();
  }

  void editNoteToBase(int index, String title, String body, Box<NotesModel> box){
    box.putAt(index, NotesModel()
        ..title = title
        ..body = body
        ..photo = '0'
        ..audio = '0'
        ..dateTime = DateTime.now().toString()
    );
  }

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
  }

  deleteNote(Box<NotesModel> box, int index){
    box.deleteAt(index);
  }


}