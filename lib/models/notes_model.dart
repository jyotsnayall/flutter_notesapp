import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';

part 'notes_model.g.dart';

class NotesModel = _NotesModel with _$NotesModel;

abstract class _NotesModel extends HiveObject with Store {
  @observable
  String title;

  @observable
  String description;

  @observable
  String id;

  @observable
  bool isPinned;

  _NotesModel({required this.title, required this.description, required this.id, required this.isPinned});


  @action
  void setTitle(String value) => title = value;

  @action
  void setDescription(String value) => description = value;
}
