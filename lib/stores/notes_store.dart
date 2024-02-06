import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:notesapp/boxes/boxes.dart';
import '../models/notes_model.dart';
import 'package:path_provider/path_provider.dart';

part 'notes_store.g.dart';

class NotesStore = _NotesStore with _$NotesStore;

abstract class _NotesStore with Store {
  @observable
  ObservableList<NotesModel> notes = ObservableList<NotesModel>();

  @observable
  bool initHiveDB = false;

  @action
  void addNote(NotesModel note) {
    notes.add(note);

    // todo: save to hive box
  }

  @action
  void removeNote(NotesModel note) {
    notes.remove(note);

    // todo: delete from hive box
  }

  @action
  Future<void> getNotes() async {
    if (!initHiveDB) {
      await initHive();
    }
    var box = await Hive.openBox<NotesModel>('notes');
    notes = box.values.toList().cast<NotesModel>().asObservable();
  }

  Future<void> initHive() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    Hive.registerAdapter(NotesModelAdapter());
    initHiveDB = true;

    await getNotes();
  }
}
