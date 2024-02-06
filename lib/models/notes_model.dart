import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';

part 'notes_model.g.dart';

class NotesModel = _NotesModel with _$NotesModel;

@HiveType(typeId: 0)
abstract class _NotesModel extends HiveObject with Store {
  @HiveField(0)
  @observable
  String title;

  @HiveField(1)
  @observable
  String description;

  _NotesModel({required this.title, required this.description});

  @action
  void setTitle(String value) => title = value;

  @action
  void setDescription(String value) => description = value;
}
