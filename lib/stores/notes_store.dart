import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import '../models/notes_model.dart';
import 'package:path_provider/path_provider.dart';

part 'notes_store.g.dart';

class NotesStore = _NotesStore with _$NotesStore;

abstract class _NotesStore with Store {
  @observable
  ObservableList<NotesModel> notes = ObservableList<NotesModel>();

  @observable
  bool initHiveDB = false;

  @observable
  late Box<NotesModel> box;

  @action
  Future<void> init() async {
    print("gonna execute init store");
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    Hive.registerAdapter(NotesModelAdapter());

    print("registered adaptor");

    box = await Hive.openBox<NotesModel>('notes');
    print("opened box");
    notes = box.values.toList().cast<NotesModel>().asObservable();
    print("list");

    initHiveDB = true;
  }

  @action
  void getNotes() {
    notes = box.values.toList().cast<NotesModel>().asObservable();
  }

  @action
  void addNote(final String title, final String description) {
    final note = NotesModel(title: title, description: description);
    box.add(note);
    getNotes();
  }

  @action
  Future<void> editNote(final NotesModel note, final String title,
      final String description) async {
    final updatedNote = NotesModel(title: title, description: description);

    // final index = notes.indexWhere((element) => element.title == note.title);
    // print(index);
    // if (index != -1) {
    //   notes[index] = updatedNote;
    // }

    await box.put(note.title, updatedNote);
    getNotes();
  }

  @action
  Future<void> removeNote(NotesModel note) async {
    final noteToRemove =
        box.values.firstWhere((element) => element.title == note.title);

    if (noteToRemove != null) {
      await noteToRemove.delete();
    }
    getNotes();
  }
}
