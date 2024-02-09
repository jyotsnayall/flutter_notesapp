import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:uuid/uuid.dart';
import '../models/notes_model.dart';
import 'package:path_provider/path_provider.dart';

part 'notes_store.g.dart';

class NotesStore = _NotesStore with _$NotesStore;

abstract class _NotesStore with Store {
  @observable
  List<NotesModel> notes = ObservableList<NotesModel>();

  @observable
  bool initHiveDB = false;

  @observable
  late Box<NotesModel> box;

  var uuid = Uuid();

  @action
  Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    Hive.registerAdapter(NotesModelAdapter());
    box = await Hive.openBox<NotesModel>('notes');
    print('only opened box');
    notes = box.values.toList().cast<NotesModel>();
    print("opened box and got notes");

    initHiveDB = true;
  }

  @action
  void getNotes() {
    notes = box.values.toList().cast<NotesModel>();
  }

  @action
  void addNote(final String id, final String title, final String description) {
    final note = NotesModel(id: id, title: title, description: description);
    box.add(note);
    getNotes();
  }

  @action
  Future<void> editNote(final NotesModel note, final String title,
      final String description) async {
    var id = note.id;
    print('in function ID: ${id}');
    var updatedNote = NotesModel(id: id, title: title, description: description);

    // final index = notes.indexWhere((element) => element.id == note.id);
    // print(index);
    // if (index != -1) {
    //   notes[index] = updatedNote;
    // }

    await box.put(note.id, updatedNote);
    final debugNotes = box.values.toList().cast<NotesModel>();
    print('edited in box');
    for (var note in debugNotes) {
      print(note.title);
    }
    getNotes();
  }

  @action
  Future<void> removeNote(NotesModel note) async {
    final noteToRemove =
        box.values.firstWhere((element) => element.id == note.id);

    if (noteToRemove != null) {
      await noteToRemove.delete();
    }
    getNotes();
  }

  @action
  void clearNotes() {
    box.clear();
    getNotes();
  }

  @action
  NotesModel fetchNote(String noteId) {
    final  NotesModel note = box.values.firstWhere((element) => element.id == noteId);
    print(note.title+ '\n'+ note.description);
    return note;
  }
}
