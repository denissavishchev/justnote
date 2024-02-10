import 'package:hive/hive.dart';
import 'notes_model.dart';

class Boxes {
  static Box<NotesModel> addNoteToBase() =>
      Hive.box<NotesModel>('notes');

}