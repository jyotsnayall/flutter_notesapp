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
  List<NotesModel> pinnedNotes = ObservableList<NotesModel>();

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
    // notes = box.values.toList().cast<NotesModel>();
    notes = box.values
        .where((element) => !element.isPinned)
        .toList()
        .cast<NotesModel>();
    pinnedNotes = box.values
        .where((element) => element.isPinned == true)
        .toList()
        .cast<NotesModel>();
    print("opened box and got notes");
    for (var note in pinnedNotes) {
      print(note.title);
    }

    initHiveDB = true;
  }

  @action
  Future<void> getBox() async {
    if (Hive.isBoxOpen('notes')) {
      box = Hive.box<NotesModel>('notes');
    } else {
      box = await Hive.openBox<NotesModel>('notes');
    }
  }

  @action
  void getNotes() {
    getBox();
    // notes = box.values.toList().cast<NotesModel>();
    notes = box.values
        .where((element) => !element.isPinned)
        .toList()
        .cast<NotesModel>();
    pinnedNotes = box.values
        .where((element) => element.isPinned == true)
        .toList()
        .cast<NotesModel>();
  }

  @action
  void addNote(final String id, final String title, final String description) {
    final note = NotesModel(
        id: id, title: title, description: description, isPinned: false);
    print('ID in add note: $id');

    getBox();
    box.add(note);
    getNotes();
  }

  @action
  Future<void> editNote(final NotesModel note, final String title,
      final String description) async {
    getBox();
    var id = note.id;
    var updatedNote = NotesModel(
        id: id,
        title: title,
        description: description,
        isPinned: note.isPinned);

    print('ID in edit note: $id');
    print('Note key = ' + note.key.toString());

    await box.put(note.key, updatedNote);
    final debugNotes = box.values.toList().cast<NotesModel>();
    print('edited in box');
    for (var note in debugNotes) {
      print(note.title + note.id);
    }
    getNotes();
    print('Now printing notes----');
    for (var note in notes) {
      print(note.title + note.id);
    }
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
  void togglePin(NotesModel note) {
    getBox();
    // final noteToPin = box.values.firstWhere((element) => element.id == note.id);
    // noteToPin.isPinned = !noteToPin.isPinned;
    note.isPinned = !note.isPinned;
    editNote(note, note.title, note.description);
    getNotes();
  }

  @action
  NotesModel fetchNote(String noteId) {
    // final NotesModel note =
    //     box.values.firstWhere((element) => element.id == noteId);
    // print(note.title + '\n' + note.description);
    // return note;

    getBox();

    try {
      final NotesModel note =
          box.values.firstWhere((element) => element.id == noteId);
      print(note.title + '\n' + note.description);
      return note;
    } catch (e) {
      print('Error fetching note: $e');
      throw Exception('Error fetching note: $e');
    }
  }
}

final store = NotesStore();