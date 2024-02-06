import 'package:hive/hive.dart';
import 'package:notesapp/models/notes_model.dart';

class Boxes {
  static Box<NotesModel> getNotes() => Hive.box<NotesModel>('notes');
}
